#!/bin/sh
# Sync mirror diagram-design dari upstream, lalu tarik update semua submodule.
set -e

MIRROR_DIR="${MIRROR_DIR:-$HOME/code/diagram-design-mirror}"

echo "== 1/2 sync mirror diagram-design dari upstream =="
if [ -d "$MIRROR_DIR" ]; then
  cd "$MIRROR_DIR"
  git fetch upstream 2>/dev/null || git remote add upstream https://github.com/cathrynlavery/diagram-design.git && git fetch upstream
  git push origin --mirror
else
  echo "MIRROR_DIR=$MIRROR_DIR tidak ada. Skip mirror sync. Clone dulu:"
  echo "  git clone --bare https://github.com/cathrynlavery/diagram-design.git $MIRROR_DIR"
  echo "  cd $MIRROR_DIR && git remote add upstream https://github.com/cathrynlavery/diagram-design.git"
  echo "  git push --mirror https://github.com/ardith666/diagram-design.git"
fi

echo "== 2/2 update submodule agent-skills =="
cd "$(dirname "$0")"
git submodule update --remote
git add .
git -c commit.gpgsign=false commit -m "chore: sync submodules $(date +%Y-%m-%d)" 2>/dev/null || echo "tidak ada perubahan pointer"
git push

echo "OK. Update mesin lain: cd agent-skills && git pull && ./setup.sh"