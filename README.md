# Custom Window

Custom Window is a simple package for developing desktop applications using Flutter. This package empowers you to create applications with a custom-designed window, giving your desktop app a unique and professional look. Whether you're building a productivity tool, a creative application, or any other desktop software, this package provides the foundation you need.

## Features

- **Customizable Window Scaffold**: Design your own window to match your application's branding or style.
- **Window Controls**: Window controls with callbacks for flexibility.
- **Modular Design**: Easy to edit and adapt to any case of use.

## Getting Started

Follow these steps to get started with the Custom Window Flutter Desktop Template:

1. **Add the repository to your `pubspec.yaml`**:

   ```yaml
   custom_window:
      git: 
         url: https://github.com/AxonDesigns/custom_window.git
   ```

2. **Install Dependencies**:

   ```bash
   flutter pub get
   ```

## Usage

### Initializing window

By following the next steps you will be able to setup a custom window.

1. Add the `CustomWindow` initialization as follows:
    ```dart
    void main() async {
      WidgetsFlutterBinding.ensureInitialized();

      await customWindow.initWindow(title: "window's title");

      runApp(const MainApp());
    }
    ```

2. Add the `WindowScaffold` to the widget tree as follows:

    ```dart
    @override
    Widget build(BuildContext context) {
      return MaterialApp(
        home: WindowScaffold(
          titleBarBuilder: (maximized, focused) => TitleBar(),
          bodyBuilder: (maximized, focused) => Center(child: Text("Hello World!")),
        ),
      );
    }
    ```
Note that the `WindowScaffold` has a builder in both title bar and body, making simple the custom implementation of both.

### Listening to window callbacks

This package provides a simple way to listen to changes in the window, can be implemented with the `WindowCallbackContainer` as follows:

  ```dart
  WindowCallbackContainer(
    onClose: () {},
    onMinimize: () {},
    onMaximize: () {},
    onUnMaximize: () {},
    onFocus: () {},
    onUnFocus: () {},
    onDocked: () {},
    onUnDocked: () {},
    onMove: () {},
    onMoved: () {},
    onResize: () {},
    onResized: () {},
    onRestore: () {},
    onEnterFullScreen: () {},
    onLeaveFullScreen: () {},
    onEvent: (eventName) {},
    child = YourWidget,
  );
  ```

## Contributing

Contributions are welcome! If you have ideas for improvements, new features, or bug fixes, please submit an issue or a pull request to the [custom_window repository](https://github.com/AxonDesigns/custom_window).

## License

This template is licensed under the [MIT License](LICENSE).

## Acknowledgments

This package was made in the pursuite of having a simple way to implement custom windows, with all the features possible.

---

Happy coding and building amazing desktop applications with Flutter and the Custom Window! If you have any questions or need assistance, feel free to reach out to us and any questions you may have.
