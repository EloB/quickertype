#!/usr/bin/env bash
# Records the quicktype vs quickertype race with charmbracelet vhs: one real,
# unedited run of both CLIs side by side (tmux) on the same JSON file, with
# measure showing each one's time and memory. Writes race.gif (README),
# race.mp4 (posts) and race-final.png (the last frame).
#
#   xtask/race/record.sh <cards.json> <quicktype command> <quickertype binary> [output dir]
#
# for example, from the repository root:
#   xtask/race/record.sh ~/Downloads/default-cards.json \
#     "node $HOME/src/quicktype/dist/index.js" target/release/quickertype /tmp/race
#
# Each argument can come from the environment instead: CARDS, QUICKTYPE,
# QUICKERTYPE and OUT (the output directory; default: the current one).
# The quicktype command is a command line (absolute paths); it runs with this
# script's PATH. The input is Scryfall's "Default Cards" bulk file (real data,
# about 657 MB): https://scryfall.com/docs/api/bulk-data.
#
# Needs macOS (measure reads /usr/bin/time -l), tmux and vhs (brew install
# vhs). Build quickertype with cargo build --release first, and record on a
# quiet machine (load average under ~3): the video is the run as it happened.

set -euo pipefail

cards=${1:-${CARDS:-}}
quicktype=${2:-${QUICKTYPE:-}}
quickertype=${3:-${QUICKERTYPE:-}}
out=${4:-${OUT:-.}}
die() { echo "record.sh: $*" >&2; exit 1; }
[[ -n $cards && -n $quicktype && -n $quickertype ]] ||
  die "usage: record.sh <cards.json> <quicktype command> <quickertype binary> [output dir]"
[[ -f $cards ]] || die "no such file: $cards"
[[ -x $quickertype ]] || die "not an executable: $quickertype"
command -v vhs >/dev/null || die "vhs not found (brew install vhs)"
command -v tmux >/dev/null || die "tmux not found"

here=$(cd "$(dirname "$0")" && pwd)
quickertype=$(cd "$(dirname "$quickertype")" && pwd)/$(basename "$quickertype")
mkdir -p "$out"
out=$(cd "$out" && pwd)

echo "load average before recording: $(sysctl -n vm.loadavg)" >&2

# The working directory the panes start in: cards.json, tmux.conf and bin/
# (measure, a shim for the quicktype command, a link to quickertype),
# nothing else.
work=$(mktemp -d -t quickertype-race)
cleanup() {
  tmux -L quickertype-race kill-server 2>/dev/null || true
  rm -rf "$work"
}
trap cleanup EXIT
mkdir "$work/bin"
# A clone (APFS copy-on-write: instant, takes no space), else a hard link,
# else a copy.
cp -c "$cards" "$work/cards.json" 2>/dev/null ||
  ln "$cards" "$work/cards.json" 2>/dev/null ||
  cp "$cards" "$work/cards.json"
cp "$here/measure" "$work/bin/measure"
cp "$here/tmux.conf" "$work/tmux.conf"
printf '#!/bin/bash\nPATH=%q\nexec %s "$@"\n' "$PATH" "$quicktype" >"$work/bin/quicktype"
chmod +x "$work/bin/measure" "$work/bin/quicktype"
ln -s "$quickertype" "$work/bin/quickertype"

# Same start for both: read the file once, so both find it in the page
# cache as in the benchmarks (a fresh clone is not cached), and run each
# program once, since macOS checks a new executable file on its first run
# (a few tenths of a second, which would land in the timings).
cat "$work/cards.json" >/dev/null
"$work/bin/measure" true >/dev/null
"$work/bin/quicktype" --version >/dev/null
"$work/bin/quickertype" --version >/dev/null

tmux -L quickertype-race kill-server 2>/dev/null || true
(cd "$work" && vhs "$here/race.tape")

cmp -s "$work/quicktype.ts" "$work/quickertype.ts" ||
  echo "record.sh: warning: the two outputs differ" >&2
mv "$work/race.gif" "$work/race.mp4" "$work/race-final.png" "$out/"
ls -lh "$out/race.gif" "$out/race.mp4" "$out/race-final.png"
