import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_connect_example/pages/home/home_controller.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.register();
        },
        child: const Icon(Icons.add),
      ),
      body: controller.obx((state) {
        if (state == null) {
          return const Center(
            child: Text('Nenhum usuario cadastrado'),
          );
        }
        return ListView.builder(
          itemCount: state.length,
          itemBuilder: (context, index) {
            final user = state[index];
            return ListTile(
              onTap: () => controller.updateUser(user),
              onLongPress: () => controller.delete(user),
              title: Text(user.name),
              subtitle: Text(user.email),
            );
          },
        );
      },
          onEmpty: const Center(
            child: Text('Nenhum usuario cadastrado'),
          ),
          onError: (error) =>
              const Center(child: Text('Erro ao buscar usuarios '))),
    );
  }
}
