---
targets: ["opencode", "claudecode"]
description: "Conventional Commit message rules"
---

# Conventional Commits

A lightweight convention on top of Git commit messages. It gives every commit a
human- and machine-readable meaning, which lets us automate changelogs, version
bumps, and release triggers. The commit history is a way to undertsand the project not just a step to follow.

## Structure

```
<type>[optional scope][!]: <description>

[optional body]

[optional footer(s)]
```

- **type** — required noun describing the kind of change (`feat`, `fix`, etc.).
- **scope** — optional noun in parentheses naming the touched area of the codebase.
- **description** — required short summary in the imperative mood.
- **body** — optional free-form context. Starts one blank line after the description.
- **footers** — optional `token: value` pairs (git trailer style), e.g. `Refs: #123`.

## Breaking Changes

A breaking change is an incompatible change that forces consumers to update how
they use the code. It can appear in a commit of any type and always signals a
SemVer **major** release.

Mark it with `!` immediately before the colon:

```
feat!: drop support for Node 6
```

Or with an uppercase `BREAKING CHANGE:` footer describing what consumers must
change:

```
feat: allow provided config object to extend other configs

BREAKING CHANGE: `extends` key in config file is now used for extending other config files
```

Use `!` for the fast signal, and the footer when the migration needs more than a
line of explanation. Both together are fine — the footer carries the detail.

## Types

- **feat** — a new user-facing capability. Bumps the minor version.
- **fix** — a bug fix. Bumps the patch version.
- **refactor** — a change to code that is neither a fix nor a feature.
- **perf** — a change made for performance.
- **test** — adding or correcting tests.
- **build** — changes to the build system or external dependencies (compilers, bundlers, package versions).
- **ci** — changes to CI configuration and scripts.
- **docs** — documentation only.
- **style** — formatting-only changes with no effect on behavior.
- **chore** — routine maintenance that changes neither source nor tests (tooling config, housekeeping, ai skills).
- **revert** — reverts a previous commit. Reference the reverted SHAs in a footer:

```
revert: let us never again speak of the noodle incident

Refs: 676104e, a215868
```

Only `feat` and `fix` map to a version bump on their own. Every other type
implies no release unless it carries a breaking change.

## Examples

Description with a breaking change footer:

```
feat: allow provided config object to extend other configs

BREAKING CHANGE: `extends` key in config file is now used for extending other config files
```

`!` to draw attention to a breaking change:

```
feat!: send an email to the customer when a product is shipped
```

Scope plus `!`:

```
feat(api)!: send an email to the customer when a product is shipped
```

Both `!` and a `BREAKING CHANGE` footer:

```
feat!: drop support for Node 6

BREAKING CHANGE: use JavaScript features not available in Node 6.
```

No body:

```
docs: correct spelling of CHANGELOG
```

Scope:

```
feat(lang): add Polish language
```

Multi-paragraph body with multiple footers:

```
fix: prevent racing of requests

Introduce a request id and a reference to latest request. Dismiss
incoming responses other than from latest request.

Remove timeouts which were used to mitigate the racing issue but are
obsolete now.

Reviewed-by: Z
Refs: #123
```
