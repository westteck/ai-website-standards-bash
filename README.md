## Project Bootstrap: PHP 8.3 + Bootstrap5 + Font Awesome + MySQL

A small bootstrap script that creates minimal, non‑bloated config files to enforce coding standards and developer workflows for PHP 8.3 projects with light JS and MySQL.

### What the script does
- Creates editor and formatter configs:
  - .editorconfig, .php-cs-fixer.php, phpstan.neon, .prettierrc, .eslintrc.js
- Adds package manifests with helpful scripts (composer.json, package.json) — does not install deps.
- Adds lightweight pre-commit config: .pre-commit-config.yaml (requires installing pre-commit to use).
- Adds minimal repo files:
  - .gitattributes, CONTRIBUTING.md, README.md snippet
  - db/migrations/001_create_users.sql sample
- Generates two agent rules files for tooling:
  - opencode-agent.yaml (rules/skills for enforcing standards)
  - hermes-agent.yaml (assistant/agent skills for short, actionable guidance)
- Leaves installation and git initialization to you (per request).

### Why it helps
- Establishes consistent, language-appropriate defaults (PSR-12 + php-cs-fixer, PHPStan, Airbnb + Prettier for JS).
- Keeps tooling minimal and focused to avoid bloat.
- Provides runnable scripts for formatting, linting, and static analysis so contributors don’t need to memorize commands.
- Supplies agent rule files so automated assistants (opencode/hermes) can follow project conventions.

### How to use
1. Save script as bootstrap_project.sh in your project root and make executable:
   ```
   chmod +x bootstrap_project.sh
   ```
2. Run the script from the project root:
   ```
   ./bootstrap_project.sh
   ```
3. Install dev dependencies when ready:
   - PHP: `composer install`
   - Node: `npm ci`
4. (Optional) Enable pre-commit hooks:
   - Install pre-commit (Python): `pip install pre-commit`
   - Install hooks: `pre-commit install`
5. Use the provided npm/composer scripts:
   - Format PHP: `composer run-script format`
   - Check PHP format: `composer run-script format:check`
   - PHP static analysis: `composer run-script analyse`
   - Lint JS: `npm run lint`
   - Format JS: `npm run format`
6. Customize configs and agent YAML files to match project structure (e.g., adjust src path).

Keep the project minimal: only add dependencies and build tooling when a feature requires them.
