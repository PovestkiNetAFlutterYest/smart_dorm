import '../../auth/models/user.dart';
import '../dto/queue_item.dart';
import '../dto/water_bring_counter.dart';

List<DateTime> generateNextSundayDates(int n) {
  var now = DateTime.now();

  // Sunday
  if (now.weekday != 7) {
    var daysToWait = 7 - now.weekday;
    now = now.add(Duration(days: daysToWait));
  }

  List<DateTime> listOfDates = [];
  for (var i = 0; i < n; i++) {
    listOfDates.add(now);
    now = now.add(const Duration(days: 7));
  }

  return listOfDates;
}

int comparator(WaterSupplyItem item1, WaterSupplyItem item2) {
  if (item1.numBottlesBrung != item2.numBottlesBrung) {
    return item1.numBottlesBrung.compareTo(item2.numBottlesBrung);
  } else {
    return item1.lastTimeBottleBrung.compareTo(item2.lastTimeBottleBrung);
  }
}

List<DisplayQueueItem> generateQueue(
    List<WaterSupplyItem> items, List<User> users) {
  var n = items.length;

  var listOfDates = generateNextSundayDates(n);
  items.sort((a, b) => comparator(a, b));

  Map<String, String> userIdToName = {};
  for (var i = 0; i < n; i++) {
    userIdToName[users[i].userId] = users[i].name;
  }

  List<DisplayQueueItem> outputItems = [];
  for (var i = 0; i < n; i++) {
    String userId = items[i].userId;
    String userName = userIdToName[userId] ?? "Not found user name";
    int numBottlesBrung = items[i].numBottlesBrung;

    ButtonType button =
        userId == '2' ? ButtonType.bringWater : ButtonType.remindToBringWater;

    outputItems.add(DisplayQueueItem(
        listOfDates[i], userName, userId, numBottlesBrung, button));
  }

  return outputItems;
}
