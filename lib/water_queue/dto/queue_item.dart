enum ButtonType { bringWater, remindToBringWater }

class DisplayQueueItem {
  DateTime dayWhenNeedToBringWater;
  String personToBringWater;
  String personIdToBringWater;
  int numBottlesBringAlready;

  ButtonType button;

  DisplayQueueItem(this.dayWhenNeedToBringWater, this.personToBringWater,
      this.personIdToBringWater, this.numBottlesBringAlready, this.button);

  @override
  String toString() {
    return 'DisplayQueueItem{personIdToBringWater: $personIdToBringWater, numBottlesBringAlready: $numBottlesBringAlready}';
  }
}
