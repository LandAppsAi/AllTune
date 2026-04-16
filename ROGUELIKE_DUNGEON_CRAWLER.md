# Roguelike Dungeon Crawler — Game Pitch

## Core Loop
1. Descend into a procedurally generated floor.
2. Fight enemies in turn-based grid combat.
3. Loot gear, relics, and consumables.
4. Choose one of multiple exits with risk/reward modifiers.
5. Repeat until boss floor, then start a stronger New Game cycle.

## Pillars
- **Procedural variety**: layouts, enemies, and events reshuffle each run.
- **Meaningful choices**: every room choice trades safety for power.
- **Build expression**: classes + relic synergies create distinct playstyles.
- **Permadeath tension**: death resets the run, but meta-unlocks persist.

## Systems
- **Combat**: turn-based, tile movement, line-of-sight ranged attacks, status effects.
- **Classes**: Knight (armor), Arcanist (spell combos), Ranger (positioning), Warden (summons).
- **Progression**:
  - In-run: levels, talents, weapon upgrades.
  - Meta: unlock classes, relic pools, challenge modifiers.
- **Dungeon generation**:
  - Cellular automata + hand-authored room templates.
  - Biomes every 3 floors with unique hazards.
- **Economy**:
  - Gold for shops and shrines.
  - Corruption resource for powerful but risky upgrades.

## MVP Scope (8–12 weeks)
- 1 biome, 20 enemy types, 1 final boss.
- 3 playable classes.
- 80 relics, 40 items.
- 30 random events.
- Seeded daily run mode + local leaderboard.

## Art & Audio Direction
- Top-down pixel art with high-contrast silhouettes.
- Dynamic lighting in dark rooms.
- Layered soundtrack that intensifies per combat state.

## Optional Stretch Features
- Co-op asynchronous "ghost run" replays.
- Modifiers: cursed mode, one-hit mode, no-heal mode.
- In-game codex tracking enemies, relics, and lore.
