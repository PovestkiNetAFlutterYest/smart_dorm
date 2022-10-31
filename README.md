# smart_dorm

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


Get query:
```dart
 void _getUser() {
    final docref = FirebaseFirestore.instance.collection('users').doc("0");
    docref.get().then(
      (DocumentSnapshot doc) {
        var data = doc.data();
        print(data);
      },
      onError: (e) {
        print(e);
      },
    );
  }
```