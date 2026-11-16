# The quicktype vs quickertype race: one real, unedited run of both CLIs side
# by side on the same file. Run it through record.sh, not directly: that
# prepares the working directory this tape expects (cards.json, tmux.conf,
# and bin/ with measure, quicktype and quickertype) and starts vhs there.

Output race.gif
Output race.mp4

Require tmux

Set Shell "bash"
Set FontFamily "Menlo"
Set FontSize 23
Set LineHeight 1.4
Set Width 1280
Set Height 720
Set Padding 20
Set Framerate 20
Set Theme "GitHub Dark"
Set TypingSpeed 45ms
Set WaitTimeout 3m

# Two panes, typed into together (see tmux.conf).
Hide
Type "tmux -u -L quickertype-race -f tmux.conf attach"
Enter
Sleep 2s
Show

Sleep 800ms
Type "du --si cards.json"
Sleep 400ms
Enter
Sleep 1.5s

# measure quick(er)type cards.json -l ts --just-types -t Cards -o quick(er)type.ts
# Ctrl+E and Ctrl+R type the "er" in the right pane only.
Type "measure quick"
Ctrl+E
Sleep 45ms
Ctrl+R
Sleep 45ms
Type "type cards.json \"
Enter
Type "-l ts --just-types -t Cards \"
Enter
Type "-o quick"
Ctrl+E
Sleep 45ms
Ctrl+R
Sleep 45ms
Type "type.ts"
Sleep 600ms
Enter

# Both panes print "done in ..." when their run exits.
Wait+Screen /done in.*done in/
Sleep 1.2s

# Ctrl+X: from here on, keys go to the left pane only.
Ctrl+X
Type "cmp quicktype.ts quickertype.ts \"
Enter
Type `&& echo "same output, byte for byte"`
Sleep 400ms
Enter
Sleep 2.3s
Screenshot race-final.png
Sleep 700ms
