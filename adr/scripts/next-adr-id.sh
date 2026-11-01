#!/usr/bin/env bash
# Prints the next ADR number, assuming files are named ADR-NNN-slug.md.
# Usage: next-adr-id.sh [adr-dir]

dir="${1:-docs/decisions}"
last=$(ls "$dir" 2>/dev/null | sed -n 's/^ADR-\([0-9]\{3\}\)-.*\.md$/\1/p' | sort -n | tail -1)
printf '%03d\n' $((10#${last:-0} + 1))
