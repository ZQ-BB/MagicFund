import 'package:magic_fund/db/db_for_data.dart';
import 'package:magic_fund/db/fund_bean.dart';
import 'package:magic_fund/db/fund_map_bean.dart';
import 'package:magic_fund/db/objectbox_utils.dart';
import 'package:magic_fund/net/http_for_data.dart';

class DataManager {

  static Future<List<FundInfoEntity>> getData(String code) async{
    List<FundInfoEntity> result;

    // 先通过数据库查询
    result.addAll(await DBForData.getData(code));

    // 数据库不存在数据
    if (result.isEmpty) {
      // 网络请求获取数据
      await _httpForData(result, code);
      // 本地存储
      await ObjectBoxUtils.instance.addFundMap(
          fundMapEntity: FundMapEntity()
            ..code = code
            ..fundInfo = result
      );
    }

    // 验证数据的实时性
    return result;
  }

  static _httpForData(List list, String code) async{
    HttpForData.getHistoryData(code, page: 1).then((value) {
      if (list.isEmpty) {
        list.addAll(value);
      } else {
        list.insertAll(0, value);
      }
    });

    HttpForData.getHistoryData(code, page: 2).then((value) {
      list.addAll(value);
    });
  }
}