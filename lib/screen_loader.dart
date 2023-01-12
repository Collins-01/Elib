import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:elib/feature/dashboard/screens/dashboard.dart';
import 'package:elib/helpers/components/app_icon.dart';
import 'package:elib/helpers/navigators.dart';
import 'package:elib/helpers/page_layout/page_layout.dart';

class ScreenLoader extends ConsumerStatefulWidget {
  const ScreenLoader({Key? key}) : super(key: key);

  @override
  ConsumerState<ScreenLoader> createState() => _ScreenLoaderState();
}

class _ScreenLoaderState extends ConsumerState<ScreenLoader> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Timer(
        Duration(seconds: 2),
        () => {
              nextPageNoPop(context, (context) => Dashboard()),
            });
  }

  @override
  Widget build(BuildContext context) {
    // final req = ref.watch(userFutureProvider(context));
    return const Material(
      color: Colors.white,
      child: ScreensLoaderChild(),
      // child: req.when(
      //   data: (data) {
      //     // final value = data.data;
      //     // print("===Jcole===");

      //     // final userData = UserModel.fromJson(value['fetchUserProfile']);
      //     // print(userData.toJson());
      //     // // print(userData.toJson());
      //     // ref.read(userModelNotifier.notifier).updateUser(userData);
      //     // nextPageNoPop(context, (context) => Dashboard());
      //     return Dashboard();
      //   },
      //   error: (err, stackTrace) => const ErrorPageWidget(),
      //   loading: () => const ScreensLoaderChild(),
      // ),
    );
  }
}

class ScreensLoaderChild extends StatelessWidget {
  const ScreensLoaderChild({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageLayout(
        noAppBar: true,
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          const Expanded(child: Text("")),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [AppIcon()],
          ),
          const SizedBox(
            height: 10.0,
          ),
          Center(child: SizedBox(width: 100.0, child: LinearLineLoader())),
          const Expanded(child: Text("")),
        ]));
  }
}

class LinearLineLoader extends StatefulWidget {
  @override
  State<LinearLineLoader> createState() => _LinearLineLoaderState();
}

/// AnimationControllers can be created with
/// vsync: this` because of TickerProviderStateMixin.
class _LinearLineLoaderState extends State<LinearLineLoader>
    with TickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..addListener(() {
        setState(() {});
      });
    controller.repeat(reverse: true);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(
      value: controller.value,
      minHeight: 1.5,
      // semanticsLabel: 'Linear progress indicator',
    );
  }
}
