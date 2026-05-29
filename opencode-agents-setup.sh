#!/usr/bin/env bash
set -euo pipefail

PROJECT_NAME="${1:-Roofer Hosting}"

echo "Setting up OpenCode system for: $PROJECT_NAME"

mkdir -p .opencode/agents
mkdir -p .opencode/skills
mkdir -p docs/file-briefs
mkdir -p docs/discovery
mkdir -p docs/decisions
mkdir -p docs/history
mkdir -p docs/testing

cat > AGENTS.md <<'EOF'
# AGENTS.md

# Roofer Hosting Project Agent Operating System

This project uses a structured multi-agent workflow within OpenCode.

## Core Principles

1. Discovery before design.
2. Design before implementation.
3. Security before deployment.
4. Testing before completion.
5. Documentation before closure.
6. Never repeat known failures.
7. Protect MVP scope.
8. Prefer simple solutions over clever solutions.
9. Follow framework conventions.
10. Every major decision must be documented.

## Product Summary

This project is a SaaS platform for roofing contractors.

A roofing contractor should be able to:

- Sign up
- Log in
- Create a company profile
- Choose a website template
- Customize structured content
- Upload photos and logos
- Preview their website
- Publish their website
- Receive contact form leads

Users should never edit executable code.

Templates should render structured data safely.

## Agent Workflow

For all medium and large tasks:

php-discovery
↓
php-product-owner
↓
php-manager
↓
php-expert
↓
php-architect
↓
php-tech-decisions when needed
↓
Implementation Agent(s)
↓
php-security
↓
php-testing
↓
php-historian
↓
php-documentarian

No implementation work should bypass this workflow unless the task is classified as Tiny.

## Agent Invocation Rules

### New Product Idea

Invoke:

- php-discovery

### New Feature Request

Invoke:

- php-product-owner
- php-expert

### Architecture Changes

Invoke:

- php-architect

### Framework or Technology Selection

Invoke:

- php-tech-decisions

### Database Changes

Invoke:

- php-database

### Template System Changes

Invoke:

- php-templates

### UI Changes

Invoke:

- php-frontend

### Backend Changes

Invoke:

- php-backend

### Security Sensitive Changes

Always invoke:

- php-security

### Before Completion

Always invoke:

- php-testing
- php-historian
- php-documentarian

## Task Classification

### Tiny Task

Examples:

- Fix typo
- Rename variable
- Small CSS adjustment
- Documentation correction

Workflow:

php-manager
↓
Implementation Agent
↓
php-testing

Historian and Documentarian optional.

### Medium Task

Examples:

- New dashboard page
- New database table
- New template section
- New form

Workflow:

php-manager
↓
php-expert
↓
Implementation Agent
↓
php-testing
↓
php-historian
↓
php-documentarian

### Large Task

Examples:

- Multi-tenancy
- Publishing engine
- Template system redesign
- Billing system
- Framework migration
- Major architectural changes

Workflow:

php-discovery
↓
php-product-owner
↓
php-manager
↓
php-expert
↓
php-architect
↓
Specialists
↓
php-security
↓
php-testing
↓
php-historian
↓
php-documentarian

## Agent Directory

### php-discovery

Discovers requirements, challenges assumptions, and prevents premature coding.

### php-product-owner

Protects product vision, MVP scope, and business value.

### php-manager

Coordinates work, creates plans, defines acceptance criteria, and assigns specialists.

### php-expert

Retrieves project knowledge and checks prior decisions and failures.

### php-architect

Protects long-term architecture, maintainability, routing, tenancy, and template structure.

### php-tech-decisions

Evaluates frameworks, libraries, databases, hosting, storage, and major technical choices.

### php-backend

Handles backend implementation.

### php-database

Handles database architecture, migrations, relationships, indexes, and seeders.

### php-templates

Handles website templates, preview, publish, and structured customization.

### php-frontend

Handles dashboard UI, forms, components, layouts, and accessibility.

### php-security

Reviews authentication, authorization, uploads, tenant isolation, validation, and route protection.

### php-testing

Verifies acceptance criteria, regression risks, tenant isolation, and expected behavior.

### php-historian

Records successes, failures, lessons, and do-not-repeat items.

### php-documentarian

Updates current project documentation.

## Required Discovery Gate

Before coding begins, these documents must exist:

- PRODUCT_BRIEF.md
- MVP_SCOPE.md
- DISCOVERY_NOTES.md
- USER_ANSWERS.md
- ASSUMPTIONS.md
- FRAMEWORK_DECISION.md
- ARCHITECTURE.md

If these documents are incomplete, use php-discovery.

## Required Architecture Gate

Before implementation:

- Framework decision approved
- Tenant strategy approved
- Template strategy approved
- Routing strategy approved
- Database strategy approved

If unresolved, use php-architect and php-tech-decisions.

## Required Completion Gate

Before any task is complete:

1. Security review completed.
2. Testing completed.
3. Historian updated.
4. Documentarian updated.
5. Next steps updated if necessary.

## Project Philosophy

Prefer:

- Simple
- Predictable
- Maintainable
- Framework-native
- Secure
- Well documented

Avoid:

- Clever code
- Premature optimization
- Unnecessary dependencies
- Scope creep
- User-editable executable code

When in doubt:

Choose the solution that will still be understandable and maintainable three years from now.
EOF

cat > docs/PROJECT_INDEX.md <<EOF
# Project Index

Project: $PROJECT_NAME

## Product Definition

- PRODUCT_BRIEF.md
- MVP_SCOPE.md
- DO_NOT_BUILD_YET.md

## Discovery

- discovery/DISCOVERY_NOTES.md
- discovery/OPEN_QUESTIONS.md
- discovery/USER_ANSWERS.md
- discovery/ASSUMPTIONS.md

## Decisions

- decisions/FRAMEWORK_DECISION.md
- decisions/TECH_STACK_DECISIONS.md
- decisions/ARCHITECTURE_DECISION_LOG.md

## Architecture

- ARCHITECTURE.md
- TENANT_ISOLATION_RULES.md
- SECURITY_RULES.md
- DATABASE_SCHEMA.md
- ROUTING_MAP.md
- TEMPLATE_SYSTEM.md

## Execution

- CURRENT_STATE.md
- NEXT_STEPS.md
- ACCEPTANCE_CRITERIA.md
- TESTING_PLAN.md

## History

- history/CHANGELOG.md
- history/BUGS_AND_FAILURES.md
- history/LESSONS_LEARNED.md
- history/DO_NOT_REPEAT.md
- history/SUCCESSFUL_PATTERNS.md

## File Briefs

- file-briefs/
EOF

cat > docs/PRODUCT_BRIEF.md <<'EOF'
# Product Brief

This project is a SaaS website hosting and website builder platform for roofing contractors.

A roofing contractor can:

- Sign up
- Log in
- Enter company details
- Choose a website template
- Customize structured fields
- Upload logo/photos
- Preview the website
- Publish the website
- Receive contact form leads

The system should protect users from editing raw code.

Templates should render safe structured data.
EOF

cat > docs/MVP_SCOPE.md <<'EOF'
# MVP Scope

## Build First

- Roofer account signup/login
- Contractor profile
- Template selection
- Structured website editor
- Logo and image upload
- Preview mode
- Publish mode
- Contact form lead capture
- Admin/customer dashboard

## Not MVP Unless Approved

- Billing
- Custom domains
- AI copywriting
- CRM
- Email campaigns
- SEO automation
- Template marketplace
- Direct code editing
EOF

cat > docs/DO_NOT_BUILD_YET.md <<'EOF'
# Do Not Build Yet

Do not build these until explicitly approved:

- Billing/subscriptions
- Domain registration
- DNS automation
- AI content generation
- CRM pipelines
- Advanced analytics
- Custom code editor
- Third-party marketplace
- Multi-user team permissions
EOF

cat > docs/CURRENT_STATE.md <<'EOF'
# Current State

## Status

Fresh project setup.

## Current Priority

Complete discovery/design before building features.

## Known Constraints

- User wants OpenCode agent/skill workflow.
- User wants a Discovery/Grill-Me phase.
- User wants structured documentation.
- User wants project memory to prevent repeated failed code.
- User is considering Laravel but wants framework choice validated.
EOF

cat > docs/ARCHITECTURE.md <<'EOF'
# Architecture

## Current Leading Direction

- Laravel
- Blade templates
- Filament dashboard
- Livewire interactions
- Tailwind styling
- SQLite for local development
- MySQL/PostgreSQL later

Final framework choice must be recorded in docs/decisions/FRAMEWORK_DECISION.md.

## Core Modules

- Authentication
- Contractor accounts
- Website profiles
- Template system
- Media uploads
- Public site rendering
- Contact lead capture
- Admin dashboard

## Principle

Store editable content as structured database fields.

Render those fields through safe templates.
EOF

cat > docs/TENANT_ISOLATION_RULES.md <<'EOF'
# Tenant Isolation Rules

Every contractor account/site must be isolated.

## Rules

- Every tenant-owned table must include contractor/account/site ownership.
- Never query tenant data without scoping to the current contractor/site.
- Public website routes must resolve only published site data.
- Dashboard routes must require authentication.
- Admin routes must require admin authorization.
- Tests must verify users cannot access another contractor's data.
EOF

cat > docs/SECURITY_RULES.md <<'EOF'
# Security Rules

## Required

- Validate all inputs.
- Escape all rendered user content.
- Do not allow raw PHP, Blade, JavaScript, or unrestricted HTML editing.
- Sanitize uploads.
- Restrict uploaded file types.
- Store files outside executable paths.
- Protect forms with CSRF.
- Use framework authentication.
- Use authorization checks on all dashboard resources.
EOF

cat > docs/DATABASE_SCHEMA.md <<'EOF'
# Database Schema

Initial planned tables:

- users
- contractors
- websites
- website_templates
- website_pages
- website_sections
- media_assets
- services
- service_areas
- leads

All schema changes must be done through migrations.
EOF

cat > docs/ROUTING_MAP.md <<'EOF'
# Routing Map

## Planned Route Groups

### Public Platform

- /
- /pricing
- /features
- /signup
- /login

### Authenticated Dashboard

- /dashboard
- /dashboard/site
- /dashboard/template
- /dashboard/editor
- /dashboard/media
- /dashboard/leads
- /dashboard/preview

### Published Websites

- /sites/{siteSlug}
- /sites/{siteSlug}/about
- /sites/{siteSlug}/services
- /sites/{siteSlug}/contact

Public catch-all style routes must never override dashboard/admin routes.
EOF

cat > docs/TEMPLATE_SYSTEM.md <<'EOF'
# Template System

## Principle

Templates are display systems.

Users edit structured fields, not raw code.

## Editable Fields

- Business name
- Phone
- Email
- Logo
- Hero headline
- Hero subheadline
- Hero image
- About text
- Services
- Service areas
- Gallery images
- Testimonials
- Colors
- Font selection

## Forbidden

- Raw PHP editing
- Raw Blade editing
- Raw JavaScript editing
- Unrestricted HTML editing
EOF

cat > docs/ACCEPTANCE_CRITERIA.md <<'EOF'
# Acceptance Criteria

Before coding, every task should define:

- User goal
- Files likely affected
- Data affected
- Security risks
- Tenant isolation risks
- Expected behavior
- Testing steps
- Rollback plan
EOF

cat > docs/TESTING_PLAN.md <<'EOF'
# Testing Plan

## Required Testing Areas

- Authentication
- Authorization
- Tenant isolation
- Template rendering
- Media upload validation
- Contact form submission
- Public website display
- Dashboard editing
- Database migrations
EOF

cat > docs/NEXT_STEPS.md <<'EOF'
# Next Steps

1. Run Discovery Agent / Grill-Me phase.
2. Capture user answers in docs/discovery/USER_ANSWERS.md.
3. Resolve assumptions in docs/discovery/ASSUMPTIONS.md.
4. Complete framework decision.
5. Complete architecture plan.
6. Confirm MVP scope.
7. Only then create the application scaffold.
EOF

cat > docs/discovery/DISCOVERY_NOTES.md <<'EOF'
# Discovery Notes

This file captures answers from the user during the design/grill-me phase.

## Format

### Question

What was asked?

### Answer

What the user said.

### Decision

What this means for the product.

### Risk

What could go wrong.

### Follow-Up

What still needs clarification.
EOF

cat > docs/discovery/OPEN_QUESTIONS.md <<'EOF'
# Open Questions

## Customer

- Who is the primary customer?
- What problem is this replacing?
- Why would a roofer choose this instead of Wix, Squarespace, WordPress, GoHighLevel, or an agency?

## Product

- Can roofers switch templates after publishing?
- How much customization is allowed?
- Can they add/remove pages?
- Can they edit service area pages?
- Can they upload unlimited images?

## Publishing

- Will MVP use subfolders, subdomains, or custom domains?
- What happens when a roofer cancels?
- Is the site unpublished, frozen, exported, or deleted?

## Business

- What is the pricing model?
- Is this self-service or admin-assisted setup?
- Who provides copy and images?

## Technical

- Which framework should be used?
- Which database should be used locally and in production?
- What hosting environment is expected?
EOF

cat > docs/discovery/USER_ANSWERS.md <<'EOF'
# User Answers

Record direct user answers here.

Keep entries short and dated.
EOF

cat > docs/discovery/ASSUMPTIONS.md <<'EOF'
# Assumptions

Record assumptions that have not yet been confirmed.

Each assumption should be marked:

- Pending
- Confirmed
- Rejected
EOF

cat > docs/decisions/FRAMEWORK_DECISION.md <<'EOF'
# Framework Decision

## Decision Status

Pending architectural review.

## Leading Candidate

Laravel

## Options to Compare

### Laravel

Pros:
- Strong SaaS fit
- Authentication support
- Routing
- Migrations
- Blade templates
- Filament dashboard ecosystem
- Good future billing/support ecosystem

Cons:
- More framework structure than plain PHP
- Requires learning Laravel conventions

### Symfony

Pros:
- Enterprise-grade
- Strong architecture
- Mature components

Cons:
- More complex for this MVP
- More ceremony

### CodeIgniter

Pros:
- Lightweight
- Easier than Laravel for some simple PHP projects

Cons:
- Less ideal for SaaS dashboard/product complexity
- More custom plumbing likely

### Plain PHP

Pros:
- Simple starting point

Cons:
- Poor fit for multi-tenant SaaS
- Higher long-term maintenance risk
- Easy to create inconsistent structure

## Final Decision

TBD

## Decision Date

TBD

## Reason

TBD
EOF

cat > docs/decisions/TECH_STACK_DECISIONS.md <<'EOF'
# Tech Stack Decisions

Record major technology decisions here.

Examples:

- Framework
- Database
- Admin dashboard package
- Frontend approach
- Hosting strategy
- Storage strategy
- Email provider
- Payment provider
EOF

cat > docs/decisions/ARCHITECTURE_DECISION_LOG.md <<'EOF'
# Architecture Decision Log

Use this format:

## YYYY-MM-DD — Decision Title

### Context

Why the decision was needed.

### Decision

What was decided.

### Alternatives Considered

What else was considered.

### Consequences

Tradeoffs and risks.
EOF

cat > docs/history/CHANGELOG.md <<'EOF'
# Changelog

Record completed changes here.
EOF

cat > docs/history/BUGS_AND_FAILURES.md <<'EOF'
# Bugs and Failures

Record failed attempts, broken code, unresolved bugs, and root causes here.
EOF

cat > docs/history/LESSONS_LEARNED.md <<'EOF'
# Lessons Learned

Record reusable lessons from successful and failed implementation attempts.
EOF

cat > docs/history/DO_NOT_REPEAT.md <<'EOF'
# Do Not Repeat

Record failed approaches that should not be attempted again.

Examples:

- Do not place public catch-all website routes above dashboard/admin routes.
- Do not store user template edits as raw executable code.
EOF

cat > docs/history/SUCCESSFUL_PATTERNS.md <<'EOF'
# Successful Patterns

Record patterns that worked well and should be reused.
EOF

create_agent () {
  local name="$1"
  local description="$2"
  local edit_permission="$3"
  local bash_permission="$4"
  local body="$5"

  cat > ".opencode/agents/$name.md" <<EOF
---
description: $description
mode: subagent
temperature: 0.2
permission:
  edit: $edit_permission
  bash: $bash_permission
---

$body
EOF
}

create_agent "php-discovery" "Interrogates product requirements before design or coding" "ask" "deny" \
"Act as the Discovery / Grill-Me Agent.

Challenge assumptions. Ask hard questions about the product, customer, MVP, pricing, templates, publishing, domains, cancellation, content ownership, media, SEO, leads, security, and tenant isolation.

Do not code. Do not design architecture. Capture answers in docs/discovery/USER_ANSWERS.md, assumptions in docs/discovery/ASSUMPTIONS.md, and unresolved items in docs/discovery/OPEN_QUESTIONS.md."

create_agent "php-product-owner" "Protects product vision, MVP scope, and business usefulness" "ask" "deny" \
"Act as the Product Owner.

Protect the product vision. Prevent scope creep. Decide whether a feature belongs in MVP or later. Evaluate whether a task solves a real roofer/customer problem.

Review docs/PRODUCT_BRIEF.md, docs/MVP_SCOPE.md, and docs/DO_NOT_BUILD_YET.md before approving scope.

Do not code. Do not design technical architecture. Say no to distracting ideas."

create_agent "php-manager" "Plans tasks and assigns specialist agents" "ask" "ask" \
"Act as the Project Manager.

Review the request, check discovery/design gates, define acceptance criteria, identify risks, assign specialist agents, and require testing, historian, and documentarian updates.

Do not code unless explicitly approved for tiny tasks."

create_agent "php-expert" "Retrieves and interprets project context" "ask" "deny" \
"Act as the Project Expert.

Read docs/PROJECT_INDEX.md first. Retrieve only relevant docs. Check docs/history/DO_NOT_REPEAT.md. Summarize project facts, affected files, risks, and prior decisions.

Do not invent project facts."

create_agent "php-architect" "Designs and validates application architecture" "ask" "ask" \
"Act as the Architect.

Protect maintainability. Validate framework structure, routing, tenancy, database design, template architecture, and publishing boundaries. Prevent feature sprawl."

create_agent "php-tech-decisions" "Evaluates frameworks, libraries, databases, and major technical choices" "ask" "deny" \
"Act as the Architecture Decision Agent.

Compare options, explain tradeoffs, recommend the simplest stack that fits the product, and update docs/decisions/FRAMEWORK_DECISION.md and docs/decisions/TECH_STACK_DECISIONS.md.

Do not code until the decision is recorded."

create_agent "php-backend" "Implements backend work after framework approval" "ask" "ask" \
"Act as the Backend Agent.

Use framework conventions, migrations, validation, policies, tenant scoping, and clean controllers.

Do not bypass tenant isolation."

create_agent "php-database" "Handles database design, migrations, relationships, and seeders" "ask" "ask" \
"Act as the Database Agent.

Use migrations only. Protect tenant ownership. Update docs/DATABASE_SCHEMA.md. Add seed data when useful."

create_agent "php-templates" "Handles website templates, preview, publish, and structured content" "ask" "ask" \
"Act as the Template System Agent.

Users edit structured fields only. Templates render safe data. No raw PHP, Blade, JavaScript, or unrestricted HTML editing."

create_agent "php-frontend" "Handles views, forms, dashboard UI, and visual layout" "ask" "ask" \
"Act as the Frontend Agent.

Use simple, accessible UI. Prefer reusable components. Keep forms clear and contractor-friendly."

create_agent "php-security" "Reviews auth, uploads, tenant isolation, forms, and publishing risks" "ask" "ask" \
"Act as the Security Reviewer.

Check authentication, authorization, tenant isolation, validation, escaping, uploads, CSRF, and public/private route boundaries.

Block completion if risks remain."

create_agent "php-testing" "Verifies expected behavior and regression risks" "ask" "ask" \
"Act as the Testing Agent.

Read acceptance criteria. Identify tests/manual checks. Check tenant isolation where relevant. Record failures in docs/history/BUGS_AND_FAILURES.md."

create_agent "php-historian" "Records successes, failures, lessons, and do-not-repeat items" "ask" "deny" \
"Act as the Historian.

Update docs/history/CHANGELOG.md, BUGS_AND_FAILURES.md, LESSONS_LEARNED.md, DO_NOT_REPEAT.md, and SUCCESSFUL_PATTERNS.md.

Keep entries dated, short, and useful."

create_agent "php-documentarian" "Updates current-state project documentation" "ask" "deny" \
"Act as the Documentarian.

Update PROJECT_INDEX.md, CURRENT_STATE.md, DATABASE_SCHEMA.md, ROUTING_MAP.md, TEMPLATE_SYSTEM.md, NEXT_STEPS.md, and file-briefs.

Do not overwrite historical records."

create_skill () {
  local name="$1"
  local description="$2"
  local body="$3"

  mkdir -p ".opencode/skills/$name"

  cat > ".opencode/skills/$name/SKILL.md" <<EOF
---
name: $name
description: $description
---

$body
EOF
}

create_skill "discovery-grill-me" "Use before planning or coding to interrogate the product idea, expose missing requirements, and prevent premature implementation." \
"Act as the Discovery Agent / Grill-Me Agent.

Challenge assumptions. Find missing requirements. Ask hard product, business, technical, and UX questions. Prevent premature coding.

Update:
- docs/discovery/USER_ANSWERS.md
- docs/discovery/OPEN_QUESTIONS.md
- docs/discovery/ASSUMPTIONS.md
- docs/discovery/DISCOVERY_NOTES.md"

create_skill "project-management" "Use when planning, decomposing, sequencing, or assigning project work after discovery has enough information." \
"Act as the Project Manager.

Confirm discovery/design gates. Define acceptance criteria. Assign specialists. Require testing, historian, and documentarian updates."

create_skill "project-expert" "Use when project context, architecture, current state, prior decisions, or documentation lookup is needed." \
"Act as the Project Expert.

Read PROJECT_INDEX.md first. Retrieve only relevant docs. Check DO_NOT_REPEAT.md. Do not invent project facts."

create_skill "architecture-review" "Use when a task changes structure, routing, database design, tenancy, template architecture, or application boundaries." \
"Act as the Architect.

Protect maintainability, enforce simple structure, prevent feature sprawl, and record major architecture decisions."

create_skill "architecture-decision" "Use when selecting frameworks, libraries, databases, hosting platforms, admin panels, or other major technical choices." \
"Act as the Architecture Decision Agent.

Compare options, explain tradeoffs, recommend a stack, and update decision docs."

create_skill "laravel-backend" "Use when implementing Laravel models, controllers, routes, services, policies, requests, or migrations after framework approval." \
"Act as the Laravel Backend Agent.

Use Laravel conventions, migrations, validation, policies, tenant scoping, and clean controllers."

create_skill "database-change" "Use when adding or changing database tables, columns, relationships, indexes, seeders, or tenant data structures." \
"Act as the Database Agent.

Use migrations only. Protect tenant ownership. Update DATABASE_SCHEMA.md."

create_skill "template-system" "Use when building or changing website templates, preview, publish, theme fields, editable content, or public site rendering." \
"Act as the Template System Agent.

Users edit structured fields only. Templates render safe data. No raw executable code editing."

create_skill "frontend-ui" "Use when working on views, dashboard UI, forms, Tailwind, components, or visual layout." \
"Act as the Frontend Agent.

Build simple, accessible, contractor-friendly UI."

create_skill "security-review" "Use before completing tasks involving auth, uploads, public pages, forms, tenant data, permissions, or publishing." \
"Act as the Security Reviewer.

Check authentication, authorization, tenant isolation, validation, escaping, uploads, CSRF, and route boundaries."

create_skill "qa-testing" "Use after implementation to verify expected behavior and regression risks." \
"Act as the Testing Agent.

Verify acceptance criteria, regression risks, and tenant isolation."

create_skill "historian" "Use after testing to record what changed, what failed, what worked, and what must not be repeated." \
"Act as the Historian.

Update history docs with dated, concise entries."

create_skill "documentation-update" "Use after discovery, decisions, or successful implementation to update current project documentation." \
"Act as the Documentarian.

Update current-state docs without overwriting historical records."

cat > opencode-first-prompt.txt <<'EOF'
We are starting a new SaaS project for a roofing contractor website hosting service.

Before coding features, inspect this project folder and follow AGENTS.md.

Use @php-discovery first.

Goal:
Interrogate the product idea before design or coding.

The app concept:
A roofer signs up for a hosted website service, chooses one of several templates, enters business information, customizes structured content, uploads images, previews the site, and publishes it.

Do not build features yet.
Do not scaffold Laravel yet.
Do not write controllers, migrations, routes, or templates yet.

First:
1. Read AGENTS.md.
2. Read docs/PROJECT_INDEX.md.
3. Read docs/PRODUCT_BRIEF.md.
4. Read docs/MVP_SCOPE.md.
5. Read docs/DO_NOT_BUILD_YET.md.
6. Read docs/discovery/OPEN_QUESTIONS.md.
7. Start the Discovery / Grill-Me phase.
8. Ask me the first set of important questions.
9. After I answer, update discovery notes and identify decisions, risks, and follow-up questions.
EOF

cat > opencode-framework-decision-prompt.txt <<'EOF'
Use @php-tech-decisions.

Review the product brief, MVP scope, discovery notes, assumptions, and open questions.

Compare Laravel, Symfony, CodeIgniter, plain PHP, and any other reasonable option for this project.

Recommend the best framework/tooling stack for a roofing contractor website builder SaaS.

Update:
- docs/decisions/FRAMEWORK_DECISION.md
- docs/decisions/TECH_STACK_DECISIONS.md
- docs/history/LESSONS_LEARNED.md

Do not scaffold the app yet.
EOF

echo
echo "Done."
echo
echo "Created:"
echo "- AGENTS.md"
echo "- .opencode/agents/php-*.md"
echo "- .opencode/skills/*/SKILL.md"
echo "- docs/*"
echo "- docs/discovery/*"
echo "- docs/decisions/*"
echo "- docs/history/*"
echo "- opencode-first-prompt.txt"
echo "- opencode-framework-decision-prompt.txt"
echo
echo "Next:"
echo "chmod +x opencode-setup.sh"
echo "./opencode-setup.sh \"Roofer Hosting\""
echo
echo "Then open OpenCode and paste:"
echo "opencode-first-prompt.txt"
