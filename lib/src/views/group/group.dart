library view.group;

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../controllers/controllers.dart'
  show
    GroupBinding,
    GroupController;
import '../views.dart'
  show AppRoute;

part 'test.dart';
part 'route.dart';

class GroupView extends GetView<GroupController> {
  /// The group page in app.
  const GroupView({ Key? key }) : super(key: key);

  /// The route name or path root page or main page.
  /// that the embedder requested when the application
  /// was launched.
  ///
  /// This will be the string "/" if no particular route
  /// was requested.
  static const String routeName = '/group';

  @override
  Widget build(BuildContext context) =>
    Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Group View'),
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              'Group',
              style: context.textTheme.headline6,
            ),
            TextButton(
              onPressed: () {
                Get.toNamed<Object>(
                  GroupRoute.test,
                  id: AppRoute.group.id);
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