#!/usr/bin/env bash
# to be run from project root folder
set -euo pipefail

PROJECT_NAME="${1:-Wedding Photo Upload App}"

mkdir -p .opencode/agents
mkdir -p .opencode/skills
mkdir -p docs/audit
mkdir -p docs/history
mkdir -p docs/discovery
mkdir -p docs/decisions
mkdir -p docs/testing
mkdir -p docs/file-briefs
mkdir -p .opencode/backups

cat > AGENTS.md <<'EOF'
# AGENTS.md

# Wedding Photo Upload App — Agent Operating Rules

Project codename: wed3-vanilla

This is a private, mobile-first wedding guest photo upload app.

## Non-Negotiable Project Constraints

- Pure Vanilla PHP 8.3.
- Object-oriented where useful.
- No framework.
- Dependency-minimal.
- Apache2.
- MySQL 8.0.
- PHP-FPM 8.3.
- aaPanel on Ubuntu 24.04.
- Target: approximately 200 wedding guests.
- Upload size target: max 20MB files.
- Image target: WebP-oriented workflow.

## Critical Development Sequence

This project must be built UI-first.

### Phase 1: Static UI Shell

Build static mockups first using plain PHP files rendering semantic HTML5 and vanilla CSS.

Expected files may include:

- index.php
- dashboard.php
- upload.php

### Phase 2: Client-Side Simulation

Simulate behavior with isolated Vanilla JavaScript only.

Allowed:

- setInterval upload progress simulation
- mock arrays
- fake voting state
- screen navigation simulation

### Phase 3: Backend Integration

Do not write active PDO database connections until the responsive UI is accepted.

Do not write long-running shell commands or background daemon code until the responsive UI is accepted.

## Forbidden Unless Explicitly Approved

- Laravel
- Symfony
- CodeIgniter
- WordPress
- Composer packages
- Node build tools
- React
- Vue
- Svelte
- Tailwind build pipeline
- Frontend frameworks
- Active PDO before UI approval
- Long-running shell/background daemons before UI approval

## Security Hook: QR-Locked Signups

Guests must arrive through printed QR codes.

Expected pattern:

- Route: /register?token=SECRET_WEDDING_TOKEN
- If token is valid:
  - set $_SESSION['qr_verified'] = true
- Dashboard and upload endpoints must enforce this session gate.
- Missing or invalid verification must return native 403 Access Denied.

## Apache Routing Requirement

Use Apache rewrite routing through public/.htaccess where applicable.

Expected principle:

- Protect storage upload/original paths.
- Route non-file/non-directory requests to index.php.
- Disable indexes and MultiViews.

## Main Workflow

For medium or large tasks:

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
Implementation Agent(s)
↓
php-security
↓
php-testing
↓
php-historian
↓
php-documentarian

For code audit or cleanup work:

php-code-auditor
↓
dry-run audit report
↓
user approval
↓
backup
↓
small approved changes
↓
verification
↓
audit memory update

## Project-Specific Agents

Use these when relevant:

- wed-ui-builder
- wed-upload-specialist
- wed-security-gatekeeper

## Generic Agents Available

The following may be global agents in ~/.config/opencode/agents or project agents in .opencode/agents:

- php-discovery
- php-product-owner
- php-manager
- php-expert
- php-architect
- php-security
- php-testing
- php-historian
- php-documentarian
- php-code-auditor

## Code Audit / Cleanup Rules

When reviewing or cleaning code:

- Use php-code-auditor.
- Use code-audit-cleanup skill.
- Dry-run first.
- Convince the user with evidence.
- Create a plan of action.
- Back up affected files before editing.
- Verify after editing.
- Update docs/audit/CODE_AUDIT_MEMORY.md.
- Be frugal with tokens.

## Required Completion Gate

Before any medium or large task is considered done:

1. Security reviewed.
2. Testing completed.
3. Audit/history updated if relevant.
4. Documentation updated.
5. Next steps identified.

## Coding Style

- Clear, readable vanilla PHP.
- Use strict comparisons.
- Prefer small focused classes/functions.
- Escape output.
- Validate input.
- Use prepared statements only when database is approved.
- Keep UI, business logic, and storage concerns separated where practical.
- Comment non-obvious logic only.
- Do not over-comment obvious code.

## Token-Frugal Rules

- Start with file tree and targeted search.
- Read relevant sections only.
- Summarize findings.
- Avoid dumping long code unless necessary.
- Use docs/audit/CODE_AUDIT_MEMORY.md for memory.
EOF

cat > docs/PROJECT_INDEX.md <<EOF
# Project Index

Project: $PROJECT_NAME

## Core Docs

- PROJECT_MASTER_PLAN.md
- CURRENT_STATE.md
- NEXT_STEPS.md
- SECURITY_RULES.md
- UI_FIRST_RULES.md
- ROUTING_RULES.md
- UPLOAD_RULES.md
- DATABASE_RULES.md

## Audit

- audit/CODE_AUDIT_MEMORY.md

## History

- history/CHANGELOG.md
- history/BUGS_AND_FAILURES.md
- history/LESSONS_LEARNED.md
- history/DO_NOT_REPEAT.md

## Testing

- testing/TESTING_PLAN.md

## File Briefs

- file-briefs/
EOF

cat > docs/PROJECT_MASTER_PLAN.md <<'EOF'
# Wedding Photo Upload App — Project Master Plan

## Executive Summary

Pure Vanilla PHP 8.3 wedding photo upload application.

## Constraints

- No framework.
- Dependency-minimal.
- Mobile-first.
- UI-first development.
- No active PDO until UI approval.
- No background daemons until UI approval.

## Core Purpose

Private wedding guest photo upload app for approximately 200 users.

## Upload Target

- Max 20MB files.
- WebP-oriented image workflow.
EOF

cat > docs/UI_FIRST_RULES.md <<'EOF'
# UI-First Rules

The UI must be accepted before backend work.

## Allowed Before UI Approval

- Static PHP-rendered HTML shells.
- Vanilla CSS.
- Isolated Vanilla JavaScript simulations.
- Mock arrays.
- Fake upload progress.
- Fake voting interactions.

## Forbidden Before UI Approval

- Active PDO database connections.
- Database schema implementation.
- Long-running shell commands.
- Background daemons.
- Queue workers.
- Image processing workers.
EOF

cat > docs/SECURITY_RULES.md <<'EOF'
# Security Rules

## QR Gate

- Guests must arrive via /register?token=SECRET_WEDDING_TOKEN.
- Valid token sets $_SESSION['qr_verified'] = true.
- Dashboard/upload routes must enforce $_SESSION['qr_verified'].
- Missing verification returns 403 Access Denied.

## General

- Escape output.
- Validate input.
- Use prepared statements when database is approved.
- Protect upload paths.
- Do not expose storage originals publicly.
- Do not expose credentials.
EOF

cat > docs/ROUTING_RULES.md <<'EOF'
# Routing Rules

Use Apache rewrite rules through public/.htaccess where applicable.

Expected principles:

- Options -MultiViews -Indexes
- Block direct access to protected storage paths.
- Route non-file/non-directory requests to index.php.
- Avoid route behavior that exposes upload originals.
EOF

cat > docs/UPLOAD_RULES.md <<'EOF'
# Upload Rules

Upload backend is not allowed until UI approval.

Future upload requirements:

- Max 20MB files.
- Validate MIME type.
- Validate extension.
- Prefer WebP workflow.
- Store originals safely.
- Do not allow executable uploads.
- Prevent direct execution from upload directories.
EOF

cat > docs/DATABASE_RULES.md <<'EOF'
# Database Rules

No active PDO/database connections until UI is approved.

When database work begins:

- Use PDO.
- Use prepared statements.
- Keep credentials out of committed files.
- Document tables.
- Back up before schema changes.
EOF

cat > docs/CURRENT_STATE.md <<'EOF'
# Current State

Fresh wedding photo upload project setup.

Current priority:

1. Build mobile-first static UI shell.
2. Simulate upload/user flows with Vanilla JS.
3. Get visual/mobile approval.
4. Only then begin database/backend integration.
EOF

cat > docs/NEXT_STEPS.md <<'EOF'
# Next Steps

1. Confirm mobile-first screen flow.
2. Build static index/register/dashboard/upload screens.
3. Simulate QR-verified state visually.
4. Simulate upload progress.
5. Simulate gallery/voting interactions if needed.
6. Review UI on mobile dimensions.
7. After UI approval, plan backend.
EOF

cat > docs/audit/CODE_AUDIT_MEMORY.md <<'EOF'
# Code Audit Memory

Record audit findings, recommendations, approvals, backups, changes, verification, and unresolved risks.

## Entry Format

### Date
YYYY-MM-DD

### Area
File, feature, database table, or system area.

### Issue
What was found.

### Evidence
Why this is a real issue.

### Recommendation
What should change.

### Approval Status
Pending / Approved / Rejected / Completed

### Backup
What was backed up before changes.

### Change Made
What was changed.

### Verification
How the change was tested.

### Result
Passed / Failed / Needs follow-up.

### Do Not Repeat
Any lesson learned.
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

Initial rules:

- Do not add PDO before UI approval.
- Do not add framework code.
- Do not add long-running daemons before UI approval.
- Do not expose upload originals publicly.
EOF

cat > docs/testing/TESTING_PLAN.md <<'EOF'
# Testing Plan

## UI Phase

- Mobile viewport review.
- Upload simulation behavior.
- Navigation flow.
- QR gate visual flow.
- Basic accessibility.
- No active PDO present.

## Backend Phase Later

- QR token verification.
- Session enforcement.
- 403 behavior.
- Upload validation.
- File storage protection.
- MySQL insert/read behavior.
EOF

create_agent () {
  local name="$1"
  local description="$2"
  local edit="$3"
  local bash="$4"
  local body="$5"

  cat > ".opencode/agents/$name.md" <<EOF
---
description: $description
mode: subagent
temperature: 0.2
permission:
  edit: $edit
  bash: $bash
---

$body
EOF
}

create_agent "wed-ui-builder" "Builds the mobile-first static UI shell for the wedding photo app" "ask" "ask" \
"Act as the Wedding UI Builder.

Mission:
Build the mobile-first static UI shell using pure Vanilla PHP, semantic HTML5, Vanilla CSS, and isolated Vanilla JS simulations.

Rules:
- No framework.
- No Composer packages.
- No Node build tools.
- No active PDO.
- No backend daemons.
- Simulate behavior client-side until UI is approved.
- Prioritize mobile usability for wedding guests."

create_agent "wed-upload-specialist" "Plans and implements upload behavior only after UI approval" "ask" "ask" \
"Act as the Wedding Upload Specialist.

Mission:
Design and implement safe photo upload behavior after UI approval.

Before UI approval:
- Only simulate upload progress.
- Do not write real upload processing.

After approval:
- Validate size, MIME type, extension.
- Protect storage.
- Prefer WebP workflow.
- Prevent executable uploads.
- Avoid exposing originals publicly."

create_agent "wed-security-gatekeeper" "Enforces QR-token access and session gate rules" "ask" "ask" \
"Act as the Wedding Security Gatekeeper.

Mission:
Protect the wedding app with QR-token signup and strict session enforcement.

Rules:
- /register?token=SECRET_WEDDING_TOKEN verifies access.
- Valid token sets \$_SESSION['qr_verified'] = true.
- Dashboard/upload routes must enforce this session flag.
- Missing verification returns 403 Access Denied.
- Review route access before completion."

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

create_skill "wedding-ui-first" "Use for the wedding photo app UI-first development phase before backend/database work." \
"# Wedding UI-First Skill

Use when building or reviewing the initial wedding app UI.

Rules:
- Static PHP-rendered pages only.
- Semantic HTML5.
- Vanilla CSS.
- Isolated Vanilla JS simulations.
- No active PDO.
- No backend daemons.
- No frameworks.
- Mobile-first.
- Keep guest experience simple."

create_skill "wedding-qr-gate" "Use when implementing or reviewing QR-token signup and session gate access." \
"# Wedding QR Gate Skill

Required behavior:
- Guests arrive via /register?token=SECRET_WEDDING_TOKEN.
- Valid token sets \$_SESSION['qr_verified'] = true.
- Protected pages check this session flag.
- Invalid/missing verification returns 403 Access Denied.
- Do not expose sensitive token values in logs or UI."

create_skill "wedding-upload-safety" "Use when planning or implementing real upload handling after UI approval." \
"# Wedding Upload Safety Skill

Before UI approval:
- Simulate only.

After UI approval:
- Enforce max 20MB.
- Validate MIME and extension.
- Reject executable files.
- Store files safely.
- Prevent direct execution from upload directories.
- Prefer WebP conversion workflow if approved."

cat > opencode-first-prompt.txt <<'EOF'
Read AGENTS.md and docs/PROJECT_INDEX.md.

This is the wed3-vanilla Wedding Photo Upload App.

Use the wedding-ui-first skill and @wed-ui-builder.

Goal:
Start the UI-first static shell phase.

Do not write active PDO/database code.
Do not write long-running shell commands.
Do not add frameworks or packages.

First:
1. Inspect current files.
2. Identify whether index.php, dashboard.php, upload.php, public/.htaccess, or assets exist.
3. Propose the first UI-only implementation plan.
4. Wait for approval before editing.
EOF

cat > opencode-audit-prompt.txt <<'EOF'
Use @php-code-auditor with the code-audit-cleanup skill.

Audit this wedding PHP project.

Do a dry-run first.
Do not edit yet.
Be token-frugal.
Convince me with evidence before recommending changes.
Create a plan of action, backup plan, verification plan, and update docs/audit/CODE_AUDIT_MEMORY.md.
EOF

echo "Wedding photo OpenCode project setup complete."
echo
echo "Created:"
echo "- AGENTS.md"
echo "- docs/*"
echo "- docs/audit/CODE_AUDIT_MEMORY.md"
echo "- .opencode/agents/wed-*.md"
echo "- .opencode/skills/wedding-*"
echo "- opencode-first-prompt.txt"
echo "- opencode-audit-prompt.txt"
echo
echo "Next:"
echo "Open OpenCode in this project and paste opencode-first-prompt.txt"
