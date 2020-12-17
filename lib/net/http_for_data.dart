import 'dart:convert' as convert ;
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:magic_fund/db/fund_bean.dart';
import 'package:magic_fund/net/fund_current_info.dart';
import 'package:xml/xml.dart';

class HttpForData {

  /// 获取历史数据
  static Future<List<FundInfoEntity>> getHistoryData(String fundCode,{int per = 40, int page = 1}) async{
    List<FundInfoEntity> list = List();

    var url = 'https://fundf10.eastmoney.com/F10DataApi.aspx?type=lsjz&code=$fundCode&sdate=2020-01-01&edate=2030-01-01&per=$per&page=$page';

    var data = await http.get(url);

    String body = data.body.toString();
    body = body.replaceAll('var apidata={ content:\"', '');
    var index = body.lastIndexOf('\",records:');
    body = body.replaceRange(index,body.length, '');

    var document = XmlDocument.parse(body);
    document.firstChild.lastChild.children.forEach((element) {
      list.add(FundInfoEntity()
          ..code = fundCode
          ..date = element.children[0].text
          ..netWorth = double.parse(element.children[1].text)
      );
    });

    return list;
  }


  /// 获取当前数据
  static Future<FundCurrentInfo> getCurrentData(String fundCode) async{

    var url = 'http://fundgz.1234567.com.cn/js/$fundCode.js';

    var data = await http.get(url);
    print(data.body);

    var isoEncoding = Encoding.getByName('iso-8859-1');
    var utfEncoding = Encoding.getByName('utf-8');
    String body = utfEncoding.decode(isoEncoding.encode(data.body));

    body = body.replaceAll('jsonpgz(', '');
    body = body.replaceAll(');', '');

    return FundCurrentInfo.fromJson(convert.jsonDecode(body));
  }
}