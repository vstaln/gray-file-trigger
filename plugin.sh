#!/bin/sh
here="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
sys="$(uname -s)"
case "$sys" in
MINGW* | MSYS* | CYGWIN*) rel="x86_64-pc-windows-msvc/gray-file-trigger.exe" ;;
Darwin*)
    case "$(uname -m)" in
    arm64) rel="aarch64-apple-darwin/gray-file-trigger" ;;
    *) rel="x86_64-apple-darwin/gray-file-trigger" ;;
    esac ;;
*)
    case "$(uname -m)" in
    aarch64 | arm64) rel="aarch64-unknown-linux-musl/gray-file-trigger" ;;
    *) rel="x86_64-unknown-linux-musl/gray-file-trigger" ;;
    esac ;;
esac
if [ -x "$here/$rel" ]; then exec "$here/$rel" "$@"; fi
for cand in "$here/target/release/gray-file-trigger.exe" "$here/target/release/gray-file-trigger" "$here/target/debug/gray-file-trigger.exe" "$here/target/debug/gray-file-trigger"; do
    if [ -x "$cand" ]; then exec "$cand" "$@"; fi
done
echo "gray-file-trigger binary not found in $here" >&2
exit 1
