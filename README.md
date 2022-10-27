# pantry-chef-app
Flutter front-end for pantry-chef project

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Testing

Run ` flutter test --coverage ` to run and determine coverage.

## Generating JSON

Command to generate serializable API models:

```
flutter pub run build_runner build
```

### Linux report

```
sudo apt install lcov
genhtml coverage/lcov.info -o ./report
```
### Mac report

```
brew install lcov
genhtml coverage/lcov.info -o ./report
```
