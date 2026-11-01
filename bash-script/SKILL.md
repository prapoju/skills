---
name: bash-script
description: Create or edit Bash scripts in a fixed style. Use whenever writing, editing, reviewing, or refactoring a shell script or .sh file.
---

# Bash Script

Start new scripts from [script_template.sh](assets/script_template.sh). When
editing, keep the behavior and change only what was asked.

## Simple scripts

A very simple script, such as a few lines with no flags, doesn't need the
template. Write its help as comments below the shebang, using the sections of
the help format that apply, and skip the other rules:

```bash
#!/bin/bash
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
```

## Structure

1. `#!/bin/bash` and a one-line description
2. `readonly` constants, including `DEFAULT_*`
3. `show_help`, `err`, and helpers
4. `parse_args`
5. `main`
6. `main "$@"`

Inside `main`: locals, `parse_args "$@"`, guard clauses, then the work.

## Help

Copy the template's format: description, `Usage`, `Arguments`, `Options`,
`Examples`.

- Always include `-h, --help` and a commented example.
- Mark values as `<REQUIRED>` or `[OPTIONAL]`.
- Align descriptions within each section.
- Read defaults from constants: `[default: ${DEFAULT_OUTPUT}]`.

## Arguments

Use flags, not environment variables. Parse them in `parse_args` with
`while`/`case`/`shift`, setting the locals of `main`.

## Guard clauses

Fail early instead of nesting.

- Run them right after `parse_args`, so `--help` works without dependencies.
- Put checks that don't depend on arguments first.
- Finish validating before building anything.
- Report through `err`, naming the bad value.
- Exit `1` for invalid input and `127` for a missing command.
- In loops, use `continue` instead of `if`/`else`.
- Check commands that can fail: `if ! mv "${file}" "${dest_dir}/"; then`.

## Naming

- `lower_snake_case`: functions, variables, and `.sh` filenames.
- `UPPER_SNAKE_CASE`: constants.
- Suffixes: `_counter` for counters, `_flag` for on/off values, `_dir` for
  directories.
- Be descriptive: `diagrams_dir`, not `dir`.
- Declare `local` separately when the value comes from a command.

## Language

- Quote variables as `"${var}"`.
- Use `[[ ... ]]`, `-z`, `-n`, and `==` for tests.
- Use `(( ... ))` and `$(( ... ))` for numbers.
- Use `$(command)`, not backticks.
- Store lists in arrays and expand them as `"${flags[@]}"`.
- Read command output with `done < <(command)`, not `command | while`.
- Use `./*`, not `*`.
- Prefer builtins over external commands.
- Avoid `eval` and aliases.

## Comments

Comment only tricky code. Document functions that aren't obvious and short, with
the sections that apply, in this order:

```bash
#######################################
# Parse the command-line arguments.
# Modifies:
#   input_file, output_file
# Reads:
#   DEFAULT_OUTPUT (through show_help)
# Arguments:
#   The arguments passed to the script.
# Outputs:
#   Writes errors to stderr.
# Returns:
#   0 on success, non-zero on error.
#######################################
```

## Verify

1. `chmod +x <file>`
2. `bash -n <file>`
3. Run it with `--help` and read the output. Run a simple script normally
   instead.
