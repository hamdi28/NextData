# Flutter Project with Native Android Code

This project includes native Android code and requires additional setup steps to work correctly.

## Prerequisites

Before you begin, ensure you have the following installed:

- [Flutter SDK](https://flutter.dev/docs/get-started/install) (latest stable version)
- [Android Studio](https://developer.android.com/studio) with:
    - Android SDK
    - Android NDK (if required)
    - Android Emulator or a physical device for testing
- [Java Development Kit (JDK)](https://www.oracle.com/java/technologies/javase-jdk11-downloads.html) (JDK 11 or higher)

## Getting Started

Follow these steps to set up and run the project:

### 1. Clone the Repository

Clone this repository to your local machine using the following command:

```bash
git clone https://github.com/hamdi28/NextData
cd your-repository
```
### 2. Install Flutter Dependencies

Navigate to the root of the Flutter project and install the required dependencies:

```bash
`flutter pub get
```

### 3. Open the Android Project in Android Studio

Since this project contains native Android code, you need to open the Android module separately:

1.  **Open Android Studio.**
2.  **Click on `Open an Existing Project`.**
3.  **Navigate to the `android` directory inside your Flutter project and select it.**
4.  **Once the project is opened, Android Studio may prompt you to upgrade the Gradle plugin or dependencies; proceed with these updates if necessary.**

### 4. Sync Project with Gradle Files

After opening the Android project in Android Studio:

1.  Click on `File` -> `Sync Project with Gradle Files`.
2.  Wait for the Gradle sync to complete. Ensure there are no errors.

### 5. Run the Project

Once the Gradle sync is complete, you can run the project either from Android Studio or from the command line:

#### From Android Studio:

1.  Select a target device (emulator or connected physical device).
2.  Click on the `Run` button (green play icon) to build and run the project.

#### From the Command Line:

```bash
`flutter run`
``` 

This command will run the project on your connected device or emulator.

### 6. Troubleshooting

If you encounter issues during the setup, consider the following:

-   Ensure that your Android SDK and JDK are correctly installed and configured.
-   Make sure to update your Android Studio to the latest version.
-   If Gradle sync fails, check the `build.gradle` files for any version conflicts or errors.

### 7. Additional Notes

-   This project may include platform-specific code (Kotlin, Java) in the `android` directory. Make sure to review and modify this code as needed for your project.
-   If you need to perform any custom build steps (e.g., integrating with third-party libraries or modifying native code), refer to the documentation provided in the `android` folder.