import 'package:flutter/material.dart';
// import 'package:elib/features/account/services/account_services.dart';
import 'package:elib/helpers/colors.dart';
import 'package:elib/helpers/page_layout/text_formating.dart';

class PageLayout extends StatefulWidget {
  const PageLayout(
      {super.key,
      this.appBarDrawerEnabled = false,
      this.noAppBar = false,
      this.child,
      this.title,
      this.titleTextColor = Colors.white,
      this.leadingNavIconColor = Colors.white,
      this.fontSize = 20,
      this.backOnPressed,
      this.appBarActions,
      this.appBarColor = bluePrimaryColor,
      this.scaffoldColor = Colors.white,
      this.scaffoldPadding = 26.0,
      this.bottomNavEnabled = false,
      this.navPop = true,
      this.appBarElevation = 0.1});

  final appBarActions;
  final Color appBarColor;
  final Color leadingNavIconColor;
  final bool appBarDrawerEnabled;
  final double appBarElevation;
  final Function? backOnPressed;
  final Widget? child;
  final double fontSize;
  final bool bottomNavEnabled, navPop;
  final bool noAppBar;
  final Color scaffoldColor;
  final double? scaffoldPadding;
  final String? title;
  final Color? titleTextColor;

  @override
  _PageLayoutState createState() => _PageLayoutState();
}

class _PageLayoutState extends State<PageLayout> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },

      child: widget.noAppBar
          ? Scaffold(
              key: widget.key,
              body: SafeArea(
                child: _loading
                    ? const Text("")
                    : Container(
                        color: widget.scaffoldColor,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: widget.scaffoldPadding!),
                          child: widget.child,
                        ),
                      ),
              ),
            )
          : Scaffold(
              key: widget.key,
              body: Container(
                color: widget.scaffoldColor,
                child: Column(
                  children: [
                    PhysicalModel(
                      color: widget.appBarColor,
                      elevation: widget.appBarElevation,
                      child: Container(
                        color: widget.appBarColor,
                        height: 100.0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const SizedBox(
                              height: 45.0,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Row(
                                children: [
                                  widget.navPop
                                      ? InkWell(
                                          child: SizedBox(
                                            width: 30.0,
                                            child: Icon(
                                              Icons.arrow_back_ios,
                                              color: widget.leadingNavIconColor,
                                            ),
                                          ),
                                          onTap: () =>
                                              Navigator.of(context).pop(),
                                        )
                                      : const SizedBox(
                                          width: 0,
                                        ),
                                  const SizedBox(
                                    width: 5.0,
                                  ),
                                  Expanded(
                                      child: Row(
                                    children: [
                                      Expanded(
                                        child: Text('${widget.title}',
                                            overflow: TextOverflow.ellipsis,
                                            style: textStyle.copyWith(
                                              fontSize: widget.fontSize,
                                              fontWeight: FontWeight.w500,
                                              color: widget.titleTextColor,
                                            )),
                                      ),
                                    ],
                                  )),
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: widget.appBarActions ?? [],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: widget.scaffoldPadding!),
                        child: _loading ? const Text("") : widget.child,
                      ),
                    ),
                  ],
                ),
              ),
            ),

      // ),
    );
  }

  final bool _loading = false;
}
