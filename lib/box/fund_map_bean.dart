import 'package:magic_fund/box/fund_bean.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class FundMapEntity{
  @Id()
  int id;
  String code;
  List<FundInfoEntity> fundInfo;

  FundMapEntity({
    this.code,
    this.fundInfo
  });
  toString() => "Note{id: $id, code: $code}";
}