# Libroo 📚

A modern and elegant Flutter-based mobile application for book lovers, designed to provide an intuitive reading experience with personalized book recommendations and seamless navigation.

## 🌟 Features

### Core Functionality
- **Book Discovery**: Browse through curated book collections with beautiful visual layouts
- **Personalized Recommendations**: Get book suggestions tailored to your reading preferences
- **Bookmark System**: Save your favorite books for later reading
- **Event Integration**: Stay updated with reading competitions and literary events
- **User Profiles**: Manage your reading journey and preferences

### User Experience
- **Modern Dark Theme**: Sleek dark interface with purple accent colors (#6E40F3)
- **Responsive Design**: Optimized for various screen sizes
- **Smooth Navigation**: Intuitive bottom navigation with GetX routing
- **Interactive Elements**: Engaging animations and visual feedback
- **Indonesian Language Support**: Localized content for Indonesian readers

<<<<<<< HEAD
## 🏗️ Architecture
=======
## **Installation & Setup**
```bash
# Clone the repository
git clone https://github.com/darwyshev/libroo.git
cd libroo
>>>>>>> 4f090003f7edbb24fcaeb10099f222a85276a93a

This project follows the **GetX Pattern** architecture with a clean separation of concerns:

```
lib/
├── app/
│   └── modules/
│       └── home/
│           ├── bindings/
│           │   └── home_binding.dart
│           ├── controllers/
│           │   └── home_controller.dart
│           └── views/
│               └── home_view.dart
```

### Key Components

- **Bindings**: Dependency injection management using GetX
- **Controllers**: Business logic and state management
- **Views**: UI components and layouts

## 🎨 Design System

### Color Palette
- **Primary**: `#6E40F3` (Purple)
- **Secondary**: `#8A62FF` (Light Purple)
- **Background**: `#1F2334` (Dark Blue)
- **Surface**: `#2A2E43` (Dark Gray)
- **Text**: `#F7F7F7` (Light Gray)

### Typography
- **App Title**: 28px, Bold
- **Section Headers**: 20px, Bold
- **Book Titles**: 16-24px, Bold
- **Body Text**: 14-16px, Regular

## 📱 Screens & Navigation

### Home Screen
- **Top Bar**: App branding and notification access
- **Event Banner**: Featured reading competitions and events
- **Book Recommendations**: Horizontal scrolling book carousel
- **Best Choices**: Grid layout of top-rated books

### Navigation Structure
```
/home (Default)
├── /notification
├── /event
├── /book-detail
├── /bookmark
├── /explore
└── /profile
```

## 🛠️ Technologies Used

- **Flutter**: Cross-platform mobile development framework
- **GetX**: State management, dependency injection, and routing
- **Dart**: Programming language
- **Material Design**: UI components and design principles

## 📦 Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  get: ^4.6.5
  # Add other dependencies as needed
```

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (>=3.0.0)
- Dart SDK (>=2.17.0)
- Android Studio / VS Code
- Android/iOS device or emulator

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/libroo.git
   cd libroo
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Prepare assets**
   ```bash
   # Ensure all book cover images are placed in:
   # assets/book/
   ```

4. **Run the application**
   ```bash
   flutter run
   ```

## 📁 Project Structure

```
libroo/
├── android/              # Android-specific files
├── ios/                  # iOS-specific files
├── lib/
│   ├── app/
│   │   ├── modules/
│   │   │   └── home/     # Home module
│   │   ├── routes/       # Application routes
│   │   └── data/         # Data models and services
│   └── main.dart         # Application entry point
├── assets/
│   └── book/             # Book cover images
├── test/                 # Unit and widget tests
└── pubspec.yaml          # Project configuration
```

## 🎯 Key Features Implementation

### Book Recommendation System
```dart
// Horizontal scrolling carousel with book details
Widget _buildRecommendedBooks() {
  // Implementation includes:
  // - Dynamic book data
  // - Navigation to book details
  // - Bookmark functionality
  // - Visual feedback
}
```

### Responsive Design
- Adaptive layouts for different screen sizes
- Optimized image loading and caching
- Smooth scrolling performance

### State Management
- GetX controller for reactive state updates
- Dependency injection for clean architecture
- Route management with named routes

## 🔧 Configuration

### Theme Configuration
The app uses a custom dark theme with consistent color schemes throughout all components.

### Asset Management
Book covers and other assets are managed through the `pubspec.yaml` file:
```yaml
flutter:
  assets:
    - assets/book/
```

## 🧪 Testing

```bash
# Run unit tests
flutter test

# Run integration tests
flutter test integration_test/

# Generate code coverage
flutter test --coverage
```

## 🚀 Deployment

### Android
```bash
flutter build apk --release
```

### iOS
```bash
flutter build ios --release
```

## 🤝 Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 👥 Authors

- **Your Name** - *Initial work* - [YourGitHub](https://github.com/darwyshev)

## 🙏 Acknowledgments

- Indonesian book publishers for content inspiration
- Flutter community for excellent packages
- GetX team for the powerful state management solution
- Material Design team for design guidelines

## 📞 Support

If you have any questions or need support, please reach out:

- Email: your.email@example.com
- GitHub Issues: [Create an issue](https://github.com/darwyshev/libroo/issues)

---

**Libroo** - Making reading accessible and enjoyable for everyone 📖✨