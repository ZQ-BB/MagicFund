import 'dart:math';

import 'package:magic_fund/db/fund_bean.dart';


class FundUtil {

  static int recentNum = 20;
  static int minTotalNum = 125;

  static calculateList(List<FundInfoEntity> recentFundInfo) {
    List<FundInfoEntity> list = List();
    for(var i = recentFundInfo.length - 1; i>=0; i--) {
      calculateOne(recentFundInfo[i], list);
      if(list.length == minTotalNum - 1) {
        list.removeLast();
      }
      list.insert(0, recentFundInfo[i]);
    }
  }

  static calculateOne(FundInfoEntity fundInfo, List<FundInfoEntity> recentFundInfo) {
    var temp = 0;
    // C
    fundInfo.recentAverage = fundInfo.netWorth;
    for(temp = 0; temp < recentNum - 1 && temp < recentFundInfo.length; temp++) {
      fundInfo.recentAverage += recentFundInfo[temp].netWorth;
    }
    fundInfo.recentAverage /= recentNum;

    // I
    fundInfo.wave = pow(fundInfo.recentAverage - fundInfo.netWorth, 2);

    // J
    fundInfo.waveRecentAverage = fundInfo.wave;
    for(temp = 0; temp < recentNum - 1 && temp < recentFundInfo.length; temp++) {
      fundInfo.waveRecentAverage += recentFundInfo[temp].wave;
    }
    fundInfo.waveRecentAverage /= recentNum;

    // K
    fundInfo.waveVariance = sqrt(fundInfo.waveRecentAverage);

    // D
    fundInfo.recentAverageTop = fundInfo.recentAverage+2*fundInfo.waveVariance;

    // E
    fundInfo.recentAverageBottom = fundInfo.recentAverage-2*fundInfo.waveVariance;

    // F
    fundInfo.energyColumn = (2*fundInfo.netWorth - fundInfo.recentAverageTop - fundInfo.recentAverageBottom)/fundInfo.netWorth;

    // G
    fundInfo.stopMoney = fundInfo.recentAverage + (fundInfo.recentAverageTop - fundInfo.recentAverage)*0.309;

    // H
    fundInfo.addMoney = fundInfo.recentAverage + (fundInfo.recentAverageBottom - fundInfo.recentAverage)*0.309;

    // L
    if(recentNum-2 < recentFundInfo.length) {
      fundInfo.recentWave = 1 - recentFundInfo[recentNum-2].netWorth / fundInfo.netWorth;
    } else {
      fundInfo.recentWave = 1;
    }

    // 增长率
    if(recentFundInfo.isNotEmpty) {
      fundInfo.growthRate = (fundInfo.netWorth - recentFundInfo[0].netWorth) / recentFundInfo[0].netWorth;
    } else {
      fundInfo.growthRate = 0.toDouble();
    }

    // 短线result
    double sum5 = fundInfo.growthRate;
    for(temp = 0; temp < 4 && temp < recentFundInfo.length; temp++) {
      sum5 += recentFundInfo[temp].growthRate;
    }
    double sumTotal = fundInfo.growthRate;
    for(temp = 0; temp < recentFundInfo.length; temp++) {
      sum5 += recentFundInfo[temp].growthRate;
    }
    fundInfo.result2 = sum5 - sumTotal/25;

    // result
    var a = false;
    var b = false;
    var c = false;
    try {
      a = recentFundInfo[0].netWorth > recentFundInfo[0].recentAverageTop;
      b = recentFundInfo[0].netWorth > recentFundInfo[0].stopMoney;
      c = recentFundInfo[0].netWorth < recentFundInfo[0].recentAverageTop;
    }catch(e) {
      print(e);
    }
    if(a && fundInfo.netWorth < fundInfo.recentAverageTop) {
      fundInfo.result = '清仓';
    } else if(b && c && fundInfo.netWorth < fundInfo.stopMoney) {
      fundInfo.result = '止盈赎回';
    } else if(fundInfo.netWorth > fundInfo.addMoney) {
      fundInfo.result = '观望期';
    } else if(fundInfo.netWorth > fundInfo.recentAverageBottom) {
      fundInfo.result = '加仓';
    } else {
      fundInfo.result = '探底加仓';
    }

  }
}