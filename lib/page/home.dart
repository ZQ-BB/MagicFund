import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:magic_fund/bean/fund_info.dart';
import 'package:magic_fund/db/fund_bean.dart';
import 'package:magic_fund/net/http_for_data.dart';
import 'package:magic_fund/util/data_manager.dart';
import 'package:magic_fund/util/fund_util.dart';
import 'package:preferences/preference_service.dart';


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
    // 获取本地添加的基金列表
    var list = PrefService.sharedPreferences.getStringList('fund_code_list');

    if (list == null) {
      await EasyLoading.dismiss();
      return;
    }

    List flag = List(list.length);
    for(var i = 0; i<list.length; i++) {
      flag[i] = 0;
      _getHistoryData(list[i]).then((value) {
        fundInfo.add(FundInfo()..code = list[i]);
        flag[i] = 1;

        if(!flag.contains(0)) {
          EasyLoading.dismiss();
          refreshController.callRefresh();
        }
      });
    }
  }

  /// 获取历史数据
  Future<void> _getHistoryData(String code) async {
    if(!fundMap.containsKey(code)) {
      try {
        fundMap[code] = await DataManager.getData(code);
      }catch(e) {
        print(e);
      }
    }
  }

  /// 添加新基金
  Future<void> _addNewFund() async {
    await EasyLoading.show();
    try {
      await _getHistoryData(text.text);

      fundInfo.add(FundInfo()..code = text.text);
      PrefService.sharedPreferences.setStringList("fund_code_list", fundInfo.map((e) => e.code).toList());
    }catch(e) {
      print(e);
    }
    await EasyLoading.dismiss();

    refreshController.callRefresh();
  }

  /// 刷新当前数据
  Future<void> _refreshData() async {

    List removeList = List();
    var flag = List(fundInfo.length);
    _callback() {
      removeList.forEach((element) {
        fundInfo.remove(element);
      });
      _refreshUI();
    }

    for(var i = 0; i<fundInfo.length; i++) {
      flag[i] = 0;

      try {
        HttpForData.getCurrentData(fundInfo[i].code).then((current) {
          fundInfo[i].name = current.name;
          fundInfo[i].valuation = double.parse(current.gsz);
          fundInfo[i].growthRate = double.parse(current.gszzl);
          fundInfo[i].estimatedTime = current.gztime;

          //没有做日期的判断(判断有点难)
          if (fundMap.containsKey(fundInfo[i].code)) {
            var fundInfoEntity = FundInfoEntity()..netWorth = fundInfo[i].valuation;
            FundUtil.calculateOne(fundInfoEntity, fundMap[fundInfo[i].code].sublist(0,   -1));
            fundInfo[i].result = fundInfoEntity.result;
          } else {
            removeList.add(fundInfo[i]);
          }
          flag[i] = 1;

          if(!flag.contains(0)) {
            _callback();
          }
        });
      }catch(e) {
        if (fundMap.containsKey(fundInfo[i].code)) {
          fundInfo[i].name = '';
          fundInfo[i].valuation = null;
          fundInfo[i].growthRate = null;
          fundInfo[i].result = fundMap[fundInfo[i].code].first.result;
        } else {
          removeList.add(fundInfo[i]);
        }
        flag[i] = 1;

        if(!flag.contains(0)) {
          _callback();
        }
      }
    }

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
        onPressed: () async {
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
                          await _addNewFund();
                          Navigator.pop(context);
                        },
                        child: Text('确认')
                    )
                  ],
                );
              }
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }

  /// 刷新UI
  _refreshUI() {
    setState(() {});
  }
}