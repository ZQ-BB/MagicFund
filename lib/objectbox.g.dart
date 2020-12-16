// GENERATED CODE - DO NOT MODIFY BY HAND

// Currently loading model from "JSON" which always encodes with double quotes
// ignore_for_file: prefer_single_quotes

import 'package:objectbox/objectbox.dart';
export 'package:objectbox/objectbox.dart'; // so that callers only have to import this file
import 'db/fund_bean.dart';
import 'db/fund_map_bean.dart';

ModelDefinition getObjectBoxModel() {
  final model = ModelInfo.fromMap({
    "entities": [
      {
        "id": "1:632429744396753866",
        "lastPropertyId": "14:4608639962066571630",
        "name": "FundInfoEntity",
        "properties": [
          {"id": "1:5042280733691393600", "name": "id", "type": 6, "flags": 1},
          {"id": "2:4406073545106133302", "name": "date", "type": 9},
          {"id": "3:537622413430472249", "name": "netWorth", "type": 8},
          {"id": "4:4032865668946396427", "name": "recentAverage", "type": 8},
          {
            "id": "5:8475809111508380187",
            "name": "recentAverageTop",
            "type": 8
          },
          {
            "id": "6:8290962819272043474",
            "name": "recentAverageBottom",
            "type": 8
          },
          {"id": "7:131000496370466662", "name": "energyColumn", "type": 8},
          {"id": "8:8763305784829816782", "name": "stopMoney", "type": 8},
          {"id": "9:2084272520297700895", "name": "addMoney", "type": 8},
          {"id": "10:830417308016117035", "name": "wave", "type": 8},
          {
            "id": "11:5390789494064334763",
            "name": "waveRecentAverage",
            "type": 8
          },
          {"id": "12:8815456755453250139", "name": "waveVariance", "type": 8},
          {"id": "13:5498853158397876835", "name": "recentWave", "type": 8},
          {"id": "14:4608639962066571630", "name": "result", "type": 9}
        ]
      },
      {
        "id": "2:6099811182382692305",
        "lastPropertyId": "2:5451066351632914518",
        "name": "FundMapEntity",
        "properties": [
          {"id": "1:6049763127546726320", "name": "id", "type": 6, "flags": 1},
          {"id": "2:5451066351632914518", "name": "code", "type": 9}
        ]
      }
    ],
    "lastEntityId": "2:6099811182382692305",
    "lastIndexId": "0:0",
    "lastRelationId": "0:0",
    "lastSequenceId": "0:0",
    "modelVersion": 5
  }, check: false);

  final bindings = <Type, EntityDefinition>{};
  bindings[FundInfoEntity] = EntityDefinition<FundInfoEntity>(
      model: model.getEntityByUid(632429744396753866),
      reader: (FundInfoEntity inst) => {
            'id': inst.id,
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
  bindings[FundMapEntity] = EntityDefinition<FundMapEntity>(
      model: model.getEntityByUid(6099811182382692305),
      reader: (FundMapEntity inst) => {'id': inst.id, 'code': inst.code},
      writer: (Map<String, dynamic> members) {
        final r = FundMapEntity();
        r.id = members['id'];
        r.code = members['code'];
        return r;
      });

  return ModelDefinition(model, bindings);
}

class FundInfoEntity_ {
  static final id =
      QueryIntegerProperty(entityId: 1, propertyId: 1, obxType: 6);
  static final date =
      QueryStringProperty(entityId: 1, propertyId: 2, obxType: 9);
  static final netWorth =
      QueryDoubleProperty(entityId: 1, propertyId: 3, obxType: 8);
  static final recentAverage =
      QueryDoubleProperty(entityId: 1, propertyId: 4, obxType: 8);
  static final recentAverageTop =
      QueryDoubleProperty(entityId: 1, propertyId: 5, obxType: 8);
  static final recentAverageBottom =
      QueryDoubleProperty(entityId: 1, propertyId: 6, obxType: 8);
  static final energyColumn =
      QueryDoubleProperty(entityId: 1, propertyId: 7, obxType: 8);
  static final stopMoney =
      QueryDoubleProperty(entityId: 1, propertyId: 8, obxType: 8);
  static final addMoney =
      QueryDoubleProperty(entityId: 1, propertyId: 9, obxType: 8);
  static final wave =
      QueryDoubleProperty(entityId: 1, propertyId: 10, obxType: 8);
  static final waveRecentAverage =
      QueryDoubleProperty(entityId: 1, propertyId: 11, obxType: 8);
  static final waveVariance =
      QueryDoubleProperty(entityId: 1, propertyId: 12, obxType: 8);
  static final recentWave =
      QueryDoubleProperty(entityId: 1, propertyId: 13, obxType: 8);
  static final result =
      QueryStringProperty(entityId: 1, propertyId: 14, obxType: 9);
}

class FundMapEntity_ {
  static final id =
      QueryIntegerProperty(entityId: 2, propertyId: 1, obxType: 6);
  static final code =
      QueryStringProperty(entityId: 2, propertyId: 2, obxType: 9);
}
