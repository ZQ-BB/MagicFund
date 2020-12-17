import 'package:magic_fund/db/objectbox_utils.dart';

import 'fund_bean.dart';

class DBForData {

  static Future<List<FundInfoEntity>> getData(String code) async{
    var fundEntityList = await ObjectBoxUtils.instance.queryFundEntity(code);
    if (fundEntityList != null) {
      return fundEntityList;
    }else {
      return List();
    }
  }
}