#!/usr/bin/env bash
# Runs quicktype's own end-to-end fixture suite (test/fixtures.ts) against
# this repository's quickertype binary.  See README.md.
#
#   roundtrip.sh prepare <dir> [--from <quicktype checkout>]
#   roundtrip.sh run <dir> [--bin <command> | --ts] [--results <file>]
#                [--quick] [--cpus <n>] <fixture>[,<fixture>...] [-- <sample>...]
#   roundtrip.sh steps <dir> [--bin <command>] [--jobs <n>] [--work <dir>]
#   roundtrip.sh compare [--fixtures <fixture>[,<fixture>...]]
#                <ts-results.jsonl> <ours-results.jsonl>
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

positive_integer() {
    [[ "$2" =~ ^[1-9][0-9]*$ ]] || die "$1 needs a positive integer, not '$2'"
}

# The quicktype commit the port matches (tests/golden/REFERENCE).
reference_commit() {
    sed -n 's/^quicktype_commit=//p' "$repo/tests/golden/REFERENCE"
}

apply_patch() {
    local dir="$1"
    if git -C "$dir" apply --reverse --check "$patch" 2>/dev/null; then
        echo "* harness patch already applied in $dir" >&2
        return
    fi
    if ! git -C "$dir" apply --check "$patch" 2>/dev/null; then
        # Most likely an older version of the patch: start again from the
        # commit's version of the files it changes.
        local files
        files="$(git -C "$dir" apply --numstat "$patch" | cut -f3)"
        echo "* restoring $(echo "$files" | tr '\n' ' ')in $dir" >&2
        # shellcheck disable=SC2086 # one path per word
        git -C "$dir" checkout HEAD -- $files
    fi
    git -C "$dir" apply "$patch"
    echo "* applied harness patch to $dir" >&2
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
    else
        [ ! -e "$dir" ] || die "$dir exists but is not a quicktype checkout"
        # Built in a sibling directory and renamed when complete, so that a
        # failed copy, clone or build never leaves a half-made $dir behind.
        local partial="$dir.partial"
        rm -rf "$partial"
        mkdir -p "$(dirname "$dir")"
        if [ -n "$from" ]; then
            # A copy of a checkout that is already installed and built.  The
            # checkout itself is never modified.  `cp -c` clones files on
            # APFS; elsewhere it fails, possibly after creating $partial.
            [ -e "$from/dist/index.js" ] || die "$from is not built (npm ci && npm run build)"
            if ! cp -Rc "$from" "$partial" 2>/dev/null; then
                rm -rf "$partial"
                cp -R "$from" "$partial"
            fi
            rm -rf "$partial/test/runs"
        else
            git clone --quiet --filter=blob:none "$upstream" "$partial"
            git -C "$partial" checkout --quiet --detach "$commit"
            (cd "$partial" && npm ci --no-audit --no-fund && npm run build)
        fi
        mv "$partial" "$dir"
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
            --cpus) positive_integer --cpus "$2"; cpus="$2"; shift 2 ;;
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
        die "$dir has no harness patch, or an older one; run: $0 prepare $dir"

    if [ -n "$ts" ]; then
        bin="node $dir/dist/index.js"
    elif [ -z "$bin" ]; then
        (cd "$repo" && cargo build --release --quiet -p quickertype)
        bin="$repo/target/release/quickertype"
    fi
    if [ -z "$results" ]; then
        results="$dir/roundtrip-results.jsonl"
    fi
    mkdir -p "$(dirname "$results")"
    results="$(cd "$(dirname "$results")" && pwd)/$(basename "$results")"
    : > "$results"

    # Sample paths are relative to the quicktype checkout.  With
    # QUICKTYPE_RESULTS the harness records failing tests instead of exiting,
    # so its exit status means it could not run them: an unknown fixture
    # name, a failed fixture setup, a crashed worker.
    echo "* $fixtures with $bin -> $results" >&2
    local status=0
    (
        cd "$dir"
        export QUICKTYPE_BIN="$bin" QUICKTYPE_RESULTS="$results" FIXTURE="$fixtures"
        # Every fixture the filter names, not only those `git diff` touches.
        export ALL_FIXTURES=1
        # These make the fixtures only generate code, not test it.
        unset ONLY_OUTPUT OUTPUT_SNAPSHOT_DIR
        if [ -n "$quick" ]; then export QUICKTEST=true; fi
        if [ -n "$cpus" ]; then export CPUs="$cpus"; fi
        npm run --silent test:fixtures -- ${samples[@]+"${samples[@]}"}
    ) || status=$?
    node "$here/compare.mjs" summary "$results" || true
    if [ "$status" -ne 0 ]; then
        echo "roundtrip: the fixture harness failed (exit status $status)" >&2
        exit "$status"
    fi
    if [ ! -s "$results" ]; then
        echo "roundtrip: no tests ran" >&2
        exit 1
    fi
}

# The fixtures' later steps as a generation-only differential against the
# TypeScript CLI (later-steps.mts). Needs no language toolchains.
cmd_steps() {
    local dir="" bin="" jobs=4 base="$repo/target/roundtrip-steps"
    while [ $# -gt 0 ]; do
        case "$1" in
            --bin) bin="$2"; shift 2 ;;
            --jobs) positive_integer --jobs "$2"; jobs="$2"; shift 2 ;;
            --work) base="$2"; shift 2 ;;
            -*) die "unknown option $1" ;;
            *) [ -z "$dir" ] || die "one directory only"; dir="$1"; shift ;;
        esac
    done
    [ -n "$dir" ] || usage
    dir="$(cd "$dir" && pwd)"
    git -C "$dir" apply --reverse --check "$patch" 2>/dev/null ||
        die "$dir has no harness patch, or an older one; run: $0 prepare $dir"
    if [ -z "$bin" ]; then
        (cd "$repo" && cargo build --release --quiet -p quickertype)
        bin="$repo/target/release/quickertype"
    fi
    # The steps' outputs, in a directory of its own under $base: removed
    # when every step matches, kept (only the mismatching steps) otherwise.
    local work status=0
    mkdir -p "$base"
    work="$(mktemp -d "$(cd "$base" && pwd)/steps.XXXXXX")"
    # Upstream's full selection: the fixtures' getSamples reads these.
    unset QUICKTEST ONLY_OUTPUT OUTPUT_SNAPSHOT_DIR
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
