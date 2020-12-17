import 'package:magic_fund/db/fund_bean.dart';
import 'package:magic_fund/util/fund_util.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;

import '../objectbox.g.dart';

class ObjectBoxUtils {

  var _store;
  Box<FundInfoEntity> _box;

  /// 单例模式
  // 工厂模式
  factory ObjectBoxUtils() =>_getInstance();
  static ObjectBoxUtils get instance => _getInstance();
  static ObjectBoxUtils _instance;
  ObjectBoxUtils._internal() {
    // 初始化
  }
  static ObjectBoxUtils _getInstance(){
    if (_instance == null) {
      _instance = new ObjectBoxUtils._internal();
    }
    return _instance;
  }


  Future<List<FundInfoEntity>> queryFundEntity(String code) async{
    await _initData();
    return _box.query(FundInfoEntity_.code.equals(code)).order(FundInfoEntity_.date, flags: 1).build().find(limit: FundUtil.recentNum - 1);
  }

  Future<bool> addFundEntity(List<FundInfoEntity> fundInfoEntityList) async{
    await _initData();
    try {
      _box.putMany(fundInfoEntityList);
      return true;
    }catch (e) {
      return false;
    }
  }


  _initData() async{
    if(_store == null) {
      var dir = await pathProvider.getTemporaryDirectory();
      _store = Store(getObjectBoxModel(), directory: dir.path + '/objectbox');
      _box = Box<FundInfoEntity>(_store);
    }
  }

}