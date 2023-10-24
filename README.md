# Custom Window Flutter Desktop Template

The Custom Window Flutter Desktop Template is a versatile starting point for developing desktop applications using Flutter. This template empowers you to create applications with a custom-designed title bar, giving your desktop app a unique and professional look. Whether you're building a productivity tool, a creative application, or any other desktop software, this template provides the foundation you need.

## Features

- **Custom Title Bar**: Design your own title bar to match your application's branding or style.
- **Resizable Window**: Users can resize the application window as needed.
- **Maximize and Minimize**: Implement maximize and minimize window functions.
- **Draggable Window**: Drag the application window to any location on the desktop.
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

## Customizing the Title Bar

The key feature of this template is the customizable title bar. To modify the title bar design, follow these steps:

1. Add the `TitleBar` to the `WindowScaffold` as follows:

   ```dart
   WindowScaffold(
      titleBarBuilder: (maximized, focused) => 
         TitleBar(maximized: maximized, focused: focused),
      ...
   );
   ```
2. Customize the title bar using Flutter widgets and styling options.

3. Modify colors, buttons, icons, and layout to match your application's aesthetics.

## Implementing Window Controls

This template provides a basic structure for window controls (minimize, maximize, close). To enhance these controls or add more functionalities, refer to the `title_bar.dart` file and the associated event handlers.

## Building and Distributing

When you're ready to distribute your desktop application, use the following steps:

1. **Generate a Release Build**:

   ```bash
   flutter build windows
   ```

2. Find the built executable in the `build/windows/` directory.

3. Distribute your application along with any necessary instructions.

## Contributing

Contributions are welcome! If you have ideas for improvements, new features, or bug fixes, please submit an issue or a pull request to the [custom_window repository](https://github.com/AxonDesigns/custom_window).

## License

This template is licensed under the [MIT License](LICENSE).

## Acknowledgments

This template was inspired by the need for customizable title bars in desktop applications developed with Flutter. Special thanks to the Flutter community for their ongoing support and contributions.

---

Happy coding and building amazing desktop applications with Flutter and the Custom Window template! If you have any questions or need assistance, feel free to reach out to us or the Flutter community.
