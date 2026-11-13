#!/usr/bin/env bash
# Regenerates tests/golden from the TypeScript reference implementation:
# the fixture corpus (record-hook.cjs + finalize.mjs) and the CLI-behavior
# cases tests/golden/cli-* (record-cli.mjs).
#
#   cargo xtask golden [path-to-quicktype-checkout]
#
# The checkout defaults to $QUICKTYPE_REFERENCE, else the deprecated
# $QUICKTYPE_REF or $QUICKTYPE_DIR (with a one-line warning), else the first
# of ../quicktype and ../../quicktype next to this repository that is built,
# in the same order as `cargo xtask diff` and xtask/reference.mjs.
# QUICKTYPE_REFERENCE=self only applies to the npm differential suite.
#
# The reference must be built (npm ci && npm run build). The commit it was
# recorded from is written to tests/golden/REFERENCE.
set -euo pipefail

HERE="$(cd "$(dirname "$0")" && pwd)"
REWRITE="$(cd "$HERE/../.." && pwd)"

reference_checkout() {
    if [ -n "${1:-}" ]; then
        echo "$1"
        return
    fi
    if [ "${QUICKTYPE_REFERENCE:-}" = self ]; then
        echo "QUICKTYPE_REFERENCE=self only applies to the npm differential suite; set it to a quicktype checkout" >&2
        return 1
    fi
    if [ -n "${QUICKTYPE_REFERENCE:-}" ]; then
        echo "$QUICKTYPE_REFERENCE"
        return
    fi
    local old
    for old in QUICKTYPE_REF QUICKTYPE_DIR; do
        if [ -n "${!old:-}" ]; then
            echo "warning: $old is deprecated; set QUICKTYPE_REFERENCE instead" >&2
            echo "${!old}"
            return
        fi
    done
    local up candidates candidate
    up="$(dirname "$REWRITE")"
    candidates=("$up/quicktype" "$(dirname "$up")/quicktype")
    for candidate in "${candidates[@]}"; do
        if [ -f "$candidate/dist/index.js" ]; then
            echo "$candidate"
            return
        fi
    done
    echo "no built quicktype checkout (with dist/index.js) at ${candidates[0]} or ${candidates[1]}: build one, set QUICKTYPE_REFERENCE or pass its path" >&2
    return 1
}

REF="$(reference_checkout "${1:-}")" || exit 1
REF="$(cd "$REF" && pwd)"
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
echo "* recording CLI-behavior cases (tests/golden/cli-*)"
node "$HERE/record-cli.mjs" "$REF" "$REWRITE/tests/golden" "$REWRITE/tests/inputs"
{
    echo "quicktype_commit=$(git -C "$REF" rev-parse HEAD)"
    echo "node=$(node --version)"
    echo "recorded=$(date -u +%Y-%m-%d)"
} > "$REWRITE/tests/golden/REFERENCE"
echo "* done: $(find "$REWRITE/tests/golden" -name case.json | wc -l | tr -d ' ') cases"
