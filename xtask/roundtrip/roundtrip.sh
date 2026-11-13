#!/usr/bin/env bash
# Runs quicktype's own end-to-end fixture suite (test/fixtures.ts) against
# this repository's quicktype binary.  See README.md.
#
#   roundtrip.sh prepare <dir> [--from <quicktype checkout>]
#   roundtrip.sh run <dir> [--bin <command> | --ts] [--results <file>]
#                [--quick] [--cpus <n>] <fixture>[,<fixture>...] [-- <sample>...]
#   roundtrip.sh steps <dir> [--bin <command>] [--jobs <n>]
#   roundtrip.sh compare <ts-results.jsonl> <ours-results.jsonl>
#   roundtrip.sh summary <results.jsonl>...

set -euo pipefail

here="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
repo="$(cd "$here/../.." && pwd)"
patch="$here/harness.patch"
upstream="https://github.com/glideapps/quicktype.git"

die() {
    echo "roundtrip: $*" >&2
    exit 2
}

usage() {
    sed -n '2,11p' "${BASH_SOURCE[0]}" | sed 's/^# \{0,1\}//' >&2
    exit 2
}

# The quicktype commit the port matches (tests/golden/REFERENCE).
reference_commit() {
    sed -n 's/^quicktype_commit=//p' "$repo/tests/golden/REFERENCE"
}

apply_patch() {
    local dir="$1"
    if git -C "$dir" apply --reverse --check "$patch" 2>/dev/null; then
        echo "* harness patch already applied in $dir" >&2
    else
        git -C "$dir" apply "$patch"
        echo "* applied harness patch to $dir" >&2
    fi
}

cmd_prepare() {
    local dir="" from=""
    while [ $# -gt 0 ]; do
        case "$1" in
            --from) from="$2"; shift 2 ;;
            -*) die "unknown option $1" ;;
            *) [ -z "$dir" ] || die "one directory only"; dir="$1"; shift ;;
        esac
    done
    [ -n "$dir" ] || usage
    local commit
    commit="$(reference_commit)"

    if [ -e "$dir/test/fixtures.ts" ]; then
        echo "* $dir already exists; reusing it" >&2
    elif [ -n "$from" ]; then
        # A copy of a checkout that is already installed and built.  The
        # checkout itself is never modified.  `cp -c` clones files on APFS.
        [ -e "$from/dist/index.js" ] || die "$from is not built (npm ci && npm run build)"
        mkdir -p "$(dirname "$dir")"
        cp -Rc "$from" "$dir" 2>/dev/null || cp -R "$from" "$dir"
        rm -rf "$dir/test/runs"
    else
        git clone --quiet --filter=blob:none "$upstream" "$dir"
        git -C "$dir" checkout --quiet --detach "$commit"
        (cd "$dir" && npm ci --no-audit --no-fund && npm run build)
    fi

    local head
    head="$(git -C "$dir" rev-parse HEAD)"
    if [ "$head" != "$commit" ]; then
        echo "roundtrip: warning: $dir is at $head, the port matches $commit" >&2
    fi
    apply_patch "$dir"
}

cmd_run() {
    local dir="" bin="" results="" quick="" cpus="" fixtures="" ts=""
    local samples=()
    while [ $# -gt 0 ]; do
        case "$1" in
            --bin) bin="$2"; shift 2 ;;
            --ts) ts=1; shift ;;
            --results) results="$2"; shift 2 ;;
            --quick) quick=1; shift ;;
            --cpus) cpus="$2"; shift 2 ;;
            --) shift; samples=("$@"); break ;;
            -*) die "unknown option $1" ;;
            *)
                if [ -z "$dir" ]; then dir="$1"
                elif [ -z "$fixtures" ]; then fixtures="$1"
                else die "unexpected argument $1"
                fi
                shift ;;
        esac
    done
    [ -n "$dir" ] && [ -n "$fixtures" ] || usage
    dir="$(cd "$dir" && pwd)"
    git -C "$dir" apply --reverse --check "$patch" 2>/dev/null ||
        die "$dir has no harness patch; run: $0 prepare $dir"

    if [ -n "$ts" ]; then
        bin="node $dir/dist/index.js"
    elif [ -z "$bin" ]; then
        (cd "$repo" && cargo build --release --quiet -p quicktype-cli)
        bin="$repo/target/release/quicktype"
    fi
    if [ -z "$results" ]; then
        results="$dir/roundtrip-results.jsonl"
    fi
    mkdir -p "$(dirname "$results")"
    results="$(cd "$(dirname "$results")" && pwd)/$(basename "$results")"
    : > "$results"

    # Sample paths are relative to the quicktype checkout.
    echo "* $fixtures with $bin -> $results" >&2
    (
        cd "$dir"
        export QUICKTYPE_BIN="$bin" QUICKTYPE_RESULTS="$results" FIXTURE="$fixtures"
        # Every fixture the filter names, not only those `git diff` touches.
        export ALL_FIXTURES=1
        if [ -n "$quick" ]; then export QUICKTEST=true; fi
        if [ -n "$cpus" ]; then export CPUs="$cpus"; fi
        npm run --silent test:fixtures -- ${samples[@]+"${samples[@]}"}
    ) || true
    node "$here/compare.mjs" summary "$results"
}

# The fixtures' later steps as a generation-only differential against the
# TypeScript CLI (later-steps.mts). Needs no language toolchains.
cmd_steps() {
    local dir="" bin="" jobs=4
    while [ $# -gt 0 ]; do
        case "$1" in
            --bin) bin="$2"; shift 2 ;;
            --jobs) jobs="$2"; shift 2 ;;
            -*) die "unknown option $1" ;;
            *) [ -z "$dir" ] || die "one directory only"; dir="$1"; shift ;;
        esac
    done
    [ -n "$dir" ] || usage
    dir="$(cd "$dir" && pwd)"
    git -C "$dir" apply --reverse --check "$patch" 2>/dev/null ||
        die "$dir has no harness patch; run: $0 prepare $dir"
    if [ -z "$bin" ]; then
        (cd "$repo" && cargo build --release --quiet -p quicktype-cli)
        bin="$repo/target/release/quicktype"
    fi
    local work status=0
    work="$(mktemp -d)"
    "$dir/node_modules/.bin/tsx" "$here/later-steps.mts" "$dir" "$bin" "$work" "$jobs" || status=$?
    if [ "$status" -eq 0 ]; then
        rm -rf "$work"
    else
        echo "roundtrip: outputs kept in $work" >&2
    fi
    return "$status"
}

case "${1:-}" in
    prepare) shift; cmd_prepare "$@" ;;
    run) shift; cmd_run "$@" ;;
    steps) shift; cmd_steps "$@" ;;
    compare) shift; exec node "$here/compare.mjs" compare "$@" ;;
    summary) shift; exec node "$here/compare.mjs" summary "$@" ;;
    *) usage ;;
esac
