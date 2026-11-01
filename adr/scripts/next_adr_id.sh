#!/usr/bin/env bash
#
# Print the next ADR number, assuming files are named ADR-NNN-slug.md.
#
# Usage: next_adr_id.sh [ADR_DIR]
#
# Arguments:
#   [ADR_DIR]  Directory holding the ADRs [default: docs/decisions]
#
# Examples:
#   # Get the next number from the default directory
#   next_adr_id.sh
#
#   # Get the next number from docs/adr
#   next_adr_id.sh docs/adr

adr_dir="${1:-docs/decisions}"
last_adr_id=$(ls "${adr_dir}" 2>/dev/null | sed -n 's/^ADR-\([0-9]\{3\}\)-.*\.md$/\1/p' | sort -n | tail -1)
printf '%03d\n' $((10#${last_adr_id:-0} + 1))
