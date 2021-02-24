import 'package:magic_fund/db/db_for_data.dart';
import 'package:magic_fund/db/fund_bean.dart';
import 'package:magic_fund/db/objectbox_utils.dart';
import 'package:magic_fund/net/http_for_data.dart';

import '../net/http_for_data.dart';
import 'date_util.dart';
import 'fund_util.dart';

class DataManager {

  static Future<List<FundInfoEntity>> getData(String code) async{
    List<FundInfoEntity> result;

    // 先通过数据库查询(只需要 FundUtil.recentNum - 1 条)
    result = await DBForData.getData(code);

    if (result.isEmpty) { // 数据库不存在数据
      // 网络请求获取数据
      result.addAll(await HttpForData.getHistoryData(code, page: 1));
      result.addAll(await HttpForData.getHistoryData(code, page: 2));
      result.addAll(await HttpForData.getHistoryData(code, page: 3));

      // 计算基金的其他数据
      FundUtil.calculateList(result);

      // 保存到数据库
      ObjectBoxUtils.instance.addFundEntity(result);
    } else { // 判断日期
      // 获取相差的天数
      var days = DateUtil.calculateDifferenceInDay(result.first.date);

      if(days > 0) {
        // 接口获取的列表
        List<FundInfoEntity> tempList = List();
        // 总共需要的页数
        int pages = (days ~/ HttpForData.numPerPage) + 1;

        // 循环调用接口 获取数据
        for(var i = 0; i<pages; i++) {
          var per = i == pages - 1 ? days % HttpForData.numPerPage : HttpForData.numPerPage;
          tempList.addAll(await HttpForData.getHistoryData(code, per: per, page: i+1));
        }

        // 去除重复项
        var index = tempList.lastIndexWhere((element) => element.date == result.first.date);
        if(index != -1) {
          tempList.removeRange(index, tempList.length);
        }

        // 计算并添加
        if(tempList.isNotEmpty) {
          for(var i = tempList.length-1; i>=0; i--) {
            FundUtil.calculateOne(tempList[i], result.sublist(0,FundUtil.recentNum - 1));
            result.add(tempList[i]);
          }
        }

        // 更新数据库
        ObjectBoxUtils.instance.addFundEntity(result);
      }

    }

    return result;
  }
}