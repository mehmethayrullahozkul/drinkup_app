import 'dart:math';

import 'package:drinkup_app/blocs/config/config_bloc.dart';
import 'package:drinkup_app/repositories/data/data_repository.dart';
import 'package:drinkup_app/screens/history/history.dart';
import 'package:drinkup_app/screens/profile/profile_items.dart';
import 'package:drinkup_app/services/active_page/active_page_service.dart';
import 'package:drinkup_app/services/size/size_service.dart';
import 'package:drinkup_app/services/water_data/water_data_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ionicons/ionicons.dart';
import 'package:drinkup_app/screens/schemas/restart.dart';
import 'package:drinkup_app/constants/constants.dart' as Constants;
import 'package:flutter/material.dart';
import 'package:drinkup_app/constants/route_constants.dart';
import 'package:drinkup_app/screens/menu/menu.dart';
import 'package:flutter_lazy_indexed_stack/flutter_lazy_indexed_stack.dart';
import 'package:drinkup_app/screens/progress/progress.dart';
import 'package:drinkup_app/screens/profile/profile.dart';
import 'package:drinkup_app/screens/settings/settings.dart';
import 'package:drinkup_app/blocs/water_progress/water_progress.dart';
import 'package:drinkup_app/blocs/drinklist/drinklist.dart';
import 'bottom_nav_bar.dart';

class MainSchema extends StatefulWidget {
  const MainSchema({super.key});

  @override
  State<MainSchema> createState() => _MainSchemaState();
}

class _MainSchemaState extends State<MainSchema> with TickerProviderStateMixin {
  int currentPageIndex = /* RouteIndexes.menu; */ Routes.progress.index;
  PageIndexNotifier pageIndexNotifier =
      PageIndexNotifier(Routes.progress.index);

  late AnimationController fadeController;
  late Animation<double> fadeAnimation;
  /* late WaterDataService waterDataService; */

  @override
  void initState() {
    Constants.developerLog("STATUS: MainSchema init started");

    fadeController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200))
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) fadeController.reset();
      });

    fadeAnimation = TweenSequence(
      <TweenSequenceItem<double>>[
        TweenSequenceItem<double>(
          tween:
              Tween(begin: 1.0, end: 0.7).chain(CurveTween(curve: Curves.ease)),
          weight: 1.0,
        ),
        TweenSequenceItem<double>(
          tween: Tween(begin: 0.7, end: 1.0)
              .chain(CurveTween(curve: Curves.easeInOut)),
          weight: 99.0,
        ),
      ],
    ).animate(fadeController);

    /*  Tween<double>(begin: 0.6, end: 1).animate(
        CurvedAnimation(parent: fadeController, curve: Curves.easeInOut)); */

    super.initState();
    Constants.developerLog("STATUS: MainSchema init finished");
    WidgetsBinding.instance.addPostFrameCallback(
        (_) => Constants.developerLog("STATUS: MainSchema build finished"));
  }

  @override
  void dispose() {
    fadeController.dispose();
    super.dispose();
  }

  /* controller.animateToPage(currentPageIndex,
        duration: const Duration(milliseconds: 500), curve: Curves.ease); */
  //final Widget child;
  @override
  Widget build(BuildContext context) {
    Constants.developerLog("STATUS: MainSchema build started");

    if (/* size.height >= size.width */ true) {
      // "Portrait" / "mobile" mode.
      return RestartWidget(
        child: BlocConsumer<ConfigBloc, ConfigState>(
          listener: (context, state) {
            RestartWidget.restartApp(context);
          },
          builder: (context, state) {
            return Scaffold(
              resizeToAvoidBottomInset: false,
              /* appBar: PreferredSize(
                preferredSize: Size.fromHeight(120),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: Constants.kAppBarBackgroundColor[
                            BlocProvider.of<ConfigBloc>(context)
                                .state
                                .config
                                .appTheme]!),
                    boxShadow: [
                      BoxShadow(
                        color: Constants.kAppBarShadowColor,
                        blurRadius: Constants.kAppBarShadowBlurRadiusFactor *
                            SizeService().heightUnit,
                      )
                    ],
                  ),
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).padding.top +
                          SizeService().heightUnit *
                              Constants.kAppBarOuterPaddingTopFactor,
                      bottom: SizeService().heightUnit *
                          Constants.kAppBarOuterPaddingBottomFactor,
                      left: SizeService().widthUnit *
                          Constants.kAppBarOuterPaddingHorizontalFactor,
                      right: SizeService().widthUnit *
                          Constants.kAppBarOuterPaddingHorizontalFactor),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                          padding: EdgeInsets.only(
                              left: SizeService().widthUnit *
                                  Constants.kAppBarTitleLeftPaddingFactor),
                          child: Text(
                            Constants.kAppBarTitle[
                                BlocProvider.of<ConfigBloc>(context)
                                    .state
                                    .config
                                    .language]!,
                            style: TextStyle(
                              color: Constants.kAppBarTitleColor,
                              fontFamily: Constants.kAppBarTitleFontFamily,
                              fontSize: Constants.kAppBarTitleFontSizeFactor *
                                  SizeService().fontSize,
                              fontWeight: Constants.kAppBarTitleFontWeight,
                            ),
                          )),
                      Container(
                        padding: EdgeInsets.only(
                            right: SizeService().widthUnit *
                                Constants.kAppBarIconRightPaddingFactor),
                        child: InkWell(
                          onTap: () {
                            GoRouter.of(context)
                                .pushNamed(Routes.settings.name);
                          },
                          child: Icon(
                            Constants.kAppBarIcon,
                            size: Constants.kAppBarIconSizeFactor *
                                SizeService().iconSize,
                            color: Constants.kAppBarIconColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ), */
              extendBody: true,
              extendBodyBehindAppBar: true,
              backgroundColor:
                  Constants.kMainBackgroundColor[state.config.appTheme],
              bottomNavigationBar: ValueListenableBuilder<int>(
                  valueListenable: pageIndexNotifier,
                  builder: (context, index, child) {
                    return BottomNavBar(
                        startIndex: index,
                        onChange: (index) async {
                          if (index == currentPageIndex) return;

                          currentPageIndex = index;
                          ActivePageService().setActivePage(index);
                          /* fadeController.reset(); */
                          fadeController.forward();
                          pageIndexNotifier.setPageIndex(index);
                        },
                        /* border: Border(
                              top: BorderSide(
                                  color: Color.fromARGB(255, 255, 255, 255), width: .1)), */
                        /* selectedColor: Color.fromARGB(255, 10, 10, 10),
                          unselectedColor: Color.fromARGB(255, 36, 36, 36), */

                        selectedColor:
                            Constants.kBottomNavigationBarSelectedIconColor,
                        unselectedColor:
                            Constants.kBottomNavigationBarUnselectedIconColor,
                        backgroundColor: (index == Routes.menu.index)
                            ? const Color.fromARGB(0, 255, 0, 0)
                            : Constants.kBottomNavigationBarBackgroundColor[
                                BlocProvider.of<ConfigBloc>(context)
                                    .state
                                    .config
                                    .appTheme]!,
                        /* (index ==
                                  RouteIndexes
                                      .menu /* ||
                                      index == RouteIndexes.settings */
                              )
                              ? */

                        /* : Constants.kBottomNavigationBarBackgroundColor[
                                  BlocProvider.of<ConfigBloc>(context)
                                      .state
                                      .config
                                      .appTheme]!, */

                        iconSize: Constants.kBottomNavigationBarIconSizeFactor *
                            SizeService().iconSize,
                        labelFontWeight:
                            Constants.kBottomNavigationBarFontWeight,
                        labelSize:
                            Constants.kBottomNavigationBarLabelFontSizeFactor *
                                SizeService().fontSize,
                        /*  showLabel: false, */
                        labelFontFamily:
                            Constants.kBottomNavigationBarFontFamily,
                        spaceBetweenLabelAndIcon:
                            Constants.kBottomNavigationSpaceBetweenItemsFactor *
                                SizeService().heightUnit,
                        height: SizeService().heightUnit *
                            Constants.kBottomNavigationBarHeightFactor,
                        items: List.generate(
                            Constants
                                .kBottomNavigationBarRoutes[state.config.language]!
                                .length, (index) {
                          return BottomNavBarItem(
                            icon: (index == currentPageIndex)
                                ? Constants.kBottomNavigationBarRoutes[state
                                    .config.language]![index]["iconFilled"]!
                                : Constants.kBottomNavigationBarRoutes[state
                                    .config.language]![index]["iconOutlined"]!,
                            label: Constants.kBottomNavigationBarRoutes[
                                state.config.language]![index]["label"]!,
                          );
                        }));
                  }),
              body: DefaultTextStyle(
                style: TextStyle(
                    fontSize: SizeService().fontSize,
                    fontWeight: FontWeight.w300,
                    color: Colors.black,
                    fontFamily: 'Sofia-Pro'),
                child: ValueListenableBuilder<int>(
                  valueListenable: pageIndexNotifier,
                  builder: (context, index, child) {
                    print("IndexedStack building again");
                    print('index: $index');
                    return AnimatedBuilder(
                      animation: fadeAnimation,
                      builder: (context, child) {
                        return LazyIndexedStack(
                          index: index,
                          children: const [
                            MainScreen(),
                            HistoryScreen(),
                            ProgressScreen(),
                            ProfileScreen(),
                          ],
                        );
                      },
                    );
                  },
                ),
              ),
            );
          },
        ),
      );
    }
  }
}

class PageIndexNotifier extends ValueNotifier<int> {
  PageIndexNotifier(super.value);

  void setPageIndex(int index) async {
    value = index;
  }
}
