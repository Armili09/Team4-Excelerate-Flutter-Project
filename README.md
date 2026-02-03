# Team4-Excelerate-Flutter-Project

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

## 🚀 Setup Instructions

### Prerequisites

- Flutter SDK (version 3.0 or higher)
- Dart SDK (version 2.17 or higher)
- Android Studio / VS Code with Flutter extensions
- Git

### Installation Steps

1. **Clone the repository**

   ```bash
   git clone https://github.com/your-username/Team4-Excelerate-Flutter-Project.git
   cd Team4-Excelerate-Flutter-Project
   ```

2. **Install dependencies**

   ```bash
   flutter pub get
   ```

3. **Check Flutter environment**

   ```bash
   flutter doctor
   ```

   Ensure all required components are installed and configured.

4. **Run the app**

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
   flutter run -d web
   ```

5. **Build for production**

   **Android APK:**

   ```bash
   flutter build apk --release
   ```

   **Android App Bundle:**

   ```bash
   flutter build appbundle --release
   ```

   **iOS:**

   ```bash
   flutter build ios --release
   ```

### Project Structure

```
lib/
├── main.dart                 # App entry point
├── models/                   # Data models
├── providers/               # State management (Provider pattern)
├── screens/                 # UI screens
│   ├── dashboard/           # Dashboard screens
│   ├── features/           # Feature-specific screens
│   ├── profile/            # Profile-related screens
│   └── ...
├── services/               # API and data services
├── utils/                  # Utility functions and helpers
└── widgets/                # Reusable UI components
```

### Key Dependencies

- `provider` - State management
- `shared_preferences` - Local storage
- `intl` - Internationalization
- `flutter_svg` - SVG support
- `cached_network_image` - Image caching
- `shimmer` - Loading animations
- `share_plus` - Social sharing
- `url_launcher` - URL handling
- `image_picker` - Image selection
- `fl_chart` - Charts and graphs
- `badges` - Badge widgets

## 🤝 Contributing Guidelines

### How to Contribute

1. **Fork the repository**
   - Click the "Fork" button on the GitHub repository page

2. **Create a feature branch**

   ```bash
   git checkout -b feature/your-feature-name
   ```

3. **Make your changes**
   - Follow the existing code style and conventions
   - Add comments for complex logic
   - Ensure your code follows Flutter best practices

4. **Test your changes**

   ```bash
   flutter test
   flutter analyze
   ```

5. **Commit your changes**

   ```bash
   git commit -m "feat: add your feature description"
   ```

6. **Push to your fork**

   ```bash
   git push origin feature/your-feature-name
   ```

7. **Create a Pull Request**
   - Provide a clear description of your changes
   - Include screenshots if applicable
   - Reference any related issues

### Code Style Guidelines

- **Dart Style**: Follow the official [Dart Style Guide](https://dart.dev/guides/language/effective-dart/style)
- **Flutter Widgets**: Use descriptive widget names and proper widget composition
- **File Organization**: Group related files together and follow the established folder structure
- **Comments**: Add meaningful comments for complex business logic
- **Variable Naming**: Use descriptive variable names in camelCase

### Commit Message Convention

We follow the [Conventional Commits](https://www.conventionalcommits.org/) specification:

```
<type>[optional scope]: <description>

[optional body]

[optional footer(s)]
```

**Types:**

- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation changes
- `style`: Code style changes (formatting, etc.)
- `refactor`: Code refactoring
- `test`: Adding or updating tests
- `chore`: Maintenance tasks

**Examples:**

```
feat(auth): add user registration functionality
fix(profile): resolve profile image loading issue
docs(readme): update setup instructions
```

### Testing Guidelines

- **Unit Tests**: Write unit tests for business logic and utility functions
- **Widget Tests**: Test individual widgets and their behavior
- **Integration Tests**: Test complete user flows
- **Test Coverage**: Aim for at least 80% test coverage

### Pull Request Process

1. **Ensure your branch is up to date**

   ```bash
   git checkout main
   git pull upstream main
   git checkout your-feature-branch
   git rebase main
   ```

2. **Run all tests**

   ```bash
   flutter test
   flutter analyze
   ```

3. **Update documentation** if needed

4. **Submit a Pull Request** with:
   - Clear title and description
   - Screenshots for UI changes
   - Testing instructions
   - Related issue numbers

### Code Review Process

- All pull requests require at least one approval
- Reviewers will check for:
  - Code quality and style
  - Test coverage
  - Performance implications
  - Security considerations
  - Documentation completeness

## 📱 App Navigation Flow

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

## 🐛 Troubleshooting

### Common Issues

1. **Flutter Doctor Issues**
   - Ensure all dependencies are properly installed
   - Check Android/Xcode setup for mobile development

2. **Build Errors**
   - Run `flutter clean` and then `flutter pub get`
   - Check for conflicting dependency versions

3. **Emulator Issues**
   - Ensure proper Android emulator setup
   - Check system requirements for iOS simulator

### Getting Help

- **GitHub Issues**: Report bugs or request features
- **Discussions**: Ask questions and share ideas
- **Documentation**: Check existing documentation first

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 👥 Team

- **Team 4** - Mobile Learning App Development Team

---

**Happy Learning! 🎓**
