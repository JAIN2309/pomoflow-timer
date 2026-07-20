# PomoFlow — Pomodoro Focus Timer

PomoFlow is a premium, highly polished, and responsive Pomodoro Focus Timer built using Flutter. The application adopts a clean corporate **MVVM (Model-View-ViewModel)** architectural pattern to deliver a robust, maintainable, and structured codebase with zero external state-management dependencies.

---

## 🌟 Key Features

- **Responsive Design**: Auto-scales and centers beautifully across web, tablet, desktop, and mobile form factors using responsive layout constraints (constrained to a maximum width of `600px`).
- **Modern Dark Theme**: Immerse users in a sleek dark ambient background (`#1E1E2C`) featuring dynamic radial gradients that smoothly transition color states.
- **Three Operation Modes**:
  - **Focus Mode** (25 minutes, Red accent `#FF5252`): Dedicated session for pure focus.
  - **Short Break** (5 minutes, Green accent `#4CAF50`): Rapid rejuvenation pause.
  - **Long Break** (15 minutes, Blue accent `#2196F3`): Deep rest between focus blocks.
- **Sleek Progress Animation**: A massive digital timer displaying time with tabular characters to prevent layout jitter, wrapped in a smooth `TweenAnimationBuilder` progress indicator.
- **Glassmorphic Completer**: Celebrates completed sessions with blurred glassmorphic modals that suggest logical mode progressions.
- **Micro-Interactions**: Floating action buttons rotate and switch states dynamically; secondary buttons support hover feedback, desktop tooltips, and ripple highlights.

---

## 🏗️ Architecture Design (MVVM)

The project decomposes UI components, styling definitions, and business logic into separated, single-responsibility layers:

```
lib/
├── main.dart                      # Application initialization & configuration
├── theme/
│   └── app_theme.dart             # Dark theme design system values
├── models/
│   └── pomodoro_mode.dart         # Data model mapping colors & durations per mode
├── viewmodels/
│   └── pomodoro_viewmodel.dart    # Logic: ticks timers, changes states, notifies listeners
└── views/
    ├── pomodoro_screen.dart       # Master template using ListenableBuilder
    └── widgets/
        ├── completion_dialog.dart # Session end glassmorphic modal
        ├── control_buttons.dart   # Start, pause, reset, skip controls
        ├── mode_selector.dart     # Navigation capsule selector chips
        └── timer_ring.dart        # Timer digits and circular track indicator
```

### Decoupling Flow:
1. **Model** holds raw static configuration rules (timing durations and color codes).
2. **ViewModel** acts as the engine, maintaining values like `secondsRemaining` and `isRunning`, ticking the periodic asynchronous loop, and broadcasting changes via `notifyListeners()`.
3. **Views & Widgets** receive updates reactively via Flutter's built-in `ListenableBuilder` and dispatch gestures back to the ViewModel methods.

---

## 🚀 Getting Started

### Prerequisites
Ensure you have the Flutter SDK installed on your system:
```bash
flutter --version
```

### Installation
Clone the repository, navigate to the project directory, and pull Dart packages:
```bash
cd pomodoro_focus_flutter_app
flutter pub get
```

### Running Static Analysis
Enforce code quality rules and check for any compilation or lint errors:
```bash
flutter analyze
```

### Executing Tests
Run the widget verification suite:
```bash
flutter test
```

### Launching the App
Run PomoFlow on your preferred connected simulator, browser, or desktop device:
```bash
flutter run
```
