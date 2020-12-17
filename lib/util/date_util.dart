class DateUtil {


  static int calculateDifferenceInDay(String date) {
    List<int> dateList = date.split('-').map((e) => int.parse(e)).toList();
    var dateTime = DateTime(dateList[0],dateList[1],dateList[2]);
    
    var dateNow = DateTime.now();
    
    var difference = dateNow.difference(dateTime);

    return difference.inDays - 1;
  }
}