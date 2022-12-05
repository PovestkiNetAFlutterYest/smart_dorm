import 'dart:math';

String generateRandomString(int len) {
  var r = Random();
  const chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz123456';
  return List.generate(len, (index) => chars[r.nextInt(chars.length)]).join();
}

String generateUniqueString(int len, Set<String> existingStrings) {
  String? result;

  while (result == null) {
    String text = generateRandomString(10);
    if (!existingStrings.contains(text)) {
      result = text;
    }
  }

  return result;
}
