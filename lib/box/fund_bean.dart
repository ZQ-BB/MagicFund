import 'package:objectbox/objectbox.dart';

@Entity()
class FundInfoEntity {
  @Id()
  int id;
  String date;
  double netWorth;
  double recentAverage;
  double recentAverageTop;
  double recentAverageBottom;
  double energyColumn;
  double stopMoney;
  double addMoney;
  double wave;
  double waveRecentAverage;
  double waveVariance;
  double recentWave;
  String result;

  FundInfoEntity({
    this.date,
    this.netWorth,
    this.recentAverage,
    this.recentAverageTop,
    this.recentAverageBottom,
    this.energyColumn,
    this.stopMoney,
    this.addMoney,
    this.wave,
    this.waveRecentAverage,
    this.waveVariance,
    this.recentWave,
    this.result
  });

  toString() => "FundInfo"
      "{id: $id, "
      "date: $date, "
      "netWorth: $netWorth, "
      "recentAverage: $recentAverage, "
      "recentAverageTop: $recentAverageTop, "
      "recentAverageBottom: $recentAverageBottom ,"
      "energyColumn: $energyColumn, "
      "stopMoney: $stopMoney, "
      "addMoney: $addMoney, "
      "wave: $wave, "
      "waveRecentAverage: $waveRecentAverage, "
      "waveVariance: $waveVariance, "
      "recentWave: $recentWave, "
      "result: $result, "
      "}";
}