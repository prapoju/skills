---
name: adr
description: Create an empty Architecture Decision Record (ADR) or update an existing one, following its numbering and changelog rules. Use when the user asks to create, add, or scaffold an ADR, or to edit, fill in, or refine one, even if they only say "decision record" or name a number like "ADR-003".
---

# ADR

Create empty ADR scaffolds and update existing ADRs. An ADR is a historical
record of why a decision was made, so these rules keep that history intact as
the record changes.

Write only what the user provides. Do not research a topic or invent context,
alternatives, or references.

## Locate the ADRs

Use `docs/decisions/` by default. If it does not exist, search the repository
for `ADR-*.md` and use the directory that holds them. If there are none, create
`docs/decisions/`.

If the directory has an `adr-template.md`, read it first. Its headings take
precedence over the ones in this skill.

## Choose a workflow

- **Create:** the user wants a new ADR for a topic.
- **Update:** the user wants to change an ADR that already exists.

## Create an empty ADR

1. **Get the topic.** Take it from the request; ask if it is missing.
2. **Get the next number** by running
   [scripts/next_adr_id.sh](scripts/next_adr_id.sh) with the ADR directory:

   ```bash
   scripts/next_adr_id.sh <adr-dir>
   ```
3. **Derive the names.**
   - **Slug:** the topic in kebab-case, such as `database-engine-selection`.
   - **Title:** the topic in Title Case.
   - **Filename:** `ADR-<NNN>-<slug>.md`.

   Use the user's own title or slug if they supply one.
4. **Write the file.** Copy [assets/empty-adr.md](assets/empty-adr.md), filling
   in `NNN`, `<Title>`, and today's date as `YYYY-MM-DD`. Leave the section
   bodies empty so the author writes the content. Omit `Last-updated`,
   `Supersedes`, `Superseded by`, and `## Changelog`. Never overwrite an
   existing file.

## Update an existing ADR

1. **Find the ADR** by number, slug, or title. Ask if several match.
2. **Read the whole file.**
3. **Make the edit.**
4. **Record the change.** Filling in an empty section needs no record. If you
   changed existing content, set `**Last-updated:**` to today, adding the field
   after `**Date:**` if it is missing. Then add a bullet to `## Changelog`,
   creating that section at the end of the file if it is missing:

   ```markdown
   - YYYY-MM-DD — What changed and why.
   ```

## Rules for every update

- Never change `**Date:**`. It anchors the decision in time.
- Keep section headings verbatim and in template order.
- Follow the section formats when adding content: `## Alternatives` says why each
  option was discarded, `## Consequences` uses `- (+)` and `- (-)` bullets, and
  `## Confidence level` is a number from 1 to 3 with a brief explanation.
- Remove empty placeholder bullets once their section has real content.
- Never renumber an ADR. Change its slug only if asked, then update any links to
  the old filename.

## Finish

Confirm that the number is unique, the filename matches `ADR-NNN-slug.md`, and
the `# ADR-NNN: Title` heading matches the filename. Report what changed.

Do not edit the ADR index in `README.md`. If you added or renamed a file, tell
the user that the index may need syncing.
