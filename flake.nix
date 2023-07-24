{
  inputs = {
    flake-utils = {
      url = "github:numtide/flake-utils";
    };
    nix-utils = {
      url = "github:charmoniumQ/nix-utils";
      inputs = {nixpkgs = {follows = "nixpkgs";};};
    };
    nix-documents = {
      url = "github:charmoniumQ/nix-documents";
      inputs = {nixpkgs = {follows = "nixpkgs";};};
    };
  };
  outputs = { self, nixpkgs, flake-utils, nix-utils, nix-documents }:
    flake-utils.lib.eachDefaultSystem
      (system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
          nix-utils-lib = nix-utils.lib.${system};
          latexDocument =
            { src, name, latexStem, latexTemplate, mainSrc, date, latexmkFlagForEngine }:
            pkgs.stdenvNoCC.mkDerivation {
              src = src;
              name = name;
              buildInputs = [
                (
                  pkgs.texlive.combine {
                    inherit (pkgs.texlive)
                      latexmk
                      scheme-small
                      collection-luatex
                      acmart
                      amsfonts
                      amsmath
                      unicode-math
                      fancyvrb
                      tools
                      booktabs
                      graphics
                      hyperref
                      xcolor
                      ulem
                      geometry
                      setspace
                      babel
                      fontspec
                      selnolig
                      upquote
                      microtype
                      parskip
                      xurl
                      bookmark
                      mdwtools
                      svg
                      etoolbox
                      subfig
                      caption
                      float
                      biblatex
                      xstring
                      iftex
                      xkeyval
                      environ
                      totpages
                      trimspaces
                      textcase
                      hyperxmp
                      ifmtarg
                      ncctools
                      cmap
                      comment
                      supertabular
                      draftwatermark
                      biblatex-trad
                      natbib
                      preprint
                    ;
                  }
                )
              ];
              FONTCONFIG_FILE = pkgs.makeFontsConf { fontDirectories = [ ]; };
              buildPhase = ''
                tmp=$(mktemp --directory)
                HOME=$(mktemp --directory)
                export SOURCE_DATE_EPOCH=${builtins.toString date}
                mkdir $out
                ${pkgs.pandoc}/bin/pandoc --output=$out/${latexStem}.tex --template=${latexTemplate} ${mainSrc}
                ${pkgs.pandoc}/bin/pandoc --output=$out/${latexStem}.docx ${mainSrc}
                latexmk ${latexmkFlagForEngine} -emulate-aux-dir -outdir=$tmp -auxdir=$tmp -Werror $out/${latexStem}
                latexmk_status=$?
                if [ $latexmk_status -ne 0 ]; then
                  mv $tmp/${latexStem}.log $out
                  cat $out/${latexStem}.log
                  echo "Aborting: Latexmk failed"
                  exit $latexmk_status
                fi
                mv $tmp/${latexStem}.pdf $out/
                mv $tmp/${latexStem}.bbl $out/
              '';
              phases = [ "unpackPhase" "buildPhase" ];
            }
          ;
        in
          rec {
            packages = {
              dataset = latexDocument {
                src = nix-utils-lib.mergeDerivations {
                  packageSet = {
                    "." = ./dataset;
                    "common"= ./common;
                  };
                };
                name = "dataset.pdf";
                mainSrc = "main.md";
                latexStem = "dataset";
                latexTemplate = "common/acm-template.tex";
                date = 1684869979; # date +%s
                latexmkFlagForEngine = "-pdf"; # pdfLaTeX vs LuaLaTeX vs XeLaTeX
              };
              se4rs = latexDocument {
                src = nix-utils-lib.mergeDerivations {
                  packageSet = {
                    "." = ./se4rs;
                    "common"= ./common;
                  };
                };
                name = "se4rs";
                mainSrc = "main.md";
                latexStem = "se4rs";
                latexTemplate = "common/acm-template.tex";
                date = 1684869979; # date +%s
                latexmkFlagForEngine = "-pdf"; # pdfLaTeX vs LuaLaTeX vs XeLaTeX
              };
              se4rs-arxiv = pkgs.stdenvNoCC.mkDerivation rec {
                name = "ax";
                latexStem = "se4rs";
                buildInputs = [pkgs.perl pkgs.gnutar];
                unpackPhase = "true";
                buildPhase = ''
                  # https://trevorcampbell.me/html/arxiv.html
                  mkdir tmp
                  cp ${packages.se4rs}/${latexStem}.bbl tmp/main.bbl
                  perl -pe 's/(^|[^\\])%.+/\1%/' < ${packages.se4rs}/${latexStem}.tex > tmp/main.tex
                  # Force LaTeX to rerun
                  echo '\typeout{get arXiv to do 4 passes: Label(s) may have changed. Rerun}' >> tmp/$main.tex
                  mkdir $out
                  tar --create --gzip --file=$out/ax.tar --directory=tmp $(ls tmp)
                '';
                phases = [ "unpackPhase" "buildPhase" ];
              };
              se4rs-pres = pkgs.stdenv.mkDerivation {
                src = nix-utils-lib.mergeDerivations {
                  packageSet = {
                    "." = ./se4rs;
                    "common"= ./common;
                  };
                };
                name = "se4rs-pres";
                buildPhase = ''
                  ${pkgs.pandoc}/bin/pandoc \
                    --citeproc \
                    --bibliography=$src/common/sams-zotero-export.bib \
                    --standalone \
                    --slide-level=2 \
                    --to=revealjs \
                    --output=$out \
                    $src/pres.md
                '';
                installPhase = "true";
              };
            };
          });
}
