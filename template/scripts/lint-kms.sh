#!/bin/bash
# KMS Lint — validates naming and structure conventions on Markdown files.
# Used two ways:
#   1. As a Claude Code PostToolUse hook on Write|Edit (wired in .claude/settings.json,
#      via the wrapper .claude/hooks/lint-kms.sh). Hook input JSON arrives on stdin;
#      TOOL_INPUT_file_path or $1 are also accepted for compatibility.
#   2. From CI or the command line: scripts/lint-kms.sh <file> [<file> ...]

# --- Resolve repo root relatively (no absolute machine paths) ---
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
KMS_ROOT="$(git -C "$SCRIPT_DIR" rev-parse --show-toplevel 2>/dev/null)"
if [ -z "$KMS_ROOT" ]; then
  KMS_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
fi

# --- Resolve target file path: env var, argv, or hook JSON on stdin ---
FILE_PATH="${TOOL_INPUT_file_path:-$1}"

if [ -z "$FILE_PATH" ] && [ ! -t 0 ]; then
  STDIN_JSON="$(cat)"
  if [ -n "$STDIN_JSON" ]; then
    if command -v jq >/dev/null 2>&1; then
      FILE_PATH="$(printf '%s' "$STDIN_JSON" | jq -r '.tool_input.file_path // empty' 2>/dev/null)"
    else
      FILE_PATH="$(printf '%s' "$STDIN_JSON" | sed -n 's/.*"file_path"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p' | head -1)"
    fi
  fi
fi

if [ -z "$FILE_PATH" ]; then
  exit 0
fi

lint_file() {
  local FILE_PATH="$1"
  local REL_PATH="${FILE_PATH#$KMS_ROOT/}"

  # Skip non-markdown files
  if [[ "$REL_PATH" != *.md ]]; then
    return 0
  fi

  # Skip system files
  if [[ "$REL_PATH" == .claude/* ]] || [[ "$REL_PATH" == .github/* ]] || [[ "$REL_PATH" == infra/apps/* ]]; then
    return 0
  fi

  local FILENAME
  FILENAME=$(basename "$REL_PATH")
  local ERRORS=""

  # --- Rule 1: Date-first naming in signals/ and meetings/ ---
  # Files in any 1.signals/ or meetings/ directory must start with a date pattern
  if echo "$REL_PATH" | grep -qE '(^|/)1\.signals/[^/]+$' || echo "$REL_PATH" | grep -qE '(^|/)meetings/[^/]+$'; then
    # Allow README.md and index files
    if [[ "$FILENAME" != "README.md" ]] && [[ "$FILENAME" != "index.md" ]]; then
      # Check for date-first pattern: YYYY-MM-DD or YYYYMMDD
      if ! echo "$FILENAME" | grep -qE '^[0-9]{4}-?[0-9]{2}-?[0-9]{2}'; then
        ERRORS="${ERRORS}NAMING: Files in signals/ and meetings/ must use date-first naming (YYYY-MM-DD-topic.md or YYYYMMDD-topic.md). Got: $FILENAME\n"
      fi
    fi
  fi

  # --- Rule 2: No APE phase subdirectories in 3.specs/ ---
  # Phase dirs (1.discovery, 2.define, 3.deliver, etc.) should NOT exist as subdirs of 3.specs/
  if echo "$REL_PATH" | grep -qE '(^|/)3\.specs/[0-9]+\.(discovery|define|deliver|deploy|communicate|support|iterate)/'; then
    ERRORS="${ERRORS}STRUCTURE: APE phases are metadata, not directories. Do not create phase subdirectories in 3.specs/. Use YAML frontmatter (phase: X) instead. Path: $REL_PATH\n"
  fi

  # Also catch unnumbered phase dirs in specs
  if echo "$REL_PATH" | grep -qE '(^|/)3\.specs/(discovery|define|deliver|deploy|communicate|support|iterate)/'; then
    ERRORS="${ERRORS}STRUCTURE: APE phases are metadata, not directories. Do not create phase subdirectories in 3.specs/. Use YAML frontmatter (phase: X) instead. Path: $REL_PATH\n"
  fi

  # --- Rule 3: Validate YAML frontmatter phase value ---
  if [ -f "$FILE_PATH" ]; then
    # Check if file starts with ---
    local FIRST_LINE
    FIRST_LINE=$(head -1 "$FILE_PATH" 2>/dev/null)
    if [ "$FIRST_LINE" = "---" ]; then
      # Extract phase value from frontmatter
      local PHASE_VALUE
      PHASE_VALUE=$(sed -n '/^---$/,/^---$/p' "$FILE_PATH" 2>/dev/null | grep -E '^phase:' | head -1 | sed 's/^phase:\s*//' | tr -d '[:space:]')
      if [ -n "$PHASE_VALUE" ]; then
        local VALID_PHASES="pre_sale discovery define deliver deploy communicate support iterate"
        if ! echo "$VALID_PHASES" | grep -qw "$PHASE_VALUE"; then
          ERRORS="${ERRORS}FRONTMATTER: Invalid phase value '$PHASE_VALUE'. Must be one of: $VALID_PHASES\n"
        fi
      fi
    fi
  fi

  # --- Rule 4: No time estimates (weeks, days, hours) in intents/specs ---
  if echo "$REL_PATH" | grep -qE '(^|/)3\.specs/' || echo "$REL_PATH" | grep -qE '(^|/)2\.intents/'; then
    if [ -f "$FILE_PATH" ]; then
      local TIME_MATCHES
      TIME_MATCHES=$(grep -niE '\b[0-9]+\s*(weeks?|days?|hours?|months?)\b' "$FILE_PATH" 2>/dev/null | head -3)
      if [ -n "$TIME_MATCHES" ]; then
        ERRORS="${ERRORS}SIZING: Use S/M/L effort sizing, not time estimates. Found time references in $FILENAME:\n$TIME_MATCHES\n"
      fi
    fi
  fi

  # --- Output ---
  if [ -n "$ERRORS" ]; then
    echo ""
    echo "=== KMS Lint Warning ==="
    echo -e "$ERRORS"
    echo "See the KMS conventions in CLAUDE.md and the KMS Backbone docs."
    echo "========================"
    return 1
  fi

  return 0
}

EXIT_CODE=0
if [ "$#" -gt 1 ]; then
  # CI mode: lint every file passed as an argument
  for f in "$@"; do
    lint_file "$f" || EXIT_CODE=1
  done
else
  lint_file "$FILE_PATH" || EXIT_CODE=1
fi

# Non-zero exit surfaces the warning to the agent (non-blocking for PostToolUse)
exit $EXIT_CODE
