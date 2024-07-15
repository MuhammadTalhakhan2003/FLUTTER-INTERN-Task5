### README

# SharedPreferences Example

This is a Flutter application that demonstrates how to use the `shared_preferences` package to implement local storage. The app allows users to add and remove items from a list, with the list being persisted across app restarts using SharedPreferences.

## Features

- Add items to a list.
- Remove items from the list.
- Persist the list locally using SharedPreferences.
- Load the saved list when the app starts.

## Getting Started

### Prerequisites

- Flutter SDK
- Dart

### Installation

1. Clone this repository:

   ```bash
   git clone https://github.com/MuhammadTalhakhan2003/FLUTTER-INTERN-Task5
   ```

2. Navigate to the project directory:

   ```bash
   cd shared_preferences_example
   ```

3. Install dependencies:

   ```bash
   flutter pub get
   ```

### Running the App

To run the app, use the following command:

```bash
flutter run
```

## Code Explanation

### `main.dart`

- **`MyApp`**: The root widget of the application. It uses `MaterialApp` to set up the app's theme and home screen.
- **`ItemProvider`**: A `ChangeNotifier` that handles the logic for loading, adding, removing, and saving items using SharedPreferences.
- **`ItemListScreen`**: The main screen that displays the list of items and provides a way to add and remove items.

### SharedPreferences Integration

- **`_loadItems`**: Loads the list of items from SharedPreferences when the provider is initialized.
- **`_saveItems`**: Saves the current list of items to SharedPreferences whenever items are added or removed.
- **`addItem` and `removeItem`**: Methods to modify the list and update the UI accordingly.

### UI Components

- **`ItemListScreen`**: Uses a `ListView.builder` to display the list of items and a `FloatingActionButton` to open a dialog for adding new items.
- **`_showAddDialog`**: A method that displays a dialog to enter a new item. The item is added to the list when confirmed.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments

- Flutter and Dart for the framework and language.
- The `shared_preferences` package for local storage capabilities.

