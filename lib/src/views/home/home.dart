library view.home;

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../controllers/controllers.dart'
  show
    HomeBinding,
    HomeController;
import '../../route.dart'
  show AppRoute;

part 'test.dart';
part 'route.dart';

class HomeView extends GetView<HomeController> {
  /// The home page in app.
  const HomeView({ Key? key }) : super(key: key);

  /// The route name or path root page or main page.
  /// that the embedder requested when the application
  /// was launched.
  ///
  /// This will be the string "/" if no particular route
  /// was requested.
  static const String routeName = '/home';

  @override
  Widget build(BuildContext context) =>
    Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Home View'),
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              'Home',
              style: context.textTheme.headline6,
            ),
            TextButton(
              onPressed: () {
                Get.toNamed<void>(
                  HomeRoute.test,
                  id: AppRoute.home.id);
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