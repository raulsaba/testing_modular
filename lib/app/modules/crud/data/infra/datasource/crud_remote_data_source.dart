import 'package:testing_modular/app/modules/crud/data/models/crud_model.dart';

abstract class ICrudRemoteDataSource {
  Future<bool> delete(int id);
  Future<CrudModel> create(CrudModel crudModel);
  Future<CrudModel> update(int id, CrudModel crudModel);
  Future<CrudModel> show(int id);
  Future<List<CrudModel>> index();
}
