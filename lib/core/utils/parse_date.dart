class ParseDate {
  static int calculateDaysLeftFromNow(DateTime futureDate) {
    DateTime now = DateTime.now();
    Duration difference = futureDate.difference(now);
    return difference.inDays;
  }
}