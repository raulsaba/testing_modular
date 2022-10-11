import 'package:testing_modular/app/modules/crud/data/models/crud_model.dart';

abstract class ICrudLocalDataSource {
  Future<bool> saveCrudListOnCache(List<CrudModel> crudModelList);
  Future<List<CrudModel>> getCrudListFromCache();
  Future<bool> clearCache();
}
