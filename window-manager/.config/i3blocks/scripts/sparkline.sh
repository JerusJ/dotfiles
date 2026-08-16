# Shared helpers for the i3blocks graph scripts. Sourced, not executed.

STATE_DIR="${XDG_RUNTIME_DIR:-/tmp}/i3blocks"
HISTORY_LEN=24

LOW="#b5bd68"
MID="#e6c547"
HIGH="#cc6666"

mkdir -p "$STATE_DIR"

# icon <codepoint> <colour> -- Nerd Font glyph, written as an escape so the
# literal character never has to survive a copy/paste.
icon() {
    printf "<span foreground=\"$2\">\u$1</span>"
}

# push_history <name> <value> -- append value, keep the last $HISTORY_LEN,
# print the whole window oldest-first.
push_history() {
    local file="$STATE_DIR/$1.hist" hist
    hist="$(cat "$file" 2>/dev/null) $2"
    hist="$(printf '%s' "$hist" | tr -s ' ' '\n' | tail -n "$HISTORY_LEN" | tr '\n' ' ')"
    printf '%s' "$hist" | tee "$file"
}

# sparkline <max> <value>... -- pango markup, one block per sample,
# coloured by how close that sample sits to max.
sparkline() {
    local max=$1
    shift
    awk -v max="$max" -v low="$LOW" -v mid="$MID" -v high="$HIGH" '
    BEGIN {
        split("▁ ▂ ▃ ▄ ▅ ▆ ▇ █", bar, " ")
        if (max <= 0) max = 1
        for (i = 1; i < ARGC; i++) {
            r = ARGV[i] / max
            if (r < 0) r = 0
            if (r > 1) r = 1
            idx = int(r * 7 + 0.5) + 1
            col = (r < 0.5) ? low : (r < 0.8) ? mid : high
            printf "<span foreground=\"%s\">%s</span>", col, bar[idx]
        }
    }' "$@"
}

# level_color <ratio 0..1> -- colour for the numeric readout next to a graph.
level_color() {
    awk -v r="$1" -v low="$LOW" -v mid="$MID" -v high="$HIGH" \
        'BEGIN { print (r < 0.5) ? low : (r < 0.8) ? mid : high }'
}
