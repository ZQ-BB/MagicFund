import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:magic_fund/box/fund_bean.dart';
import 'package:magic_fund/fund_util.dart';
import 'package:preferences/preference_service.dart';

import 'fund_info.dart';
import 'net/http_for_data.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  // 所有基金今天的估值信息
  List<FundInfo> fundInfo = List();
  // 本地缓存
  Map<String, List<FundInfoEntity>> fundMap = HashMap();

  // UI
  TextEditingController text = TextEditingController();
  EasyRefreshController refreshController = EasyRefreshController();

  @override
  void initState() {
    super.initState();

    initData();
  }

  initData() async{
    await EasyLoading.show();
    var list = PrefService.sharedPreferences.getStringList('fund_code_list');
    if (list == null) {
      await EasyLoading.dismiss();
      return;
    }
    for(var i = 0; i<list.length; i++) {
      try {
        await _getHistoryData(list[i]);
        fundInfo.add(FundInfo()..code = list[i]);
      }catch (e) {
        print(e);
      }
    }
    await EasyLoading.dismiss();
    refreshController.callRefresh();
  }

  _getHistoryData(String code) async {
    if(!fundMap.containsKey(code)) {
      fundMap[code] = await HttpForData.getHistoryData(code);
    }
    FundUtil.calculateList(fundMap[code]);
  }

  /// 添加新基金
  _addNewFund() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('输入基金代码'),
          content: Container(
            child: TextField(
              controller: text,
            ),
          ),
          actions: [
            FlatButton(
              onPressed: () async {
                await EasyLoading.show();
                try {
                  await _getHistoryData(text.text);

                  fundInfo.add(FundInfo()..code = text.text);
                  PrefService.sharedPreferences.setStringList("fund_code_list", fundInfo.map((e) => e.code).toList());
                }catch(e) {
                  print(e);
                }
                await EasyLoading.dismiss();
                Navigator.pop(context);

                refreshController.callRefresh();
              },
              child: Text('确认')
            )
          ],
        );
      }
    );
  }

  /// 刷新当前数据
  Future<void> _refreshData() async {
    // 防止没有
    var removeCodeList = List();

    for (var value in fundInfo) {
      try {
        var currentInfo = await HttpForData.getCurrentData(value.code);
        value.name = currentInfo.name;
        value.valuation = double.parse(currentInfo.gsz);
        value.growthRate = double.parse(currentInfo.gszzl);
        value.estimatedTime = currentInfo.gztime;

        if (fundMap.containsKey(value.code)) {
          var fundInfoEntity = FundInfoEntity()..netWorth = value.valuation;
          await FundUtil.calculateOne(fundInfoEntity, fundMap[value.code].sublist(0, FundUtil.recentNum-1));
          value.result = fundInfoEntity.result;
        } else {
          removeCodeList.add(value.code);
        }
      }catch(e) {
        if (fundMap.containsKey(value.code)) {
          value.name = '';
          value.valuation = null;
          value.growthRate = null;
          value.result = fundMap[value.code].first.result;
        } else {
          removeCodeList.add(value.code);
        }
      }
    }

    fundInfo.removeWhere((element) => removeCodeList.contains(element.code));

    _refreshUI();
  }

  @override
  Widget build(BuildContext context) {

    String _getTime() {
      if (fundInfo.isEmpty) {
        return '';
      } else {
        return fundInfo.first.estimatedTime;
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('科学养鸡'),
      ),
      body: Center(
        child: EasyRefresh(
          controller: refreshController,
          onRefresh: _refreshData,
          header: ClassicalHeader(
            refreshText: '下拉刷新',
            refreshReadyText: '释放立即刷新',
            refreshingText: '正在刷新...',
            refreshedText: '刷新成功',
            refreshFailedText: '刷新失败',
            showInfo: fundInfo.isNotEmpty,
            infoText: _getTime(),
          ),
          child: ListView.separated(
              itemBuilder: (context, index) {
                var info = fundInfo[index];

                return ListTile(
                  leading: Text('${info.code}'),
                  title: Text('${info.name??''}'),
                  subtitle: Row(
                    children: [
                      Text('估值：${info.valuation??''}'),
                      Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: info.growthRate != null ? Text(
                            '${info.growthRate}',
                            style: TextStyle(
                                color: info.growthRate > 0 ? Colors.deepOrange[400]
                                    : Colors.green[400]
                            )
                        ): Text(''),
                      )
                    ],
                  ),
                  trailing: Text(info.result??''),
                );
              },
              separatorBuilder: (context, index) => Divider(),
              itemCount: fundInfo.length
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewFund,
        child: Icon(Icons.add),
      ),
    );
  }

  _refreshUI() {
    setState(() {});
  }
}