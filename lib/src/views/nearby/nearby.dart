library view.nearby;

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../controllers/controllers.dart'
  show AppController;
import '../views.dart'
  show AppRoute;

part 'test.dart';
part 'route.dart';

class NearbyView extends GetView<AppController> {
  /// The nearby page in app.
  const NearbyView({ Key? key }) : super(key: key);

  /// The route name or path root page or main page.
  /// that the embedder requested when the application
  /// was launched.
  ///
  /// This will be the string "/" if no particular route
  /// was requested.
  static const String routeName = '/nearby';

  @override
  Widget build(BuildContext context) =>
    Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Nearby View'),
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              'Nearby',
              style: context.textTheme.headline6,
            ),
            TextButton(
              onPressed: () {
                Get.toNamed<Object>(
                  NearbyRoute.test,
                  id: AppRoute.nearby.id);
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