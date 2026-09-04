# agent-skills 🧰

Skill aggregator pribadi — **satu clone, semua skill aktif**.

Submodule:

| Skill | Repo | Sumber |
|-------|------|--------|
| `dev-methodology` | github.com/ardith666/dev-methodology | fork sendiri (Superpowers + Fable + Ponytail) |
| `uiux-methodology` | github.com/ardith666/uiux-methodology | fork sendiri (anti-slop design intelligence) |
| `diagram-design` | github.com/ardith666/diagram-design | mirror upstream cathrynlavery/diagram-design |

## Bootstrap mesin baru

```bash
git clone --recurse-submodules git@github.com:ardith666/agent-skills.git
cd agent-skills && ./setup.sh
```

→ symlink `skills/*` ke `~/.agents/skills/` — langsung kepakai semua agent.

## Update rutin (semua skill)

```bash
cd agent-skills && git submodule update --remote && ./setup.sh
```

## Update diagram-design ke versi upstream terbaru

```bash
cd agent-skills && ./sync.sh
```

(`sync.sh` narik upstream → push ke mirror → update submodule → commit pointer → push. Setelah itu mesin lain cukup `git pull && ./setup.sh`.)

## Tambah skill baru

1. `git submodule add <repo> skills/<nama>`
2. Tambah baris di loop `setup.sh`
3. Tambah baris tabel di atas
4. Commit + push → semua mesin ikut via update rutin

## Struktur

```
agent-skills/
├── .gitmodules          # pointer submodule
├── setup.sh             # symlink skills → ~/.agents/skills/
├── sync.sh              # sync mirror + update submodule
└── skills/
    ├── dev-methodology/
    ├── uiux-methodology/
    └── diagram-design/
```

Detail workflow & integrasi: lihat `coding/agent-skills.md` di vault Obsidian (dibuat 2026-09-05).

> Kenapa submodule, bukan symlink di repo? Symlink git gak bisa nunjuk file repo lain — path beda tiap mesin. Submodule = pointer commit, direalisasi jadi folder nyata pas clone. Kenapa mirror, bukan upstream langsung? Kalau repo upstream dihapus/diprivate, submodule mogok. Mirror = kendali penuh.