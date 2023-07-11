# QCarder App

# Setup
## Prerequisites

Before starting to develop the application, ensure that the following are installed on your machine:

- Flutter: Installation guide [Install](https://docs.flutter.dev/get-started/install).
- IDE for Flutter development: We recommend using [Visual Studio Code](https://code.visualstudio.com/)
  with the Flutter and Dart extensions.
- Git: Download Installer from [Git](https://git-scm.com/download/win).
- Run the command `flutter doctor` in your project's terminal and ensure that all the necessary
  tools and requirements are installed.

## Getting Started

- Clone this repository to your local machine using the command: git clone <repository-url>.
- Open the project in your IDE.
- Run `flutter pub get` to install the required packages.

## Running Locally

- To run the application on a device or emulator, you can use the command "flutter run".
- Alternatively, you can choose the options "start with debugging" or "start without debugging" from the IDE top bar.
- Make sure your device or emulator is selected before running the application.

## Environment Variables

To run this app, you'll need to set up two environment variables for now. These includes ENV variable which
specifies the app's running environment such as development, or production,
DEV_BASE_URL or PRODUCTION_BASE_URL which is the base URL for your dev/prod API.

Include the following two environment files, along with their variables, in the root directory of the project (QCarder/).
  ### .env.development
    ENV='development'
    DEV_BASE_URL='https://api.qcarder.com'

  ### .env.production
    ENV='production'
    DEV_BASE_URL='https://*******.com'

Unless you select another option, the app will run on the development environment as its default setting.

## Generating Services and Models from OpenAPI in Flutter

In our project, we have implemented OpenAPI to streamline the process of generating services and models based on the APIs we utilize. By using the following command, we can easily generate these files:

```
dart run build_runner clean
dart run build_runner build --delete-conflicting-outputs
```

Upon execution, the generated files will be conveniently located in the directory path `QCarder/apis`. It is important to note that running this command will overwrite any existing files in that location.

This approach enables us to seamlessly synchronize our application with any changes or updates made to the APIs. By automatically generating the necessary services and models, we can ensure that our project remains up-to-date and aligned with the latest API specifications. This not only saves time but also promotes maintainability and consistency in our codebase.
## Useful Commands

Here is a list of useful commands for this project:

- Running the Application
  - `flutter run` - Runs the application on a connected device or emulator.
- Installing Packages
  - `flutter packages get` - Installs the required packages for the project.
- Cleaning the Project
  - `flutter clean` - Cleans the project by deleting the build directory.
- Building for the Web
  - CanvasKit
    - `flutter build web --web-renderer canvaskit --dart-define=ENV=development` - build for DEVELOPMENT.
    - `flutter build web --web-renderer canvaskit --dart-define=ENV=production` - build for PRODUCTION.
  - HTML
    - `flutter build web --web-renderer html --dart-define=ENV=development` - build for DEVELOPMENT.
    - `flutter build web --web-renderer html --dart-define=ENV=production` - build for PRODUCTION.
- Building for the Mobile
  - IOS
    - `flutter build ios --dart-define=ENV=development` - build for DEVELOPMENT.
    - `flutter build ios --dart-define=ENV=production` - build for PRODUCTION.
  - Android
    - `flutter build apk --dart-define=ENV=development` - build for DEVELOPMENT.
    - `flutter build apk --dart-define=ENV=production` - build for PRODUCTION.
- Update version
  `new_version="1.0.0+1"` - Set the new version number as a variable.
  `sed -i "s/version: .*/version: $new_version/" pubspec.yaml` - Update the pubspec.yaml file with the new version number.

## Versioning

The version number is in the format major.minor.patch+build (breaking.feature.fix+build). It consists of the following components:

- breaking: Changes that can cause existing code to fail or behave differently.
- feature: New functionality added to the software.
- fix: Changes that correct a bug or issue.
- build: The build number, which is incremented each time a new build is generated.

When making changes to the project, make sure to update the version number accordingly using the above commands.
This will help to keep track of changes and ensure that the correct version of the software is being used.

## Architecture

TODO:

## Development Process
TODO:

## Deployment
TODO:
