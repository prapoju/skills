---
name: c4-system-context
description: Creates and updates C4 System Context (level 1) diagrams as PlantUML rendered to PNG, either from a real codebase or as part of designing a system before or while it is built: the boundary of the system being built, the people who use it and why, and the external systems around it. Use when the user asks to create, change or fix a system context diagram or a C4 level 1 diagram, wants a big-picture view of a repo or product, or wants to make explicit what is and isn't part of their system.
---

# C4 System Context

A context diagram answers four questions, in this order:

1. What is our scope: what do we consider part of the system we are working on,
   and what is outside it?
2. Who uses it?
3. Why do they use it?
4. How do the system, the people and the other systems interact with each other?

Its audience is technical and non-technical people. Someone who has never seen the code
should understand it in under a minute.

## Two ways to build it

- **From a codebase**: the system exists. Facts come from the code, as described in the
  sections below.
- **As a design**: the system doesn't exist yet, or is about to change. Facts come from the
  user: requirements, documents, conversation. Work through the four questions in order,
  starting with scope, and propose an answer for each so the user can react to something
  concrete. For a decision not made yet, show it as undecided ("Payment provider (to be
  chosen)") instead of inventing a vendor.

The rest of this skill applies to both. In design mode, where a section says to look in
the code, ask the user instead. If a design diagram later gets code behind it, compare
the two and point out where they differ.

## Output

- Use the bundled library, which works offline: `!include <C4/C4_Context>`. Do not
  include from a URL.
- Save as `docs/architecture/c4-context.puml` in the target repo, next to the code it
  describes, so it is maintained with it.
- Write in English. Title: `System Context diagram for <System>`. End with `SHOW_LEGEND()`.
- Use the library's default colors. Color is only useful when it means something, and
  the legend explains the defaults.
- Render with `plantuml -tpng <file>.puml`, then open the PNG and look at it. A diagram
  that compiles can still be unreadable.
- For a complete reference diagram, read `examples/internet-banking.puml` before
  creating a new diagram. You don't need it for small edits.

## Vocabulary

Diagrams are only useful if the team uses the same words for the same things.
Before drawing, read `docs/architecture/vocabulary.md` in the target repo and use its
names for the system, roles and external systems exactly as written.

If it doesn't exist, create it from the names you chose and ask the user to confirm it.
When the diagram needs a term that isn't there yet, add it and tell the user.

## Decide the boundary first

The main job of a context diagram is to make the scope explicit. Everything else
follows from this decision.

- **Inside**: everything the team builds and maintains, even partly: every app, worker
  and data store it runs. It becomes **one** box, with no internal parts.
- **Outside**: everything the team depends on but doesn't control, including systems
  run by other teams in the same organization.
- Configuring something (an identity provider, a cloud service) does not make it part
  of the system. Owning and maintaining it does.

When an element is unclear, don't decide silently. List the borderline cases and your
decision for each in the report, and ask the user to confirm.

## Enterprise boundary

The system boundary answers "what does our team own?". The enterprise boundary answers
"what does our organization own?". Draw it with `Enterprise_Boundary` when that second
question matters:

- Put inside it: the system in scope, other systems run by the same organization, and
  people who belong to the organization (staff, internal teams).
- Leave outside it: third-party systems and people outside the organization (customers,
  the public).
- Skip it when the system is the only thing the organization owns on the diagram. A
  boundary around one box adds nothing.

Who belongs to the organization is often a borderline case (students at a university,
contractors at a company). State your decision and ask the user to confirm.

## Find the people

Look for role enums, auth guards, admin modules, and invitation or onboarding flows.

- Name roles, not individuals, and give each a description: "Student: club member who
  trains and competes". Never an unnamed or generic "User".
- Merge roles that interact with the system the same way (e.g. admin and super admin).
  Keep roles separate when they do different things (e.g. one role proposes content).
- Anything automated (cron, another system, a batch job) is a software system, not a person.
- If a role's purpose can't be confirmed in code, write your best description and flag
  it to the user.

## Find the external systems

Grep **all** the code, not only the services that look like integrations, for:

- external hostnames and API base URLs
- SDK or API clients (payment, email, AI, cloud storage)
- auth strategies (OAuth, OpenID Connect, SAML)
- env vars holding external URLs or API keys

Draw only systems the software or its users talk to **directly**. If something is reached
through another service (problems from site A fetched via aggregator B), draw only B.
Libraries are not external systems.

## Keep the right level of detail

Too much detail makes a diagram worthless. Containers (apps, workers, databases, caches,
queues), components, and infrastructure (Nginx, load balancers, Docker, servers) belong
on lower-level diagrams. Don't show them here, even as labels.

## Names and relationships

- Describe the system by what it does for its users, in plain language, not by its
  technology.
- Avoid meaningless names such as "System", "Backend", "Service" or "API".
- Person → system arrows say **why** the person uses it: "Trains, tracks progress,
  views rankings", not "Uses".
- System → external arrows say what the system uses it for, plus the protocol only when
  it helps a technical reader: "Syncs submissions and problems", "HTTPS".
- Every arrow has a label. The relationships matter as much as the boxes.

## Editing an existing diagram

- Read the existing `.puml` first and change only what was asked. Keep the user's names,
  descriptions and layout hints unless they are wrong.
- If the change comes from new information (a new role, a new integration, a moved
  boundary), check the code for anything else it affects.
- Run the quality check again on the whole diagram, not only the edited part, and re-render.
- If the change affects elements shown on other levels' diagrams, tell the user they may
  need updating too.

## Report

- Give the full paths of the `.puml` and `.png` files.
- State the boundary decisions, especially the borderline cases.
- Separate what was verified (in code or by the user) from what was inferred, and ask the
  user to confirm the inferred parts.
- Say what was merged or left out, and why.

## Quality check

Before finishing, verify that:

- The boundary is explicit, and borderline cases were stated to the user.
- There is exactly one box for the system in scope, with no internal parts.
- If the diagram shows other systems or people from the same organization, an enterprise
  boundary separates them from everything outside it.
- Names match `vocabulary.md`, and no box has a meaningless name.
- Every person is a named role with a description, found in code or confirmed by the user.
- Every person → system arrow says why they use it.
- Every external system was found in code or agreed with the user, and each is used directly.
- No technology, containers or infrastructure appear in boxes or descriptions.
- Colors are the library defaults, explained by the legend.
- The PNG was viewed and no labels overlap.
