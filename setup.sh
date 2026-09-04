#!/bin/sh
# agent-skills bootstrap — symlink semua skills ke ~/.agents/skills/
set -e

SRC="$(cd "$(dirname "$0")" && pwd)/skills"
DEST="${AGENT_SKILLS_DIR:-$HOME/.agents/skills}"

mkdir -p "$DEST"

# diagram-design: repo ini plugin marketplace — skill asli nested di skills/diagram-design/
# dev-methodology & uiux-methodology: SKILL.md di root repo
link_skill() {
  skill="$1"
  src="$SRC/$skill"
  if [ ! -e "$src/SKILL.md" ] && [ -d "$src/skills/$skill" ]; then
    src="$src/skills/$skill"
  fi
  if [ -L "$DEST/$skill" ]; then
    rm "$DEST/$skill"
  elif [ -e "$DEST/$skill" ]; then
    echo "skip $skill: $DEST/$skill bukan symlink (folder asli) — biarkan"
    return
  fi
  ln -s "$src" "$DEST/$skill"
  echo "linked $skill -> $DEST/$skill"
}

link_skill dev-methodology
link_skill uiux-methodology
link_skill diagram-design

echo "OK. Semua skill aktif."