// GENERATED CODE - DO NOT MODIFY BY HAND

// Currently loading model from "JSON" which always encodes with double quotes
// ignore_for_file: prefer_single_quotes

import 'package:objectbox/objectbox.dart';
export 'package:objectbox/objectbox.dart'; // so that callers only have to import this file
import 'db/fund_bean.dart';

ModelDefinition getObjectBoxModel() {
  final model = ModelInfo.fromMap({
    "entities": [
      {
        "id": "1:6480317561573426257",
        "lastPropertyId": "15:2338235092719995178",
        "name": "FundInfoEntity",
        "properties": [
          {"id": "1:4733299753258061690", "name": "id", "type": 6, "flags": 1},
          {
            "id": "2:5649820236899298132",
            "name": "code",
            "type": 9,
            "flags": 2048,
            "indexId": "1:9207209596372961278"
          },
          {"id": "3:2578433927244032433", "name": "date", "type": 9},
          {"id": "4:6366338895421234267", "name": "netWorth", "type": 8},
          {"id": "5:5929597647896497125", "name": "recentAverage", "type": 8},
          {
            "id": "6:4886146864573764638",
            "name": "recentAverageTop",
            "type": 8
          },
          {
            "id": "7:7388744983945054664",
            "name": "recentAverageBottom",
            "type": 8
          },
          {"id": "8:7434343337192197777", "name": "energyColumn", "type": 8},
          {"id": "9:2619176251949022531", "name": "stopMoney", "type": 8},
          {"id": "10:3499638570082997842", "name": "addMoney", "type": 8},
          {"id": "11:6925007300996260361", "name": "wave", "type": 8},
          {
            "id": "12:7594387892799463948",
            "name": "waveRecentAverage",
            "type": 8
          },
          {"id": "13:3094735475831058669", "name": "waveVariance", "type": 8},
          {"id": "14:5901027829043448088", "name": "recentWave", "type": 8},
          {"id": "15:2338235092719995178", "name": "result", "type": 9}
        ]
      }
    ],
    "lastEntityId": "1:6480317561573426257",
    "lastIndexId": "1:9207209596372961278",
    "lastRelationId": "0:0",
    "lastSequenceId": "0:0",
    "modelVersion": 5
  }, check: false);

  final bindings = <Type, EntityDefinition>{};
  bindings[FundInfoEntity] = EntityDefinition<FundInfoEntity>(
      model: model.getEntityByUid(6480317561573426257),
      reader: (FundInfoEntity inst) => {
            'id': inst.id,
            'code': inst.code,
            'date': inst.date,
            'netWorth': inst.netWorth,
            'recentAverage': inst.recentAverage,
            'recentAverageTop': inst.recentAverageTop,
            'recentAverageBottom': inst.recentAverageBottom,
            'energyColumn': inst.energyColumn,
            'stopMoney': inst.stopMoney,
            'addMoney': inst.addMoney,
            'wave': inst.wave,
            'waveRecentAverage': inst.waveRecentAverage,
            'waveVariance': inst.waveVariance,
            'recentWave': inst.recentWave,
            'result': inst.result
          },
      writer: (Map<String, dynamic> members) {
        final r = FundInfoEntity();
        r.id = members['id'];
        r.code = members['code'];
        r.date = members['date'];
        r.netWorth = members['netWorth'];
        r.recentAverage = members['recentAverage'];
        r.recentAverageTop = members['recentAverageTop'];
        r.recentAverageBottom = members['recentAverageBottom'];
        r.energyColumn = members['energyColumn'];
        r.stopMoney = members['stopMoney'];
        r.addMoney = members['addMoney'];
        r.wave = members['wave'];
        r.waveRecentAverage = members['waveRecentAverage'];
        r.waveVariance = members['waveVariance'];
        r.recentWave = members['recentWave'];
        r.result = members['result'];
        return r;
      });

  return ModelDefinition(model, bindings);
}

class FundInfoEntity_ {
  static final id =
      QueryIntegerProperty(entityId: 1, propertyId: 1, obxType: 6);
  static final code =
      QueryStringProperty(entityId: 1, propertyId: 2, obxType: 9);
  static final date =
      QueryStringProperty(entityId: 1, propertyId: 3, obxType: 9);
  static final netWorth =
      QueryDoubleProperty(entityId: 1, propertyId: 4, obxType: 8);
  static final recentAverage =
      QueryDoubleProperty(entityId: 1, propertyId: 5, obxType: 8);
  static final recentAverageTop =
      QueryDoubleProperty(entityId: 1, propertyId: 6, obxType: 8);
  static final recentAverageBottom =
      QueryDoubleProperty(entityId: 1, propertyId: 7, obxType: 8);
  static final energyColumn =
      QueryDoubleProperty(entityId: 1, propertyId: 8, obxType: 8);
  static final stopMoney =
      QueryDoubleProperty(entityId: 1, propertyId: 9, obxType: 8);
  static final addMoney =
      QueryDoubleProperty(entityId: 1, propertyId: 10, obxType: 8);
  static final wave =
      QueryDoubleProperty(entityId: 1, propertyId: 11, obxType: 8);
  static final waveRecentAverage =
      QueryDoubleProperty(entityId: 1, propertyId: 12, obxType: 8);
  static final waveVariance =
      QueryDoubleProperty(entityId: 1, propertyId: 13, obxType: 8);
  static final recentWave =
      QueryDoubleProperty(entityId: 1, propertyId: 14, obxType: 8);
  static final result =
      QueryStringProperty(entityId: 1, propertyId: 15, obxType: 9);
}
