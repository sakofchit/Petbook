# petbook

This was from our group's final project in POOSD (COP4331) @ UCF

The concept of the app was to allow pet owners to create pet profiles that generate QR dog-tags as a substitute for normal dog tags/microchipping. The tags can be scanned by anyone which will take you to a page containing more information about the dog, its owner, etc. (stuff you probably wouldn't be able to fit on a normal dog tag)


Screenshots can be found [here](https://github.com/sakofchit/Petbook/tree/main/screenshots): 



## Getting Started!


Petbook projects are built to run on the Flutter _stable_ release.

If on MacOS, ensure you have XCode. Android Studio if on Windows.

### IMPORTANT:

Run the following commands to ensure the project compiles:

```
flutter pub get
flutter packages pub run build_runner build --delete-conflicting-outputs
```

This command creates the generated files that parse each Record from Firestore into a schema object.

### Getting started continued:

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
