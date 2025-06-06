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
cd AllTune
flutter pub get
flutter run