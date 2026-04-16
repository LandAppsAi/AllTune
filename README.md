# AllTune
# 🎵 AllTune

**AllTune** is a universal musical instrument tuning app built with **Flutter**. It supports tuning for 12+ instruments with multiple tuning presets, a beautiful analog-style dial, and real-time pitch detection. Whether you're tuning a guitar, violin, or trumpet, AllTune brings precision and simplicity to your fingertips.

---

## 🚀 Features

- 🎸 Supports 12+ instruments
- 🎯 Precision tuning dial with visual feedback
- 🎧 Real-time pitch detection via mic input
- 🔁 Swipe between instrument presets
- 🎼 Alternate tunings (Drop D, DADGAD, Open G, etc.)
- 🌙 Light & dark mode
- 🔆 High-contrast fonts and large icons
- ✨ Animated tuning feedback when in tune
- 🧠 Designed for beginners and pros alike

---

## 🛠 Tech Stack

- **Framework**: Flutter
- **Audio**: Mic input + pitch detection via [flutter_audio_capture] or native integration
- **State Management**: `setState()` for MVP; expandable to Riverpod/Bloc later
- **Platform**: iOS + Android

---

## 📦 Installation (Coming Soon)

```bash
git clone https://github.com/LandAppsAi/AllTune.git

Tunings Included
Instrument
Tunings
Guitar
Standard, Drop D, DADGAD, Open G
Bass
Standard (4/5 string), Drop D
Violin
G-D-A-E
Viola
C-G-D-A
Cello
C-G-D-A
Ukulele
G-C-E-A, A-D-F#-B
Banjo
Open G, Double C
Mandolin
G-D-A-E
Trumpet
Bb Standard
Trombone
C/Bb tuning
Flute
C tuning
Clarinet
Bb tuning


⸻

🔮 Roadmap
	•	Pitch detection engine
	•	Animated needle tuner UI
	•	Instrument/tuning selector
	•	Save favorite tunings
	•	AI-assisted tuning accuracy coach (stretch)

⸻

🤝 Contributing

Contributions are welcome! Please open an issue to discuss before submitting a PR.

⸻

📄 License

This project is licensed under the MIT License. See LICENSE for details.

⸻

🎨 Credits

Built with ❤️ by LandAppsAi

Icons from Feather Icons and FontAwesome

⸻

📱 Screenshots (coming soon)


---

## 🧩 C# Roguelike Dungeon Crawler

This repository now also includes a small playable terminal roguelike prototype in C#.

Location: `csharp-roguelike/src`

### Run

```bash
cd csharp-roguelike/src
dotnet run
```

### Controls

- Move: `WASD` or arrow keys
- Quit: `Q`

### Gameplay

- Explore procedurally generated dungeon floors (`#` walls, `.` floor)
- Fight goblins (`g`) by moving into them
- Reach stairs (`>`) to descend and advance floors
- Survive as long as possible
