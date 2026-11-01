#!/bin/bash
#
# One-line description of what the script does.

readonly DEFAULT_OUTPUT='output.txt'

show_help() {
  cat <<EOF
One-line description of what the script does.

Usage: script_name.sh [OPTIONS] <INPUT>

Arguments:
  <INPUT>  File to read

Options:
  -o, --output <OUTPUT>  File to write [default: ${DEFAULT_OUTPUT}]
  -h, --help             Print help

Examples:
  # Read input.txt and write to the default output
  script_name.sh input.txt

  # Read input.txt and write to result.txt
  script_name.sh --output result.txt input.txt
EOF
}

err() {
  echo "[$(date +'%Y-%m-%dT%H:%M:%S%z')]: $*" >&2
}

#######################################
# Parse the command-line arguments into the caller's local variables.
# Modifies:
#   input_file, output_file
# Reads:
#   DEFAULT_OUTPUT (through show_help)
# Arguments:
#   The arguments passed to the script.
#######################################
parse_args() {
  while (($# > 0)); do
    case "$1" in
      -h | --help)
        show_help
        exit 0
        ;;
      -o | --output)
        output_file="${2:?--output needs a value}"
        shift 2
        ;;
      -*)
        err "unknown option: $1 (see --help)"
        exit 1
        ;;
      *)
        input_file="$1"
        shift
        ;;
    esac
  done
}

main() {
  local input_file=''
  local output_file="${DEFAULT_OUTPUT}"

  parse_args "$@"

  if [[ -z "${input_file}" ]]; then
    err "missing input (see --help)"
    exit 1
  fi

  if [[ ! -f "${input_file}" ]]; then
    err "file not found: ${input_file}"
    exit 1
  fi

  if ! cp "${input_file}" "${output_file}"; then
    err "unable to copy ${input_file} to ${output_file}"
    exit 1
  fi
}

main "$@"
