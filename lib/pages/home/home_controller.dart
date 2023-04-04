import 'dart:developer';

import 'package:get/get.dart';
import 'package:get_connect_example/models/user_model.dart';
import 'package:get_connect_example/repositories/user_repository.dart';

class HomeController extends GetxController with StateMixin<List<UserModel>> {
  final UserRepository _repository;

  HomeController({required UserRepository repository})
      : _repository = repository;

  @override
  void onReady() {
    _findAll();
    super.onReady();
  }

  Future<void> _findAll() async {
    try {
      change([], status: RxStatus.loading());

      final users = await _repository.findAll();
      var statusReturn = RxStatus.success();
      if (users.isEmpty) {
        statusReturn = RxStatus.empty();
      }
      change(users, status: statusReturn);
    } catch (e, s) {
      log('Erro ao buscar usuários', error: e, stackTrace: s);
      change(state, status: RxStatus.error());
    }
  }

  Future<void> register() async {
    try {
      final user = UserModel(
        name: 'Gabriel Zorzan',
        email: 'gabriel_zds@hotmail.com',
        password: '12312312134',
      );
      await _repository.save(user);
      _findAll();
    } catch (e, s) {
      log('Erro ao salvar usuario', error: e, stackTrace: s);
      Get.snackbar('Erro', 'Erro ao salvar usuário');
    }
  }

  Future<void> updateUser(UserModel user) async {
    try {
      user.name = 'Bielzin';
      user.email = 'testando@HOTMAIL.COM';
      await _repository.updateUser(user);
      _findAll();
    } catch (e, s) {
      log('Erro ao atualizar usuario', error: e, stackTrace: s);
      Get.snackbar('Erro', 'Erro ao atualizar usuário');
    }
  }

  Future<void> delete(UserModel user) async {
    await _repository.deleteUser(user);
    Get.snackbar('Sucesso', 'Usuario deletado coms sucesso');
    _findAll();
  }
}
