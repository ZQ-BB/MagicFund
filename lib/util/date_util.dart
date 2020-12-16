class DateUtil {


  static int calculateDifferenceInDay(String date) {
    List dateList = date.split('/');
    var dateTime = DateTime(dateList[0],dateList[1],dateList[2]);
    
    var dateNow = DateTime.now();
    
    var difference = dateNow.difference(dateTime);

    return difference.inDays;
  }
}