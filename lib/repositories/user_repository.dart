import 'package:get/get.dart';
import 'package:get_connect_example/models/user_model.dart';

class UserRepository {
  final restClient = GetConnect(timeout: const Duration(milliseconds: 600));

  UserRepository() {
    restClient.baseUrl = 'http://192.168.1.16:8080';
  }

  Future<List<UserModel>> findAll() async {
    final result = await restClient.get('/users');

    if (result.hasError) {
      throw Exception('Erro ao buscar usuário (${result.statusText})');
    }

    return result.body
        .map<UserModel>((user) => UserModel.fromMap(user))
        .toList();
  }

  Future<void> save(UserModel user) async {
    final result = await restClient.post('/users', user.toMap());

    if (result.hasError) {
      throw Exception('Erro ao ao salvar usuário (${result.statusText})');
    }
  }

  Future<void> deleteUser(UserModel user) async {
    final result = await restClient.delete('/users/${user.id}');

    if (result.hasError) {
      throw Exception('Erro ao ao deletar usuário (${result.statusText})');
    }
  }

  Future<void> updateUser(UserModel user) async {
    final result = await restClient.put('/users/${user.id}', user.toMap());
    if (result.hasError) {
      throw Exception('Erro ao ao atualizar  usuário (${result.statusText})');
    }
  }
}
