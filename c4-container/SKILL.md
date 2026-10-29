---
name: c4-container
description: Creates and updates C4 Container (level 2) diagrams as PlantUML rendered to PNG, either from a real codebase or as part of designing a system before or while it is built: the applications and data stores that make up the system, their high-level technology choices, and how they communicate. Use when the user asks to create, change or fix a container diagram or a C4 level 2 diagram, wants to see the apps, services, workers and databases of a system and how they connect, or asks whether something like Redis, Kafka, Nginx or a worker is a container.
---

# C4 Container

## Intent

A container diagram zooms into the system box of the context diagram that already exists (`docs/architecture/c4-context.puml`) and answers these questions:

1. Into which parts does our system split? Each part is either a deployable unit, which can be started, stopped and restarted independently and can run on its own piece of infrastructure, or a data schema or store that the system owns.
2. What are the high-level technology decisions for each of them?
3. How do the containers communicate with each other, and with what protocols?
4. Which containers do the people and external systems interact with?

Its audience is technical people inside and outside the team: developers, architects, and operations or support staff.

## Container types

These count as containers:

- **Server-side web application**: A Java EE web application running on Apache Tomcat, an ASP.NET MVC application running on Microsoft IIS, a Ruby on Rails application running on WEBrick, a Node.js application, etc.
- **Client-side web application**: A JavaScript application running in a web browser using AngularJS, Backbone.JS, jQuery, etc.
- **Client-side desktop application**: A Windows desktop application written using WPF, a macOS desktop application written using Objective-C, a cross-platform desktop application written using JavaFX, etc.
- **Mobile app**: An Apple iOS app, an Android app, a Microsoft Windows Phone app, etc.
- **Server-side console application**: A standalone (e.g. "public static void main") application, a batch process, etc.
- **Microservice**: A single microservice, hosted in anything from a traditional web server to something like Spring Boot, Dropwizard, etc.
- **Serverless function**: A single serverless function (e.g. Amazon Lambda, Azure Function, etc).
- **Database**: A schema or database in a relational database management system, document store, graph database, etc. such as MySQL, Microsoft SQL Server, Oracle Database, MongoDB, Riak, Cassandra, Neo4j, etc.
- **Cache**: A separate cache store the system reads and writes, such as Redis or Memcached. An in-memory cache inside an application is part of that container, not a container itself.
- **Blob or content store**: A blob store (e.g. Amazon S3, Microsoft Azure Blob Storage, etc) or content delivery network (e.g. Akamai, Amazon CloudFront, etc).
- **File system**: A full local file system or a portion of a larger networked file system (e.g. SAN, NAS, etc).
- **Shell script**: A single shell script written in Bash, etc.

The list is not exhaustive.

## Not containers

These don't count as containers:

- **Execution environment**: Apache Tomcat, Microsoft IIS, the JVM, Node.js runtime, etc. It hosts a container, it isn't one. It goes on the deployment diagram.
- **Infrastructure**: Virtual machines, physical servers, Docker containers, Kubernetes clusters, etc. They are where containers run. They go on the deployment diagram.
- **Network devices and traffic routing**: Load balancers, reverse proxies (e.g. Nginx forwarding requests), firewalls, DNS, routers, switches, etc. The team only configures them; they hold no business logic or data. They go on the deployment diagram.
- **Instances, processes and threads**: Three replicas of the same API, or a web server using several processes, are still one container. The counts go on the deployment diagram.
- **The product hosting the data**: The database server or the Kafka cluster itself. The schema or topic the system owns is the container; the server that hosts it goes on the deployment diagram.
- **Code inside a container**: Modules, packages, classes, libraries, frameworks. They are components or code, shown on the component diagram if at all.
- **Systems run by others**: Third-party services and platforms run by other teams. They are external systems, already shown on the context diagram.

