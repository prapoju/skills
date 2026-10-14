---
name: commit
description: Create a git commit from the current repository changes using the Conventional Commits specification. Use when the user asks to commit changes or create a commit message.
allowed-tools: Bash(git *)
---

# Commit

Create a commit from the current repository changes.

## Usage

Run these commands from your repository root, in order:

```bash
git add -A
```

Read [references/commit-types.md](references/commit-types.md). Then review the
staged changes and think about which commit type and message best describe them:

```bash
git diff --staged
```

Write the commit message using the reference and create the commit:

```bash
git commit -m "<message>"
```
