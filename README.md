# Jungle Reign 🌴

**Jungle Reign** is a high-speed 3D endless runner built in Godot 4. Set in a misty, unforgiving wilderness, players must sprint through ancient ruins, slide under deadly traps, and leap across massive drops in a constantly shifting procedural environment. 

When the ground completely gives out, players grab hold of an epic canyon zipline to glide over the abyss and seamlessly transition deeper into the jungle. With a permanent progression system and a built-in upgrade shop, every run pushes you further into the mist.

**Developed by:** Mohamad Aahil Farash (Aahil)  
**Initiative:** Indie Hack Srinagar  

---

## 🚀 Key Features

* **Procedural Track Generation:** Seamlessly stitches together varied track segments (`way_2` through `way_10`), automatically populating them with randomized obstacles, coins, and power-ups.
* **Cinematic Zipline Milestone:** A one-time, high-altitude transition event where the player snaps to a hanging animation and glides over a massive chasm to reach the next phase of the jungle.
* **Permanent Save System:** Built with a custom JSON `SaveManager` Singleton that banks collected coins and tracks your all-time highest distance locally on the hard drive.
* **Upgrade Shop:** Spend banked coins in the Main Menu to permanently level up power-up durations (Magnet, Shield, Speed Boost, and Coin Multiplier).
* **Atmospheric Environment:** Utilizes Godot's `WorldEnvironment` to create a dense, misty aesthetic with procedural sky materials and heavy depth fog inspired by classic runners.
* **Cinematic UI System:** A unified UI overlay featuring a Main Menu, Pause functionality, and a Game Over stat screen—all seamlessly transitioning over the active 3D world without requiring scene loads.

---

## 🎮 Controls

* **Switch Lanes:** `Left Arrow` / `A` & `Right Arrow` / `D`
* **Jump:** `Up Arrow` / `W` / `Space`
* **Slide:** `Down Arrow` / `S`
* **Pause / Unpause:** `Escape`

---

## 🛠️ Tech Stack & Assets

* **Engine:** Godot Engine 4.x
* **Language:** GDScript
* **3D Models:** Standard `.glb`/`.gltf` pipelines.
* **Animations:** Mixamo-rigged humanoid animations (Running, Jumping, Sliding, HangingIdle).

---

## 📂 Project Architecture

The game's logic is broken down into clean, independent managers:

### Core Managers
* **`TrackManager.gd`**: Handles the procedural spawning, positioning, and memory-safe despawning of track segments. 
* **`GameManager.gd`**: The brain of the active run. Manages game states (`MAIN_MENU`, `RUNNING`, `GAME_OVER`), live scoring, distance tracking, and run resets.
* **`SaveManager.gd`**: An Autoload/Singleton that reads and writes player progress, banked coins, and shop upgrade levels to a local `.json` file.
* **`UIManager.gd`**: Manages all canvas layers, cinematic menu transitions, button signals, and shop purchase math.

### Player & Entities
* **`PlayerController.gd`**: The character controller. Handles 3-lane horizontal snapping, gravity, jumping, sliding, and specialized states like `is_ziplining`.
* **Track Segments**: Modular `Node3D` scenes equipped with `ExitPoint` markers for perfect alignment, featuring their own internal logic for spawning coins and obstacles based on percentage chances.

---

## ⚙️ Installation & Setup for Developers

1. Clone or download this repository to your local machine.
2. Open **Godot Engine** (v4.x).
3. Click **Import** and navigate to the `project.godot` file in the repository folder.
4. Ensure `SaveManager.gd` is set up as an Autoload in **Project > Project Settings > Globals**.
5. Open `Game.tscn` as the main scene and hit **Play (F5)** to start running!
