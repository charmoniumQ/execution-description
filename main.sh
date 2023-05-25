#!/bin/sh
set -e
cd $(dirname $0)
nix build --print-build-logs --keep-failed
cp result/se4rs-main.pdf se4rs/main.pdf
chmod 644 se4rs/main.pdf
unlink result
