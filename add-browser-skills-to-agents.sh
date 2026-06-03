#!/usr/bin/env bash

# Exit immediately if a command exits with a non-zero status
set -e

echo "=== Initializing OpenCode Headless Browser Environment ==="

# 1. Detect configuration directories
OPENCODE_DIR="$HOME/.config/opencode"
SKILLS_DIR="$OPENCODE_DIR/skills"
COMMANDS_DIR="$OPENCODE_DIR/commands"

echo "Creating OpenCode system paths..."
mkdir -p "$SKILLS_DIR"
mkdir -p "$COMMANDS_DIR"

# 2. Install Headless Browser Testing Infrastructure via NPM
echo "Checking and installing local browser dependencies..."
if ! command -v npm &> /dev/null; then
    echo "Error: Node.js and npm are required. Please install them on your host system first."
    exit 1
fi

# Install Playwright globally or locally within the configuration root to keep it isolated
npm install -g playwright || npm install --prefix "$OPENCODE_DIR" playwright

# Install browser binaries required by Playwright
echo "Downloading headless browser engines (Chromium)..."
npx playwright install chromium --with-deps

# 3. Create the Native Browser Testing Skill File
echo "Deploying browser-testing skill to: $SKILLS_DIR/ui-verification.md"
cat << 'EOF' > "$SKILLS_DIR/ui-verification.md"
---
name: ui-verification
description: Uses a headless browser to verify local web UI layouts, fetch console logs, and trap runtime JS errors.
tools_required: [bash, read_file]
---
## Objective
Execute a headless browser runtime instance to assert that your local or containerized application renders error-free.

## Execution Matrix
1. **Target Identification:** Identify the target application endpoint. Default to `http://localhost:8000` (or your active Docker bridge port) unless specified.
2. **Execution Vector:** Use `npx playwright` or execute automated test scripts.
3. **Audit Pipeline:**
   - Trap and print browser-level console errors (`console.error`).
   - Catch unhandled script exceptions or failed assets (404/500 HTTP responses).
   - If a layout anomaly occurs, capture a baseline screenshot to `/tmp/opencode_ui_debug.png`.
EOF

# 4. Create the Custom /test-ui Slash Command File
echo "Deploying slash command to: $COMMANDS_DIR/test-ui.md"
cat << 'EOF' > "$COMMANDS_DIR/test-ui.md"
---
description: Instructs the agent to run local headless browser suites and analyze the results.
mode: command
---
Execute a quick automated headless browser audit against the current web interface to ensure your changes didn't break layout rendering or trigger runtime console errors.

Run the local headless suite wrapper:
!`npx playwright test`

Review any assertion failures or traceback logs emitted by the runner. Propose precise code or style layout corrections if components fail to mount or render.
EOF

# 5. Configuration Warning
echo "=========================================================="
echo "SUCCESS: OpenCode browser environment generated successfully."
echo "=========================================================="
echo "CRITICAL STEPS REMAINING:"
echo "1. Verify that your primary router (AGENTS.md) allows your subagents"
echo "   to use the 'webfetch' or 'bash' capabilities to touch this infrastructure."
echo "2. If your app runs inside Docker, make sure your local host environment"
echo "   can resolve the container endpoint port (e.g., localhost:8000)."
