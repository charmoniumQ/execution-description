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
              default = nix-utils-lib.mergeDerivations {
                packageSet = nix-utils-lib.packageSetRec
                  (self: [
                    (nix-documents-lib.markdownDocument {
                      src = ./se4rs;
                      main = "main.md";
                      name = "se4rs-main.tex";
                      outputFormat = "latex";
                      pandocArgs = ["--template=acm-template.tex"];
                      citeproc = false;
                    })
                    (nix-documents-lib.markdownDocument {
                      src = ./se4rs;
                      main = "main.md";
                      name = "se4rs-main.pdf";
                      outputFormat = "pdf";
                      pdfEngine = "xelatex";
                      date = 1684869979; # date +%s
                      pandocArgs = ["--template=acm-template.tex"];
                      citeproc = false;
                      texlivePackages = nix-documents-lib.pandocTexlivePackages // {
                        inherit (pkgs.texlive)
                          acmart
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
                          etoolbox
                          ncctools
                          cmap
                          comment
                          supertabular
                          draftwatermark
                          biblatex-trad
                        ;
                      };
                    })
                  ]);
              };
            };
          });
}
