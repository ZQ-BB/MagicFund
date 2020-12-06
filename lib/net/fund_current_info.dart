/// fundcode : "213001"
/// name : "宝盈鸿利收益灵活配置混合A"
/// jzrq : "2020-12-03"
/// dwjz : "2.2690"
/// gsz : "2.2909"
/// gszzl : "0.96"
/// gztime : "2020-12-04 15:00"

class FundCurrentInfo {
  String _fundcode;
  String _name;
  String _jzrq;
  String _dwjz;
  String _gsz;
  String _gszzl;
  String _gztime;

  String get fundcode => _fundcode;
  String get name => _name;
  String get jzrq => _jzrq;
  String get dwjz => _dwjz;
  String get gsz => _gsz;
  String get gszzl => _gszzl;
  String get gztime => _gztime;

  FundCurrentInfo({
      String fundcode, 
      String name, 
      String jzrq, 
      String dwjz, 
      String gsz, 
      String gszzl, 
      String gztime}){
    _fundcode = fundcode;
    _name = name;
    _jzrq = jzrq;
    _dwjz = dwjz;
    _gsz = gsz;
    _gszzl = gszzl;
    _gztime = gztime;
}

  FundCurrentInfo.fromJson(dynamic json) {
    _fundcode = json["fundcode"];
    _name = json["name"];
    _jzrq = json["jzrq"];
    _dwjz = json["dwjz"];
    _gsz = json["gsz"];
    _gszzl = json["gszzl"];
    _gztime = json["gztime"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["fundcode"] = _fundcode;
    map["name"] = _name;
    map["jzrq"] = _jzrq;
    map["dwjz"] = _dwjz;
    map["gsz"] = _gsz;
    map["gszzl"] = _gszzl;
    map["gztime"] = _gztime;
    return map;
  }

}