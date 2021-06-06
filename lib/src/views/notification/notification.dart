library view.notification;

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../controllers/controllers.dart'
  show
    NotifyBinding,
    NotifyController;
import '../../route.dart'
  show AppRoute;

part 'test.dart';
part 'route.dart';

class NotifyView extends GetView<NotifyController> {
  /// The notification page in app.
  const NotifyView({ Key? key }) : super(key: key);

  /// The route name or path root page or main page.
  /// that the embedder requested when the application
  /// was launched.
  ///
  /// This will be the string "/" if no particular route
  /// was requested.
  static const String routeName = '/notify';

  @override
  Widget build(BuildContext context) =>
    Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Notify View'),
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              'Notify',
              style: context.textTheme.headline6,
            ),
            TextButton(
              onPressed: () {
                Get.toNamed<Object>(
                  NotifyRoute.test,
                  id: AppRoute.notify.id);
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