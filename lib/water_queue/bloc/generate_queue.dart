import '../../auth/dto/user.dart';
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
  if (item1.count != item2.count) {
    return item1.count.compareTo(item2.count);
  } else {
    return item1.lastTimeBring.compareTo(item2.lastTimeBring);
  }
}

List<DisplayQueueItem> generateQueue(
    List<WaterSupplyItem> items, List<User> users, User currentUser) {
  var n = items.length;

  var listOfDates = generateNextSundayDates(n);
  items.sort((a, b) => comparator(a, b));

  Map<String, String> userIdToName = {};
  for (var i = 0; i < n; i++) {
    userIdToName[users[i].id] = users[i].name;
  }

  List<DisplayQueueItem> outputItems = [];
  for (var i = 0; i < n; i++) {
    String userId = items[i].userId;
    String userName = userIdToName[userId] ?? "Not found user name";
    int numBottlesBrung = items[i].count;

    ButtonType button =
        userId == currentUser.id ? ButtonType.bringWater : ButtonType.remindToBringWater;

    outputItems.add(DisplayQueueItem(
        listOfDates[i], userName, userId, numBottlesBrung, button));
  }

  return outputItems;
}
