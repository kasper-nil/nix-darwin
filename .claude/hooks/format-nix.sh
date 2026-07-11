#!/usr/bin/env bash
# PostToolUse hook: after Claude edits a .nix file, format it with the flake's
# `nix fmt` (nixfmt-rfc-style) so agent-written Nix always lands clean. No-op for
# anything that isn't an existing .nix file. Never fails the tool call.
set -euo pipefail

# The hook payload arrives as JSON on stdin; pull out the edited file path.
file="$(python3 -c 'import json,sys; print(json.load(sys.stdin).get("tool_input",{}).get("file_path",""))' 2>/dev/null || true)"

case "$file" in
  *.nix) ;;
  *) exit 0 ;;
esac
[ -f "$file" ] || exit 0

cd "${CLAUDE_PROJECT_DIR:-"$(dirname "$0")/../.."}"
nix fmt --extra-experimental-features 'nix-command flakes' "$file" >/dev/null 2>&1 || true
exit 0
