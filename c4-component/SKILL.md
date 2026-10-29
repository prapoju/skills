---
name: c4-component
description: Creates and updates C4 Component (level 3) diagrams as PlantUML rendered to PNG, either from a real codebase or as part of designing a system before or while it is built: the components inside one container, their responsibilities, technology and how they interact. Use when the user asks to create, change or fix a component diagram or a C4 level 3 diagram, wants to see the internal structure of an app, service or worker, or asks whether a module, package or class is a component.
---

# C4 Component

## Intent

A component diagram zooms into one container of the container diagram that already exists (`docs/architecture/c4-container.puml`) and answers these questions:

1. Into which components does the container split? Each component is a grouping of related functionality behind a well-defined interface.
2. What is each component responsible for, and what are its technology and implementation details?


## Component types

Components are not separately deployable units. All the components of a container run inside that container's process and are deployed together with it; anything that is deployed on its own is a container, not a component.

What a component is made of depends on the language:

- **Object-oriented programming languages** (e.g. Java, C#, C++, etc): A component is made up of classes and interfaces.
- **Procedural programming languages** (e.g. C): A component could be made up of a number of C files in a particular directory.
- **JavaScript**: A component could be a JavaScript module, which is made up of a number of objects and functions.
- **Functional programming languages**: A component could be a module (a concept supported by languages such as F#, Haskell, etc), which is a logical grouping of related functions, types, etc.
- **Relational database**: A component could be a logical grouping of functionality, based upon a number of tables, views, stored procedures, functions, triggers, etc.

## Not components

Show only the code that matters to an architecture discussion: code that has its own responsibility and connects to other parts. Leave out code that almost everything uses, because drawing it adds arrows from everything to everything and says nothing about the structure:

- **Domain model classes**: Entities, DTOs, value objects, enums, etc. (e.g. `User`, `Order`, `CreateUserDto`). They are data that most components pass around, not components themselves.
- **Utility classes**: String, date and formatting helpers, shared constants, decorators, guards, middleware, etc. They have no responsibility of their own in the system.

## Map components to the code

There must be a simple and explicit mapping between the components on the diagram and the code when possible.
- Each component matches a real grouping in the codebase: a module, package, folder, a set of classes, or an interface with its implementation. Don't invent groupings that don't exist in the code.
- The diagram must show the architectural style the codebase uses, so a reader recognizes it at a glance. Find the style first; it decides how classes are grouped and how the diagram is laid out, so both vary from one codebase to another:
  - **Layers**: one component per controller, service or repository, with the classes behind it. Not one box per layer. Lay the layers out top to bottom, with arrows going down.
  - **Feature modules**: one component per module, side by side, with arrows between the modules that depend on each other.
  - **Ports and adapters**: the core in the center, and one component per adapter around it.
  - **Another style**: name it to the user and make it visible in the same way.
- Use one convention for the whole diagram. If one component is a module, the others are modules too; don't mix modules, single classes and folders.
- When there are too many modules for one readable diagram, a component can group several related modules. Name the modules it contains in its description (e.g. "Gamification: BadgesModule, PointsModule, StreaksModule") so the mapping stays explicit.
- Show an interface and its implementation as one component, not two.
- If the code has no clear grouping, choose a convention, tell the user which one, and apply it to every component.

## When there are too many components

A diagram with every component of a large container is unreadable. When the components don't fit on one readable diagram, suggest to the user that they define a scope or a purpose first, and draw one diagram for each:

- **A feature or use case**: only the components involved in it (e.g. "Signing in", "Awarding badges").
- **An area of the container**: one diagram per group of related modules.
- **A question to answer**: only the components needed to answer it (e.g. "What talks to the payment provider?").

Put the scope in the title (`Component diagram for <System> - <Container> - <Scope>`) so the reader knows the diagram is partial. Grouping several modules into one component (see "Map components to the code") is the other way to reduce the number of boxes; tell the user both options and let them choose.
