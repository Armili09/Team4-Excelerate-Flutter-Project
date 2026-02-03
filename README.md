# Team4-Excelerate-Flutter-Project

**Technologies Used:**

- Flutter
- Dart
- Python

## Setup Instructions

### Prerequisites

Before running the app, ensure you have the following installed:

- **Flutter SDK** (version 3.35.0 or higher)
- **Dart SDK** (version 3.10.7 or higher)
- **Android Studio** or **VS Code** with Flutter extensions
- **Git** for version control

### Installation Steps

1. **Clone the repository:**

   ```bash
   git clone https://github.com/Armili09/Team4-Excelerate-Flutter-Project.git
   cd Team4-Excelerate-Flutter-Project
   ```

2. **Install Flutter dependencies:**

   ```bash
   flutter pub get
   ```

3. **Check Flutter setup:**

   ```bash
   flutter doctor
   ```

   Ensure all required components are installed and configured.

4. **Run the app:**

   **For Android:**

   ```bash
   flutter run
   ```

   **For iOS:**

   ```bash
   flutter run -d ios
   ```

   **For Web:**

   ```bash
   flutter run -d web-server --web-port=8080
   ```

   **For Desktop (Windows/macOS/Linux):**

   ```bash
   flutter run -d windows
   # or
   flutter run -d macos
   # or
   flutter run -d linux
   ```

### Development Setup

For development with hot reload:

```bash
flutter run --hot
```

### Building the App

**Release APK for Android:**

```bash
flutter build apk --release
```

**Release iOS Build:**

```bash
flutter build ios --release
```

**Web Build:**

```bash
flutter build web
```

### Troubleshooting

- **If you encounter dependency issues:** Run `flutter clean` then `flutter pub get`
- **For Android setup issues:** Ensure Android SDK and emulator are properly configured
- **For iOS setup issues:** Ensure Xcode and iOS simulator are installed
- **For web/desktop issues:** Additional platform-specific setup may be required

---

## Project Vision

The Mobile Learning App is designed to provide a modern, mobile-first learning experience that is intuitive, engaging, and goal-driven. The vision is to create a single platform where learners can discover programs, enroll in courses, track their progress, and earn meaningful achievements—all with minimal friction and maximum clarity.

## Project Objectives

The key objectives of this project are to:

- Deliver a clean, user-friendly mobile learning experience
- Simplify course discovery, enrollment, and application workflows
- Enable learners to easily resume learning and track progress over time
- Increase engagement through visual progress indicators, streaks, and achievements
- Support certifications and skill validation through digital credentials
- Provide a scalable foundation for future enhancements such as analytics and personalization

## App Navigation Flow

The application uses a tab-based navigation structure optimized for mobile usability. Each tab has a clearly defined purpose within the learning journey.

### Onboarding and Spash Screen:

<p align="center">
  <img width="200" alt="splash-screen" src="https://github.com/user-attachments/assets/4c60b8e4-c295-4ba1-8007-f6ff8a24ac02" />
  <img alt="splash-screen" src="https://github.com/user-attachments/assets/bc29f2d0-62bd-40dc-8a49-9256c1a2dee2" width="200" />
  <img src="https://github.com/user-attachments/assets/85802704-158e-4f53-9d4c-0529ae4b4c38" width="200" />
  <img src="https://github.com/user-attachments/assets/aba49112-baf4-4ea6-8d85-3a416c0e7d41" width="200" />
</p>

### Login Page

Login screen as the primary entry point for users, ensuring it includes form inputs for authentication and basic validation to simulate a secure login process, with navigation to the Dashboard upon successful mock login.
UI layout with email and password fields, including a 'Remember Me' checkbox and 'Forgot Password' link.
Form validation to check for empty fields or invalid formats,

<p align="center">
  <img src="https://github.com/user-attachments/assets/cb4752ba-626a-4119-9d2d-139ee2937442" alt="Login 1" width="200" />
  <img src="https://github.com/user-attachments/assets/c5878c99-92e6-4ae4-a681-a57a511301f6" alt="Login 2" width="200" />
  <img src="https://github.com/user-attachments/assets/a937cca2-2e28-437f-ac69-4923a4b5c1d7" alt="Login 3" width="200" />
  <img src="https://github.com/user-attachments/assets/32e83cd2-b245-42b4-8550-3a75a51de067" alt="Login 4" width="200" />
</p>

### My Courses Page

My Courses screen to list enrolled courses with progress indicators, allowing users to track their learning journey and resume from details. Sections for in-progress, saved and completed courses have also been added.

 <p align="center"> 
  <img alt="MC" src="https://github.com/user-attachments/assets/7f6a118f-a262-4847-be09-33c277e8b7c5" width="250" />
 </p>

### Profile Page

Profile screen as a user overview, showing personal info, stats, and links to related features like editing or achievements and also settings.

<p align="center">
  <img alt="P1" src="https://github.com/user-attachments/assets/281018f8-c0cf-4b80-a588-f6b0a9552c83" width="250" />
</p>

### Profile Page Functionalities:

Edit Profile Button Functionality
Logout button with confirmation dialog

<p align="center">
  <img alt="P4" src="https://github.com/user-attachments/assets/59560c5c-6a2d-41f0-a4a3-97b939bdb19f" WIDTH="250" />
  <img alt="P2" src="https://github.com/user-attachments/assets/b8a4a026-1ae6-4908-92a0-5e76358e2cb6" width="250" />
  <img alt="P3" src="https://github.com/user-attachments/assets/5f8e301e-f744-4862-b6ba-eb9d5e099aa3" width="250" />
</p>
