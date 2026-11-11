# Gemini prompt: build Lumina Grove in Roblox Studio

Paste this whole document into Roblox Studio’s Gemini assistant. Also attach the six reference images in the `references/` folder of this repo:

- `grove-wide.jpg` — dusk grove, mood and lighting
- `layout-iso.jpg` — block layout to rebuild with Parts
- `bed-closeup.jpg` — one ripe bed
- `fruits.jpg` — the eight glims and coat colors
- `characters.jpg` — the five original NPCs, left to right: Wren Calder, Nim Soot, Dr. Ivo Pell, Mara Quill, Captain Lumen Vale
- `ui-mock.jpg` — HUD color and layout only. Do not copy any fake lettering on it.

Build a playable original game. Do not mention, copy, or resemble mushroom tycoons, mushroom models, or any other game’s names, icons, or thumbnails. The crop is a glim: a living lantern-fruit. The place is Bramblewick cove. The game is Lumina Grove.

## How to work

1. Build in small steps. After each step, leave the place playable and tell me what to press.
2. Use only Roblox parts, ProximityPrompts, ClickDetectors, SurfaceGuis or BillboardGuis, and ScreenGuis. No imported meshes unless I ask later. Match the reference images with simple blocky parts and Neon fruit.
3. Server scripts own all money, seeds, inventory, and growth. The client only draws the HUD and sends requests. Never trust the client for prices or quest progress.
4. One grove per player, cloned when they join, destroyed when they leave. Offset each grove by 190 studs on X so friends do not share beds.
5. First harvest must be possible in under 30 seconds. Start the player with 42 embers and 3 Wickpear cuttings. Wickpear grows in 8 seconds.
6. Save with DataStore `LuminaGroveV1` inside pcall. If the store fails, the session still plays and the HUD says saves need API access.

## Story

You inherit a dead grove at Bramblewick cove. The last steward left a deed, three cuttings, and five unlit beacons. Wild glims still drop cuttings in the thicket if you cut on time. You plant them, sell them to Mara Quill’s night market, hire Nim Soot’s kindlefolk, let Dr. Ivo Pell coat the rinds in a prism still, and feed the five beacons what Captain Lumen Vale says they eat. When the last beacon takes a Prismheart, Vale gives you the only Beaconfruit cutting he kept in a tin. Harvest it and the cove has a steward again.

Tone: quiet, specific, a little dry. No jokes about mushrooms. No “epic quest.” Short sentences.

Chapter names:

1. The deed — Wren Calder, cartographer
2. Kindlefolk — Nim Soot
3. The still — Dr. Ivo Pell
4. Night market — Mara Quill
5. The five wicks — Captain Lumen Vale

After the last quest, Vale offers repeating steward contracts: every 12 more lifetime harvests pays 90 embers, and every second contract also pays 1 starshard.

## Characters

Build each NPC as a simple block person or an R15 rig with clothing colors only. No classic Roblox package copies. Names on a BillboardGui above the head.

- Wren Calder. Cartographer. Olive coat, ink-stained cuffs, a rolled map. Short dark hair. She leaves after chapter 1.
- Nim Soot. Kindlefolk. Soot on the cheeks, leather apron, a small lantern. Warm brown skin, cropped hair. Hires extra hands.
- Dr. Ivo Pell. Prism still. Pale coat, round spectacles, silver hair tied back, a glass vial. Precise, not friendly.
- Mara Quill. Night broker. Long charcoal coat, a ledger. Sharp bob. She prices the dark and punishes flooding one fruit.
- Captain Lumen Vale. Retired beacon keeper. Older, sea-grey cloak, brass lantern hook, white at the temples. Speaks softly and only about what beacons eat.

## Place layout, one grove

Dark green ground part, about 150 x 1 x 120, color #1a2420, sitting on the baseplate.

Center, 5 columns by 3 rows of beds. Each bed is a 7 x 1 x 7 part, color #3a3228, 10 studs apart. Locked beds are darker, #1c1a18. A BillboardGui says Plant, a countdown, Ripe plus the fruit name, the unlock price, or Later.

Fruit is an anchored ball or block, CanCollide false, colored by species, scaled from small to full as it grows, hidden when the bed is empty. Ripe fruit uses Neon.

Behind the beds, five beacon pillars, 1.2 x 6 x 1.2. Unlit: smooth plastic #28302c. Lit: Neon #9cbea4.

Player’s right: four thicket pads in a column, 6 x 1 x 6, moss green. Names: East ditch, Owl stump, Glass run, Old wick. Each has a ProximityPrompt “Forage”.

Player’s left, three stalls:

- Ember stall, shop, prompt Browse
- Night market, prompt Sell all, Mara
- Prism still, prompt Coat one. A smaller kettle beside it, prompt Brew prism

Front: a quest board, prompt Turn in. A SpawnLocation at the front of that grove only. Set `player.RespawnLocation` to it and move the character there on spawn. Do not leave them on the default baseplate spawn.

Only the owner of a grove can use its prompts and clicks. Other players get a short notice.

## Colors

Background #101412. Panels #1a211c and #24302a. Text #e8efe9. Muted text #9aaba0. Lines #314038. Accent buttons #d7e3d8 with ink text #121816. Good/sage #9cbea4. Warn clay #d2a892. Danger #d08a84. Soil #3a3228. Deep soil #221c16.

Fruit colors:

- Wickpear #e6d0b8, cream lantern-pear, a small brighter core
- Mossbell #6f9464, a hanging bell
- Tideplum #7ea4b8, a cold blue sphere
- Cinderfig #c4784a, a fig shape
- Glassbloom #d5e6ea, five pale petals around a light seed
- Nightcitrus #3d5670, a dark citrus, edges slightly lighter
- Prismheart #c5d0c8, a faceted heart, not plantable
- Beaconfruit #efe6d6, an ivory lantern

HUD: Gotham or Builder Sans. Top bar with grove title and the player’s title, embers, starshards, and a SURGE tag when the market is hot. Under that, a quest button. If the quest is complete, the button starts with “Turn in”. Clicking it asks the server to turn the quest in. A toast at the bottom shows the latest notice for about 2.5 seconds.

No purple UI. No gold chrome. Clay and cream belong on fruit, not on buttons.

## Species

All prices are integers.

| id | name | rank | sell price | grow seconds | seed price | chapter required | plantable |
| --- | --- | --- | --- | --- | --- | --- | --- |
| wickpear | Wickpear | 0 | 14 | 8 | 6 | 1 | yes |
| mossbell | Mossbell | 1 | 28 | 11 | 16 | 1 | yes |
| tideplum | Tideplum | 2 | 58 | 16 | 34 | 2 | yes |
| cinderfig | Cinderfig | 2 | 72 | 18 | 42 | 2 | yes |
| glassbloom | Glassbloom | 3 | 140 | 26 | 86 | 3 | yes |
| nightcitrus | Nightcitrus | 3 | 180 | 30 | 110 | 3 | yes |
| prismheart | Prismheart | 4 | 320 | 0 | 0 | 3 | no, brewed only |
| beaconfruit | Beaconfruit | 5 | 520 | 34 | 0 | 5 | yes, quest reward only |

Blurbs, use these in a codex later if you have time:

- Wickpear: a cream lantern-pear. The wick inside never quite goes out.
- Mossbell: a hanging bell of living moss. Ripe ones hum if you lean in.
- Tideplum: glass-blue and cold. Tastes like rain on an iron rail.
- Cinderfig: split the skin and the seeds are still warm.
- Glassbloom: clear petals around a seed of held light.
- Nightcitrus: indigo segments. The rind stays dark. The edges do not.
- Prismheart: stabilized in the still. It will not grow in soil.
- Beaconfruit: ivory lantern-fruit. Vale kept the only cutting in a tin.

Glassbloom and Nightcitrus are the rare slate. Only one of them is for sale at a time. The slate swaps every 75 seconds. A pin, bought with shards, holds the current one for another 75 seconds.

Growth time when planted is `floor(baseGrow * sprinklerMul * (0.92 ^ sproutTenders))`, minimum 3 seconds. Sprinkler tiers 0 to 3 use multipliers 1, 0.84, 0.70, 0.56. Sprout tenders do not speed plants already in the ground. Upgrades apply to the next planting.

## Stars and coats

Every planted glim starts at 2 stars. Stars are 1, 2, or 3.

Star sell multipliers: 1 = 1, 2 = 1.55, 3 = 2.35.

Shears are a tool, not a seed. Tier 0 has no bonus. Tier 1 is 18 percent and tier 2 is 34 percent to gain one star on a manual harvest, never above 3. Kindlehands do not roll shears.

Coats, from the still, replace the mutation on one harvested fruit:

| id | name | sell multiplier | weight |
| --- | --- | --- | --- |
| none | Plain | 1 | not rolled |
| frosted | Frosted | 1.8 | 40 |
| emberwash | Emberwash | 2.2 | 28 |
| voidvein | Voidvein | 2.8 | 18 |
| twincore | Twincore | 3.5 | 9 |
| aurorarind | Aurora rind | 4.6 | 5 |

Coat cost is `36 + rank * 28` embers. Do not coat a Prismheart or a Beaconfruit. Show the coat as a second transparent shell or a color shift on the fruit part. Frosted is pale, emberwash is clay-warm, voidvein is dark cracks, twincore is two touching cores, aurora rind is a thin mist band.

Sell price of one fruit:

`max(1, floor(basePrice * starMul * coatMul * heatMul * surgeMul))`

`heatMul = 1 - heat * 0.4`. Heat per species starts at 0, rises by 0.07 per fruit of that species sold, and is capped at 1. Decay heat with roughly `heat * exp(-dt / 48)` once a second. This is how Mara punishes flooding one fruit.

`surgeMul` is 1.5 while a night surge is active, else 1. A surge lasts 20 seconds. The next one starts 72 seconds after the previous start. The first surge can arrive about 28 seconds after the server starts. While it is up, the HUD says SURGE and a notice says the cove is overpaying.

## Starting state

```
embers = 42
shards = 0
seeds = { wickpear = 3 }
inventory = empty
plots = 15 slots, empty
unlockedPlots = 6
kindlehands = 0
sproutTenders = 0
brokers = 0
sprinkler = 0
shears = 0
questIndex = 1
beacons = five false
title = "Deed holder"
discovered = empty
stats all 0: foraged, planted, harvested, sold, mutations, harvestedRare, surgeSold, boughtRare, harvestedBeacon
contractMark = 0
```

Leaderstats show Embers and Shards.

## Beds

15 beds. The first 6 are open. The next bed’s price, in order, is 55, 95, 160, 260, 420, 680, 1100, 1700, 2600. You can only unlock the next locked bed, not a later one. Click a locked next bed to buy it with embers. A plot token in the shop spends 8 shards to open the next bed.

Click an empty open bed to open a seed list of cuttings the player actually holds. Click a growing bed to be told it is still growing. Click a ripe bed to harvest into inventory.

Inventory stacks are keyed by species + coat + stars. Harvest adds 1. Selling clears the whole inventory for the sum of stack prices and adds that sum to lifetime `sold`.

A Kindlehand harvests one ripe fruit every 3.6 seconds, divided by how many you have. Four hands empty ripe beds about every 0.9 seconds. They do not plant.

## Shop

Prompt on the ember stall opens a list. The server checks the price again when the client says buy.

Seed rows for every plantable species that has a seed price. Disabled if the chapter is too early, if the player cannot afford it, or if it is Glassbloom or Nightcitrus and it is not the current rare slate.

Hire rows:

- Kindlehand, max 4, costs 160, 280, 460, 720
- Sprout tender, max 4, costs 150, 260, 420, 680
- Night broker, max 3, costs 300, 520, 880

Brokers are a later convenience. For this version, each broker can raise surge length by 4 seconds or show the player the seconds until the next surge. Do not let brokers print money.

Sprinkler tiers cost 140, then 520, then 1800. Shears cost 100, then 360.

Shard items, always available if the player has shards:

- Hasten, 2 shards, subtract 30 seconds from every plantedAt
- Pin rare slate, 3 shards
- Plot token, 8 shards

Buying Glassbloom or Nightcitrus sets boughtRare to at least 1.

## Forage

Four nodes, each on a 9 second cooldown per player. The server rolls the reward. Do not let the client pick the species.

Weights by current quest chapter:

- Always: Wickpear 58, Mossbell 36
- Chapter 2 or later also: Tideplum 18, Cinderfig 14
- Chapter 3 or later also: Glassbloom 7, Nightcitrus 4

Stars on a wild cutting: 22 percent chance of 3 stars, else a coin flip between 2 and 1. The player gains 1 seed of that species, plus `2 + stars` embers. A 3-star cut has a 12 percent chance of 1 starshard. Discover the species. Notice text: “Cut a wild Wickpear.” or, if a shard dropped, “Clean cut. Wickpear cutting and a starshard.”

## Still

Coat one: take the first inventory stack that is not Prismheart or Beaconfruit. If the player cannot afford the coat, say the cost. Otherwise remove one fruit, roll a coat by weight, and add it back with the same stars. Increment mutations.

Brew prism, only in chapter 3 or later: costs 180 embers and consumes one Glassbloom and one Nightcitrus from inventory, any coat. Adds one Prismheart at 3 stars, mutation none. Increment mutations. If the ingredients are missing, say so.

## Quests

Turn-in is explicit. Standing near the board or pressing the HUD button calls the server. If the goal is not met, repeat the detail. If it is a delivery, remove the fruits from inventory first. Then pay the reward, advance questIndex by 1, and light the beacon if the quest has one.

Dialogue to show when the quest becomes current, and the line when it is turned in:

1. Wren, stat foraged >= 3. “Read the thicket.” Intro: “The deed is yours. The lower beds are asleep, but the thicket still drops cuttings if you know the timing. Bring me three.” Done: “Good hands. The thicket likes a patient cut. Plant before they dry.” Reward: 20 embers, 2 Mossbell seeds.
2. Wren, planted >= 2. “Wake two beds.” Intro: “Soil first, stories later. Two beds. Anything that will take.” Done: “They remember how to grow. Stay for the ripening. It is quicker than you fear.” Reward: 18 embers.
3. Wren, harvested >= 4. “The first glow.” Intro: “When the fruit stands up in the bed, take it. Four, then we talk coin.” Done: “Four lights. The cove will smell this on the wind.” Reward: 30 embers and shears tier raised to at least 1.
4. Wren, sold >= 80. “Pay the cart.” Intro: “Mara will not open a stall for a rumor. Sell through the night market until the cart fee is covered. Eighty embers.” Done: “Fee paid. I am leaving you with Nim. I still have a coastline to redraw.” Reward: 40 embers, 1 shard.
5. Nim, kindle >= 1. “A second pair of hands.” Intro: “Wren talks like a map. I talk like soot. Hire a Kindlehand from the shop and the ripe beds stop waiting on you.” Done: “Listen. That little hush is them picking. Do not thank them. Pay them.” Reward: 1 sprout tender and 30 embers.
6. Nim, unlocked plots >= 8. “Break new soil.” Intro: “Six beds is a windowsill. Unlock two more. The grove should look like a grove.” Done: “Better. Roots have opinions about space.” Reward: 70 embers.
7. Nim, harvested >= 20. “A working grove.” Intro: “Keep the loop mean and simple. Twenty harvests. Then the doctor wants you.” Done: “You are past the hobby. Pell is already heating glass for you.” Reward: 1 shard, sprinkler raised to at least 1, 1 Tideplum seed, 1 Cinderfig seed.
8. Pell, mutations >= 1. “Heat the still.” Intro: “Bring a harvested glim to the prism still. I am not asking for a miracle. A frost coat will do. Observe the rind.” Done: “Acceptable refraction. The coat is worth more than the fruit. Remember that when you sell.” Reward: 80 embers.
9. Pell, harvestedRare >= 1, meaning any harvest of rank 2 or higher. “Something rarer.” Intro: “Wickpears are honest and dull. I need a Tideplum, a Cinderfig, or stranger. Grow one. Cut it.” Done: “There. The flesh holds light instead of merely reflecting it.” Reward: 1 Glassbloom seed, 40 embers.
10. Pell, discovered species >= 5. “Field notes.” Intro: “A codex with four entries is a pamphlet. Five species. Forage, buy, or brew. I only count what you have actually held.” Done: “I will steal three of these notes. You may keep the credit.” Reward: 1 shard, 60 embers.
11. Mara, sold >= 1600. “Open the night market.” Intro: “Pell sent you over smelling of solvent. Charming. I need proof the grove can feed a stall. Sixteen hundred embers, lifetime, from sales.” Done: “Fine. You can have a stall. Do not flood me with one fruit or I will price you into the dirt.” Reward: 120 embers, 1 shard.
12. Mara, surgeSold >= 1, meaning at least one sale happened during a surge. “Ride the surge.” Intro: “Every few minutes the cove overpays. A night surge. Sell while the banner is up. Not before. Not after.” Done: “You waited. Most growers panic-sell into a cold book. You might survive me.” Reward: 2 shards.
13. Mara, boughtRare >= 1. “What the cart hides.” Intro: “The rare cutting rotates. If you blink, it is gone. Buy a Glassbloom or a Nightcitrus before the slate changes, or spend a shard to pin it.” Done: “Bought, not borrowed. Vale has been asking for a grower who can finish a sentence.” Reward: 1 Nightcitrus seed, 80 embers.
14. Vale, deliver 3 Wickpears, any coat. Lights beacon 1. “East wick.” Intro: “Five beacons. They do not take coin. The east wick wants three Wickpears, any coat. Bring them from your stores.” Done: “The east wick took them. One light, thin as a thread.” Reward: 1 shard, 40 embers.
15. Vale, deliver 2 Mossbells that are coated. Lights beacon 2. “Moss gate.” Intro: “The moss gate will not take a plain bell. Two Mossbells wearing a coat from the still.” Done: “It drank the coat, not the fruit. Pell will be insufferable.” Reward: 1 shard, 50 embers.
16. Vale, deliver 2 Tideplums, any coat. Lights beacon 3. “Tide stair.” Intro: “The stair down to the water wants Tideplums. Two. Do not substitute a fig.” Done: “Cold light. The stair is safe to walk again.” Reward: 1 shard, 70 embers.
17. Vale, deliver 1 coated Glassbloom. Lights beacon 4. “Glass arch.” Intro: “The arch wants a Glassbloom that has been through the still. One is enough. It must be coated.” Done: “The arch answered. I have not heard that tone since the old steward.” Reward: 2 shards, 90 embers.
18. Vale, deliver 1 Prismheart. Lights beacon 5. “Heart of the cove.” Intro: “The last beacon will only take a Prismheart. Pell's recipe: a Glassbloom and a Nightcitrus, stabilized together. Then bring it here.” Done: “All five. The cove is lit. This tin is yours. The last Beaconfruit cutting I kept.” Reward: 2 shards, 1 Beaconfruit seed, 100 embers.
19. Vale, harvestedBeacon >= 1. “Plant the tin.” Intro: “Plant the cutting. Harvest it yourself. I want to see whether the grove still knows that fruit.” Done: “It knows. Bramblewick has a steward again. I will stop visiting. The lights will not.” Reward: 4 shards, 200 embers, title becomes “Beacon heir”.

Beaconfruit is planted like any other seed once the player holds that cutting. It is not sold in the shop.

## Data to save

Save a plain table per UserId: currencies, seeds, inventory, plots (species, mutation, stars, plantedAt using `workspace:GetServerTimeNow()`, grow duration), unlocked count, hire counts, upgrade tiers, quest index, beacon flags, discovered set, stats, title, contractMark. Do not save node cooldowns. On load, if a plantedAt is in the past by more than the grow time, the fruit is ripe and waiting. That is the offline catch-up. Cap displayed offline time at 8 hours in the welcome notice, but ripe plants can still be waiting.

Autosave every 60 seconds, on PlayerRemoving, and on BindToClose.

## Remotes

Folder `ReplicatedStorage.LuminaRemotes`:

- RemoteEvent State, server to client, HUD snapshot
- RemoteEvent Open, server to client, `{ mode = "shop" or "seeds", title, plot, options = { id, label, detail, enabled } }`
- RemoteEvent Action, client to server. Allowed actions only: `"seed"` with plot number and species id, `"buy"` with item id, `"turnin"`, `"sell"`, `"shop"`. Ignore anything else.

Rate-limit Action to about 8 per second per player.

## Client

A LocalScript cloned into PlayerScripts at join. It builds the HUD and the modal list. It never decides prices. Buttons fire Action. State updates the text. If a notice string changes, show the toast.

## Monetization, only after the loop works

Do not sell power that the story requires. Starshards can also be bought, but every shard item must stay earnable by playing.

Suggested gamepasses, convenience only:

- Grove lantern: a cosmetic light on your grove. No stats.
- Second page of billboard styles for ripe fruit. Cosmetic.
- Hasten booklet: grants the same 30 second skip the 2-shard item gives, once per server visit, or just sells a small shard pack. Do not make growth instant.
- Extra Kindlehand slot is not for sale. Four is the cap for everyone.

Developer products:

- A handful of starshards, priced so a dedicated player still earns them from 3-star forages and quests.
- No product that grants Beaconfruit, quest completion, or embers large enough to skip the cart fee.

Show a small Ledger board near the market with three lines of copy, not a store wall:

- Embers are always earned.
- Shards only skip time, pin the shop, or open one bed.
- The rare slate rotates so a scarce cutting feels urgent without blocking the story.

## Build order

Do these in order. Stop and let me play after each one.

1. One grove of 15 beds, fruit parts, click to plant the free Wickpears, click to harvest, leaderstats.
2. Sell-all at the market using the price formula, including heat and surge.
3. Shop list for seeds and the first Kindlehand. Kindlehands harvest on a timer.
4. Thicket forage with the weight table.
5. Quest board for the first four Wren quests, with the exact lines.
6. The rest of the quests, still, brew, beacons, and Beaconfruit.
7. DataStore.
8. Per-player grove cloning for multiplayer.
9. Cosmetic gamepasses only if the loop already feels good.

## Done when

- A new player can forage, plant, harvest, and sell without reading a wiki.
- The first four quests can be finished in one sitting.
- A second player in the same server gets their own grove and cannot steal the first player’s fruit.
- Stopping the playtest and joining again keeps ripe plants if API access is on.
- Nothing in the place is named after a mushroom.

Start with step 1 now. Create the grove in Workspace with parts, not with a written plan only.
