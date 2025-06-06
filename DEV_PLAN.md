Added initial development roadmap
✅ Instructions for You
	•	Paste this into a new file named DEV_PLAN.md in your GitHub repo (via app or website).
	•	You can use this to guide GitHub Copilot prompts, ChatGPT follow-ups, or even turn into Issues or Project Boards later.

⸻

🎵 AllTune Development Plan

A universal offline musical instrument tuner app built in Flutter, supporting 12+ instruments, swipeable tuning views, and real-time pitch detection — with no AI or cloud.

# 🎵 AllTune Development Plan

> A universal offline musical instrument tuner app built in Flutter, supporting 12+ instruments, swipeable tuning views, and real-time pitch detection — with no AI or cloud.

---

## 🧱 PHASE 1: Project Setup

| Task | Status | Prompt |
|------|--------|--------|
| Scaffold Flutter project | ⬜ | `Create a Flutter project named AllTune with lib/, assets/, and pubspec.yaml ready for a tuner app.` |
| Set up folder structure | ✅ | `Structure the app into: lib/screens, lib/widgets, lib/models, lib/utils, assets/images, and assets/audio.` |
| Add Flutter + Dart plugins | ✅ | Use Android Studio: Preferences > Plugins |
| Initial README.md | ✅ | `Write a README for a Flutter app called AllTune, a universal music tuner with offline pitch detection and multiple tunings.` |
| pubspec.yaml dependencies | ✅ | `Add dependencies for: mic input (flutter_audio_capture or flutter_fft), animations, shared_preferences, ad support.` |

---

## 🎸 PHASE 2: Core Tuner Engine

| Task | Status | Prompt |
|------|--------|--------|
| Microphone access | ⬜ | `Request and handle mic permission for Flutter on Android and iOS.` |
| Pitch detection logic | ⬜ | `Implement pitch detection using flutter_fft or a native plugin. Output frequency and closest musical note.` |
| Tuning dial widget | ⬜ | `Create a Flutter widget for an analog-style tuning dial that displays pitch deviation from target.` |
| Note matching algorithm | ⬜ | `Write a Dart function that matches detected frequency to the closest note from a tuning preset.` |

---

## 🎼 PHASE 3: Instrument & Tuning Presets

| Task | Status | Prompt |
|------|--------|--------|
| Define instrument model | ⬜ | `Create a Dart model for instruments, tunings, and alternate tuning presets (e.g., standard, drop D, open G).` |
| Swipeable instrument UI | ⬜ | `Build a swipeable PageView in Flutter to switch between instruments with tuning data displayed.` |
| Tuning selection dropdown | ⬜ | `Add a dropdown or toggle button to select alternate tunings per instrument.` |

---

## 🎨 PHASE 4: UI & Experience

| Task | Status | Prompt |
|------|--------|--------|
| Light/dark theme support | ⬜ | `Create light and dark themes for a Flutter app with modern, musical styling.` |
| Large icons & fonts | ⬜ | `Ensure UI uses high-contrast fonts and large icons for accessibility while staying visually sleek.` |
| Animated tuning feedback | ⬜ | `Animate the tuning dial to glow or pulse when the pitch is in tune.` |
| Portrait & landscape layout | ⬜ | `Make the UI responsive and functional in both portrait and landscape modes on phones/tablets.` |

---

## ⚙️ PHASE 5: Settings & Local Storage

| Task | Status | Prompt |
|------|--------|--------|
| Save selected instrument | ⬜ | `Use shared_preferences to store last-used instrument and tuning on the device.` |
| Basic settings screen | ⬜ | `Build a settings screen to toggle display options (e.g. frequency, note name, theme).` |

---

## 💰 PHASE 6: Monetization

| Task | Status | Prompt |
|------|--------|--------|
| Ad integration | ⬜ | `Add banner or interstitial ads using Google Mobile Ads SDK in Flutter.` |
| Remove-ads toggle | ⬜ | `Add a one-time in-app purchase option to remove ads using in_app_purchase package.` |
| Display ad-free status | ⬜ | `Show a persistent "Ad-Free" badge or hide ads after purchase.` |

---

## 🧪 PHASE 7: Testing & Optimization

| Task | Status | Prompt |
|------|--------|--------|
| Unit tests for pitch detection | ⬜ | `Write unit tests to confirm correct note matching for given frequencies.` |
| Device compatibility test | ⬜ | `Test mic access, pitch detection, and UI scaling across Android and iOS devices.` |
| Performance tuning | ⬜ | `Profile pitch detection and UI rendering. Optimize for low-latency tuning updates.` |

---

## 🚀 PHASE 8: Build & Publish

| Task | Status | Prompt |
|------|--------|--------|
| App icon & splash screen | ⬜ | `Use flutter_launcher_icons and flutter_native_splash to create branding.` |
| Privacy policy file | ⬜ | `Write a privacy policy for an offline app that uses mic input but collects no personal data.` |
| Build for iOS/Android | ⬜ | `Prepare Android and iOS builds using Flutter build tools and update manifests for mic permissions.` |
| Submit to stores | ⬜ | `Guide me through Play Store and App Store submission for a Flutter app.` |

---

## 🎯 Final Touches

- ✅ No cloud sync or AI integration
- ✅ Offline-only: fast, safe, lightweight
- ✅ Large icon/high-contrast accessibility (without clutter)
- ✅ Monetization = Ad-free version only

---

## ✨ Dev Tips

- Use these prompts directly in **ChatGPT** or **GitHub Copilot** comment blocks
- Convert each task to a GitHub Issue or Card if needed
- Update the checklist as you go!

