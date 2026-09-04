#!/bin/sh
# agent-skills bootstrap — symlink semua skills ke ~/.agents/skills/
set -e

SRC="$(cd "$(dirname "$0")" && pwd)/skills"
DEST="${AGENT_SKILLS_DIR:-$HOME/.agents/skills}"

mkdir -p "$DEST"

for skill in dev-methodology uiux-methodology diagram-design; do
  rm -f "$DEST/$skill"          # replace stale symlink, keep real dirs untouched
  ln -s "$SRC/$skill" "$DEST/$skill"
  echo "linked $skill -> $DEST/$skill"
done

echo "OK. Semua skill aktif."