#!/bin/env bash

MSG_FILE="$1"
SOURCE="$2"
SHA="$3"

# Only auto-generate when no message source is provided
if [ -n "$SOURCE" ]; then
    exit 0
fi

branch=$(git symbolic-ref --short HEAD 2>/dev/null || echo "detached")
diff=$(git diff --cached)

if [ -z "$diff" ]; then
    exit 0
fi

prompt="Generate a concise git commit message for the following changes.
Rules:
- First line: imperative mood, under 72 chars, no period
- If needed, add a blank line then bullet-point body
- No markdown fences, no preamble, just the message

Branch: $branch

Diff:
$diff"

echo "=== Asking claude code to generate commit message"
msg=$(claude --print --model haiku "$prompt" 2>/dev/null)

if [ $? -eq 0 ] && [ -n "$msg" ]; then
    echo "$msg" > "$MSG_FILE"
fi
