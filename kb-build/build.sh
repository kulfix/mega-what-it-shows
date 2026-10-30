#!/bin/sh
# Builds the kb the way the desk exports it: apps/kb/ -> src/, then renders every page into rendered/.
# Needs Node 22 and pnpm on PATH.
set -eu
repo=$(cd "$(dirname "$0")/.." && pwd)
stage=$(mktemp -d "${TMPDIR:-/tmp}/kb-stage.XXXXXX")
cp -R "$repo/apps/kb" "$stage/src"
rm -f "$stage/src/README.md"
cp "$repo/kb-build/app.html" "$stage/src/app.html"
cp "$repo/kb-build/routes/+layout.ts" "$stage/src/routes/+layout.ts"
cp "$repo/kb-build/package.json" "$repo/kb-build/pnpm-lock.yaml" "$repo/kb-build/svelte.config.js" "$repo/kb-build/vite.config.js" "$stage/"
cd "$stage"
pnpm install --frozen-lockfile --reporter=silent || true
node node_modules/vite/bin/vite.js build
rm -rf "$repo/rendered"
cp -R "$stage/rendered" "$repo/rendered"
rm -rf "$stage"
echo "rendered: $repo/rendered"
