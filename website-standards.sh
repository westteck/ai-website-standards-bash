#!/usr/bin/env bash
set -euo pipefail

# bootstrap_project.sh
# Creates minimal configs for PHP 8.3 + Bootstrap5+FontAwesome + MySQL projects.
# Does NOT run composer/npm installs or initialize git. (Per user request)

ROOT=$(pwd)
echo "Bootstrapping project at $ROOT"

# Helper to write files
write() { cat > "$1" <<'EOF'
%CONTENT%
EOF
}

# .editorconfig
write .editorconfig
root = true

[*]
charset = utf-8
end_of_line = lf
insert_final_newline = true
indent_style = space
indent_size = 4
trim_trailing_whitespace = true

[*.php]
indent_style = space
indent_size = 4

[*.{js,jsx,ts,tsx,json,css,scss,md}]
indent_style = space
indent_size = 2
EOF

# php-cs-fixer config
write .php-cs-fixer.php
<?php

$finder = PhpCsFixer\Finder::create()
    ->in(__DIR__ . '/src')
    ->name('*.php')
    ->exclude('vendor')
    ->ignoreDotFiles(true)
    ->ignoreVCS(true);

return (new PhpCsFixer\Config())
    ->setRules([
        '@PSR12' => true,
        'array_syntax' => ['syntax' => 'short'],
        'binary_operator_spaces' => ['operators' => ['=' => 'align_single_space_minimal']],
        'no_unused_imports' => true,
        'single_quote' => true,
        'trim_array_spaces' => true,
    ])
    ->setFinder($finder);
EOF

# phpstan config
write phpstan.neon
includes:
  - vendor/phpstan/phpstan/conf/bleedingEdge.neon

parameters:
  level: 6
  paths:
    - src
  autoload_files:
    - %currentWorkingDirectory%/vendor/autoload.php
EOF

# composer.json minimal scripts (will not modify dependencies)
if [ ! -f composer.json ]; then
write composer.json
{
  "name": "vendor/project",
  "description": "Bootstraped PHP 8.3 project",
  "type": "project",
  "require": {
    "php": "^8.3"
  },
  "require-dev": {
    "friendsofphp/php-cs-fixer": "^3.0",
    "phpstan/phpstan": "^1.10"
  },
  "scripts": {
    "format": "vendor/bin/php-cs-fixer fix src --config=.php-cs-fixer.php",
    "format:check": "vendor/bin/php-cs-fixer fix src --config=.php-cs-fixer.php --dry-run --diff",
    "analyse": "vendor/bin/phpstan analyse src --level=6"
  },
  "autoload": {
    "psr-4": {
      "App\\\\": "src/"
    }
  }
}
EOF
else
  echo "composer.json exists; leaving intact."
fi

# package.json for JS tooling
if [ ! -f package.json ]; then
write package.json
{
  "name": "project-frontend",
  "private": true,
  "devDependencies": {
    "eslint": "^8.0.0",
    "eslint-config-airbnb-base": "^15.0.0",
    "eslint-plugin-import": "^2.0.0",
    "prettier": "^2.0.0",
    "eslint-config-prettier": "^8.0.0",
    "eslint-plugin-prettier": "^5.0.0"
  },
  "scripts": {
    "lint": "eslint src --ext .js,.jsx || true",
    "lint:ci": "eslint src --ext .js,.jsx --max-warnings=0",
    "format": "prettier --write \"src/**/*.{js,jsx,css,scss,html}\""
  }
}
EOF
else
  echo "package.json exists; leaving intact."
fi

# .eslintrc.js
write .eslintrc.js
module.exports = {
  env: {
    browser: true,
    es2021: true
  },
  extends: ['airbnb-base', 'prettier'],
  plugins: ['prettier'],
  rules: {
    'prettier/prettier': 'error',
    'no-console': 'off',
    'import/no-extraneous-dependencies': ['error', { devDependencies: true }]
  }
};
EOF

# .prettierrc
write .prettierrc
{
  "printWidth": 100,
  "singleQuote": true,
  "trailingComma": "es5",
  "tabWidth": 2,
  "semi": true
}
EOF

# .pre-commit-config.yaml (uses pre-commit; does not install)
write .pre-commit-config.yaml
repos:
  - repo: https://github.com/pre-commit/mirrors-eslint
    rev: v8.44.0
    hooks:
      - id: eslint
        name: eslint
        entry: npx eslint
        language: node
        files: '\\.(js|jsx)$'
  - repo: https://github.com/FriendsOfPHP/php-cs-fixer
    rev: v3.15.0
    hooks:
      - id: php-cs-fixer
        name: php-cs-fixer
        entry: vendor/bin/php-cs-fixer
        language: system
        files: '\\.php$'
EOF

# .gitattributes
write .gitattributes
* text=auto
*.php text eol=lf
*.js text eol=lf
EOF

# CONTRIBUTING.md
write CONTRIBUTING.md
# Contributing - Coding standards (short)

## Running tools (local)
- Format PHP: composer run-script format
- Check PHP formatting: composer run-script format:check
- PHP static analysis: composer run-script analyse
- Lint JS: npm run lint
- Format JS/CSS/HTML: npm run format

## Naming & casing (summary)
- PHP classes: PascalCase (UserController)
- PHP files: kebab-case or lower_snake_case (pick one per repo)
- Methods/variables: camelCase (getUserById)
- Constants: UPPER_SNAKE_CASE
- DB tables/columns: lower_snake_case (e.g., user_profile, order_item)
- Foreign keys: {referenced_table}_id (user_id)

## DB
- Keep migrations in db/migrations numbered or timestamped.
- Use prepared statements or parameterized queries.
- Include created_at and updated_at where useful.

## Pull requests
- Run formatters and linters before opening a PR.
- Add tests or migration verification for DB changes.
EOF

# Simple DB migrations folder and sample
mkdir -p db/migrations
write db/migrations/001_create_users.sql
-- 001_create_users.sql
CREATE TABLE user (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  username VARCHAR(100) NOT NULL UNIQUE,
  email VARCHAR(255) NOT NULL UNIQUE,
  password_hash VARCHAR(255) NOT NULL,
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
EOF

# README snippet update (append)
cat >> README.md <<'EOF'

## Coding standards (short)
- PHP: PSR-12 via php-cs-fixer; run `composer run-script format`.
- Static analysis: PHPStan via `composer run-script analyse`.
- JS: Airbnb + Prettier; run `npm run format` and `npm run lint`.
- DB: migrations in db/migrations; use lower_snake_case and prepared statements.
EOF

# Agent rules files (opencode and hermes)
write opencode-agent.yaml
name: opencode-agent
description: >
  Agent rules/skills for enforcing and following project coding standards.
rules:
  - id: formatting
    description: "Auto-format code according to project config before producing patches."
    priority: high
    actions:
      - run_formatter: ["php-cs-fixer", "prettier"]
  - id: linting
    description: "Run linters and static analysis; report actionable errors with file/line."
    priority: high
    actions:
      - run_linter: ["phpstan", "eslint"]
  - id: db_migrations
    description: "Require migrations to be in db/migrations and include rollback plan."
    priority: medium
  - id: naming
    description: "Enforce naming/casing rules (PHP PascalCase/classes, camelCase methods, lower_snake_case DB)."
    priority: medium
  - id: minimal-deps
    description: "Prefer minimal dev dependencies and avoid frontend build bloat unless necessary."
    priority: low
EOF

write hermes-agent.yaml
name: hermes-agent
description: >
  Agent rules/skills for project messaging assistants (Hermes) to follow the project's standards.
skills:
  - id: provide_format_commands
    description: "When asked, return exact commands to format/lint/analyse the project (composer/npm scripts)."
  - id: review_patch
    description: "When reviewing patches, flag style, lint, and phpstan violations; suggest fixes using project tools."
  - id: db_review
    description: "When DB changes appear, ensure migrations provided, schema naming follows lower_snake_case, and timestamps present."
  - id: minimal_explanations
    description: "Prefer short, actionable responses with command lines and exact file edits; avoid lengthy theory."
EOF

# Permissions
chmod 644 .editorconfig .php-cs-fixer.php phpstan.neon .eslintrc.js .prettierrc .pre-commit-config.yaml .gitattributes CONTRIBUTING.md db/migrations/001_create_users.sql opencode-agent.yaml hermes-agent.yaml 2>/dev/null || true

echo "Bootstrap files created."
echo ""
echo "Next steps (manual):"
echo "- Install PHP dev deps: composer install"
echo "- Install JS dev deps: npm ci"
echo "- Install pre-commit if you want hooks: pip install pre-commit && pre-commit install"
echo "- Adjust paths in .php-cs-fixer.php and phpstan.neon if your PHP sources are not in ./src"
echo "- Customize agent YAML files as needed for your agent implementations"
echo ""
echo "Done."
