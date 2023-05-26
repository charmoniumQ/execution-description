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
          nix-documents-lib = nix-documents.lib.${system};
        in
          {
            packages = {
              default = let
                date = 1684869979; # date +%s
                src = ./se4rs;
                name = "se4rs";
                mainSrc = "main.md";
                latexTemplate = "acm-template.tex";
                texlivePackages = {
                  inherit (pkgs.texlive)
                    latexmk
                    scheme-basic
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
                  ;
                };
                latexStem = "main";
                latexmkFlagForEngine = "-pdf";
              in
                pkgs.stdenvNoCC.mkDerivation {
                  src = src;
                  name = name;
                  buildInputs = [
                    (pkgs.texlive.combine texlivePackages)
                  ];
                  FONTCONFIG_FILE = pkgs.makeFontsConf { fontDirectories = [ ]; };
                  buildPhase = ''
                    tmp=$(mktemp --directory)
                    HOME=$(mktemp --directory)
                    export SOURCE_DATE_EPOCH=${builtins.toString date}
                    set -x +e
                    mkdir $out
                    ${pkgs.pandoc}/bin/pandoc --to=latex --output=$out/${latexStem}.tex --template=${latexTemplate} ${mainSrc}
                    pandoc_success=$?
                    set +x -e
                    if [ $pandoc_success -ne 0 ]; then
                      exit $pandoc_success
                    fi
                    latexmk ${latexmkFlagForEngine} -emulate-aux-dir -outdir=$tmp -auxdir=$tmp -Werror $out/${latexStem}
                    if [ $latexmk_status -ne 0 ]; then
                      mv $tmp/${latexStem}.log $out
                      cat $out/${latexStem}.log
                      echo "Aborting: Latexmk failed"
                      exit $latexmk_status
                    fi
                    mv $tmp/${latexStem}.pdf $out
                    ls -halt $tmp
                  '';
                  phases = [ "unpackPhase" "buildPhase" ];
                }
              ;

            };
          });
}
