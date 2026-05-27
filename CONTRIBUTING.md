## Opencode Standards — PHP Web Projects

Purpose: concise, actionable rules for Opencode to follow on PHP 8.3 + Bootstrap 5 + Font Awesome + MySQL projects.

Project layout
- src/ — PHP source (PSR-4 autoloading, App\ namespace)
- public/ — web root (index.php, assets)
- templates/ or views/ — HTML templates
- db/migrations/ — ordered migration files
- tests/ — unit/integration tests
- assets/ or frontend/src — JS/CSS sources

Coding style & formatting
- Follow PSR-12 for PHP; enforce with php-cs-fixer.
- Use php-cs-fixer --config=.php-cs-fixer.php for formatting; run automatically on staged files.
- Keep JS style consistent with Prettier + ESLint (Airbnb base + eslint-config-prettier).

Naming & casing
- PHP classes: PascalCase (UserController, OrderService).
- PHP files: choose kebab-case or lower_snake_case and be consistent (project-wide).
- PHP methods/variables: camelCase (getUserById).
- Constants: UPPER_SNAKE_CASE.
- Database identifiers: lower_snake_case (table: user_profile; column: created_at).
- Foreign keys: {referenced_table}_id (user_id).

Architecture & patterns
- Use MVC and layered separation: Presentation (controllers/views), Domain (entities/services), Persistence (repositories/DAOs).
- Use Dependency Injection for services; prefer constructor injection.
- Use Repository or Data Mapper pattern to isolate SQL from domain logic.
- Keep controllers thin; place business logic in services/domain classes.

Database
- Migrations in db/migrations (timestamp or numbered).
- Use prepared statements / parameterized queries; avoid inline string interpolation for SQL.
- Add created_at, updated_at (DATETIME/TIMESTAMP) on tables where relevant.
- Index foreign keys and commonly queried columns.
- Singular or plural table naming: pick one (recommend singular) and apply consistently.

Testing
- Write unit tests for domain logic (PHPUnit).
- Add integration tests for important DB interactions where feasible.
- Use simple fixtures or seeders for tests; keep tests fast.

Security
- Validate and sanitize all external input; centralize validation logic.
- Use parameterized queries / prepared statements or an ORM that does so.
- Escape output in templates (HTML) to prevent XSS.
- Add CSRF protection for state-changing forms.
- Store passwords with strong hashing (password_hash) and enforce sensible policies.

Dependencies & tooling
- Use Composer for PHP packages; follow semantic versioning for your own packages.
- Keep dev dependencies minimal: php-cs-fixer, phpstan, phpunit.
- Frontend: prefer CDN for Bootstrap/Font Awesome for simple projects; add build step only when needed.
- Use PHPStan (level 6–7 to start) for static analysis.

CI & workflow
- CI job (single) runs: install deps → format check (dry-run) → static analysis (phpstan) → lint JS (eslint --max-warnings=0) → run tests → run migrations check.
- Pre-commit: run formatter (php-cs-fixer --fix on staged PHP) and eslint --fix on staged JS.
- PR checklist: run formatters, run static analysis, add/update migrations, include tests for logic changes.

Legacy & incremental adoption
- Apply formatting only to files changed in a PR to avoid mass churn.
- Gradually raise PHPStan strictness; fix top-priority issues first.

Front-end guidance
- Keep JS minimal; prefer vanilla modules or small libs.
- Use Bootstrap classes for layout; document any custom components.
- Use Prettier to format markup and CSS; ESLint for logic.

Documentation
- Include short CONTRIBUTING.md with:
  - Commands: composer run-script format, composer run-script analyse, npm run lint, npm run format
  - Naming/casing summary (copy above)
  - How to run migrations and tests
- Add short “Style examples” (3–6 one-liners) demonstrating class, function, and SQL naming.

Agent rules (concise)
- Always run formatters before suggesting code patches.
- When reviewing PRs, flag PHPStan, php-cs-fixer, and ESLint violations with file/line and a suggested command to fix.
- For DB changes, require a migration file in db/migrations and a rollback note.
- Favor minimal, focused changes; avoid adding large build tooling unless needed.

Commands (copyable)
- Format PHP: composer run-script format
- Check PHP format: composer run-script format:check
- PHP static analysis: composer run-script analyse
- Lint JS (dev): npm run lint
- Format JS/CSS/HTML: npm run format
- Run tests: vendor/bin/phpunit

Use this file as CONTRIBUTING.md or include as a short SUMMARY section in your README.
