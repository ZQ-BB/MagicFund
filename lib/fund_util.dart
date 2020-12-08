import 'dart:math';

import 'package:magic_fund/box/fund_bean.dart';

class FundUtil {

  static int recentNum = 20;

  static calculateList(List<FundInfoEntity> recentFundInfo) {
    List<FundInfoEntity> list = List();
    for(var i = recentFundInfo.length - 1; i>=0; i--) {
      calculateOne(recentFundInfo[i], list);
      if(list.length == recentNum - 1) {
        list.removeLast();
      }
      list.insert(0, recentFundInfo[i]);
    }
  }

  static calculateOne(FundInfoEntity fundInfo, List<FundInfoEntity> recentFundInfo) {
    // C
    fundInfo.recentAverage = 0;
    recentFundInfo.forEach((element) {
      fundInfo.recentAverage += element.netWorth;
    });
    fundInfo.recentAverage += fundInfo.netWorth;
    fundInfo.recentAverage /= recentNum;

    // I
    fundInfo.wave = pow(fundInfo.recentAverage - fundInfo.netWorth, 2);

    // J
    fundInfo.waveRecentAverage = 0;
    recentFundInfo.forEach((element) {
      fundInfo.waveRecentAverage += element.wave;
    });
    fundInfo.waveRecentAverage += fundInfo.wave;
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
    fundInfo.recentWave = 1;
    try {
      fundInfo.recentWave = 1 - recentFundInfo[recentNum-2].netWorth / fundInfo.netWorth;
    }catch(e) {
      print(e);
    }

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