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
                    mv $tmp/${latexStem}.pdf $out
                  '';
                  phases = [ "unpackPhase" "buildPhase" ];
                }
              ;

            };
          });
}
