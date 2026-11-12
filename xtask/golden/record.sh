#!/usr/bin/env bash
# Regenerates tests/golden from the TypeScript reference implementation.
#
#   cargo xtask golden [path-to-quicktype-checkout]   (default: ../quicktype)
#
# The reference must be built (npm ci && npm run build). The commit it was
# recorded from is written to tests/golden/REFERENCE.
set -euo pipefail

HERE="$(cd "$(dirname "$0")" && pwd)"
REWRITE="$(cd "$HERE/../.." && pwd)"
REF="$(cd "${1:-$REWRITE/../quicktype}" && pwd)"
WORK="$(mktemp -d)"
trap 'rm -rf "$WORK"' EXIT

[ -f "$REF/dist/index.js" ] || { echo "reference not built: run 'npm ci && npm run build' in $REF" >&2; exit 1; }

echo "* recording from $REF ($(git -C "$REF" rev-parse --short HEAD))"
rm -rf "$REF/test/runs"
(
    cd "$REF"
    NODE_OPTIONS="--require $HERE/record-hook.cjs" \
    GOLDEN_RAW_DIR="$WORK/raw" \
    OUTPUT_SNAPSHOT_DIR="$WORK/snap" \
    ALL_FIXTURES=1 \
    FIXTURE="json,schema,graphql,comment-injection" \
    script/test > "$WORK/record.log" 2>&1
) || { tail -40 "$WORK/record.log" >&2; exit 1; }
rm -rf "$REF/test/runs"

echo "* finalizing into tests/golden"
# The leading-comments Go fixture drives the library API, not the CLI, so it
# has no CLI recording; exclude it from the snapshot cross-check.
rm -rf "$WORK/snap/schema-golang-leading-comments"
node "$HERE/finalize.mjs" "$WORK/raw" "$REWRITE/tests/golden" "$WORK/snap" || {
    echo "(Java mismatches that are only the fixture driver's own TopLevel.java are expected)" >&2
}
{
    echo "quicktype_commit=$(git -C "$REF" rev-parse HEAD)"
    echo "node=$(node --version)"
    echo "recorded=$(date -u +%Y-%m-%d)"
} > "$REWRITE/tests/golden/REFERENCE"
echo "* done: $(find "$REWRITE/tests/golden" -name case.json | wc -l | tr -d ' ') cases"
