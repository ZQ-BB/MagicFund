import 'package:magic_fund/db/fund_map_bean.dart';
import 'package:magic_fund/objectbox.g.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;

class ObjectBoxUtils {

  var _store;
  Box<FundMapEntity> _box;

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


  Future<FundMapEntity> queryFundMap(String code) async{
    await _initData();
    return _box.query(FundMapEntity_.code.equals(code)).build().findFirst();
  }

  Future<bool> addFundMap({FundMapEntity fundMapEntity, List<FundMapEntity> fundMapEntityList}) async{
    await _initData();
    try {
      if (fundMapEntity != null) {
        _box.put(fundMapEntity);
        return true;
      } else if(fundMapEntityList != null && fundMapEntityList.isNotEmpty){
        _box.putMany(fundMapEntityList);
        return true;
      } else {
        return false;
      }
    }catch (e) {
      return false;
    }

  }

  Future removeFundMap(int id) async {
    await _initData();
    return _box.remove(id);
  }

  _initData() async{
    if(_store == null) {
      var dir = await pathProvider.getTemporaryDirectory();
      _store = Store(getObjectBoxModel(), directory: dir.path + '/objectbox');
      _box = Box<FundMapEntity>(_store);
    }
  }

}