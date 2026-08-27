#!/bin/bash
# Claude Code PostToolUse hook wrapper — delegates to the canonical lint script.
# The single source of truth for lint rules is scripts/lint-kms.sh (also used by CI).

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
exec bash "$SCRIPT_DIR/../../scripts/lint-kms.sh" "$@"
