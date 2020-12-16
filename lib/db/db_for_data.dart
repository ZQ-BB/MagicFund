import 'package:magic_fund/db/objectbox_utils.dart';

import 'fund_bean.dart';

class DBForData {

  static Future<List<FundInfoEntity>> getData(String code) async{
    var fundMap = await ObjectBoxUtils.instance.queryFundMap(code);
    if (fundMap != null) {
      return fundMap.fundInfo;
    }else {
      return List();
    }
  }
}