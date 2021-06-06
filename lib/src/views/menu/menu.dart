library view.menu;

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../controllers/controllers.dart'
  show
    MenuBinding,
    MenuController;
import '../../route.dart'
  show AppRoute;

part 'test.dart';
part 'route.dart';

class MenuView extends GetView<MenuController> {
  /// The notification page in app.
  const MenuView({ Key? key }) : super(key: key);

  /// The route name or path root page or main page.
  /// that the embedder requested when the application
  /// was launched.
  ///
  /// This will be the string "/" if no particular route
  /// was requested.
  static const String routeName = '/menu';

  @override
  Widget build(BuildContext context) =>
    Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Menu View'),
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              'Menu',
              style: context.textTheme.headline6,
            ),
            TextButton(
              onPressed: () {
                Get.toNamed<Object>(
                  MenuRoute.test,
                  id: AppRoute.menu.id);
              },
              child: Text(
                'To test',
                style: context.textTheme.bodyText2,
              ),
            ),
          ],
        ),
      ),
    );
}