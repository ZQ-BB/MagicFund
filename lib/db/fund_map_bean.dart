import 'package:objectbox/objectbox.dart';

import 'fund_bean.dart';

@Entity()
class FundMapEntity{
  @Id()
  int id;

  @Unique()
  String code;

  List<FundInfoEntity> fundInfo;

  FundMapEntity({
    this.code,
    this.fundInfo
  });
  toString() => "Note{id: $id, code: $code}";
}