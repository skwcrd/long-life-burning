library view.event;

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../controllers/controllers.dart'
  show AppController;
import '../views.dart'
  show AppRoute;

part 'test.dart';
part 'route.dart';

class EventView extends GetView<AppController> {
  /// The event page in app.
  const EventView({ Key? key }) : super(key: key);

  /// The route name or path root page or main page.
  /// that the embedder requested when the application
  /// was launched.
  ///
  /// This will be the string "/" if no particular route
  /// was requested.
  static const String routeName = '/event';

  @override
  Widget build(BuildContext context) =>
    Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Event View'),
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              'Event',
              style: context.textTheme.headline6,
            ),
            TextButton(
              onPressed: () {
                Get.toNamed<Object>(
                  EventRoute.test,
                  id: AppRoute.event.id);
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