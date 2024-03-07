import 'package:drinkup_app/blocs/water_progress/water_progress.dart';
import 'package:drinkup_app/constants/route_constants.dart';
import 'package:drinkup_app/services/active_page/active_page_service.dart';
import 'package:drinkup_app/services/size/size_service.dart';
import 'package:drinkup_app/utils/utils.dart';
import 'package:drinkup_app/screens/schemas/base.dart';
import 'package:drinkup_app/services/water_data/water_data_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:drinkup_app/blocs/config/config_bloc.dart';
import 'package:drinkup_app/screens/menu/drinkup_button.dart';
import 'package:drinkup_app/constants/constants.dart' as Constants;
import 'package:drinkup_app/constants/menu_constants.dart' as MenuConstants;
import 'dart:math' as math;
import 'package:drinkup_app/screens/menu/water_progress.dart';
import 'package:ionicons/ionicons.dart';
import 'package:drinkup_app/screens/menu/drinklistscroll.dart';
import 'progress_painter.dart';
import 'water_data.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() {
    return _MainScreenState();
  }
}

class _MainScreenState extends State<MainScreen>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late AnimationController _progressController;
  late AnimationController _stableController;
  /* late final ValueNotifier<bool> _menuActiveNotifier; */
  late final VoidCallback _menuActiveListener;
  late Animation<double> animation;
  final Tween<double> _animationTween = Tween(begin: 0.0, end: 0.0);
  /* late final List<DrinkListItem> bottles; */

  @override
  void initState() {
    /* bottles = generateWaterBottles(); */

    _progressController = AnimationController(
        vsync: this, duration: MenuConstants.kMenuProgressAnimationDuration);

    animation = _animationTween.animate(
      CurvedAnimation(
        parent: _progressController,
        curve: Curves.easeInOut,
      ),
    );
    _stableController = AnimationController(
        vsync: this, duration: MenuConstants.kMenuStableAnimationDuration)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _stableController.repeat(reverse: true);
        }
      });

    WidgetsBinding.instance
        .addPostFrameCallback((_) => _stableController.forward());

    _progressController.stop();

    _menuActiveListener = () {
      if (ActivePageService().activePage.value == Routes.menu.index) {
        _stableController.forward();
      } else {
        _stableController.stop();
      }
    };

    ActivePageService().activePage.addListener(_menuActiveListener);

    super.initState();
  }

  @override
  bool get wantKeepAlive {
    return true;
  }

  @override
  void dispose() {
    _progressController.dispose();
    _stableController.dispose();
    ActivePageService().activePage.removeListener(_menuActiveListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Stack(children: [
      Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: MenuConstants.kMenuBackgroundColors[
                      BlocProvider.of<ConfigBloc>(context)
                          .state
                          .config
                          .appTheme]!,
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0.0, 1.0]))),
      ScreenSchema(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAligment: MainAxisAlignment.spaceBetween,
          children: [
            Stack(
              children: [
                RepaintBoundary(
                  child: Container(
                    alignment: Alignment.center,
                    child: BlocBuilder<WaterProgressBloc, WaterProgressState>(
                        bloc: BlocProvider.of<WaterProgressBloc>(context),
                        builder: (context, state) {
                          if (state is WaterProgressLoaded) {
                            _progressController.reset();
                            _progressController.duration = Duration(
                                milliseconds: math.min(
                                    ((state.progress - state.oldProgress) * 100)
                                        .toInt(),
                                    MenuConstants
                                        .kMenuProgressMaxDurationInMilliseconds));
                            _animationTween.begin = state.oldProgress;
                            _animationTween.end = state.progress;
                            _progressController.forward();
                          }
                          return AnimatedBuilder(
                            animation: _progressController,
                            builder: (context, child) => Stack(
                              children: [
                                RepaintBoundary(
                                  child: CustomPaint(
                                    willChange: true,
                                    size: Size(SizeService().screenWidth,
                                        SizeService().screenHeight),
                                    painter: WaterProgressIndicator(
                                      colorTheme: Constants
                                          .ColorTheme.defaultbackground,
                                      theme:
                                          BlocProvider.of<ConfigBloc>(context)
                                              .state
                                              .config
                                              .appTheme,
                                      hasInitialBackground: false,
                                      bottomElevation: MenuConstants
                                              .kMenuProgressAnimationBottomPaddingFactor *
                                          SizeService().heightUnit,
                                      isCircular: false,
                                      Rvalue: animation.value,
                                      stableAnimationEnabled: true,
                                      stableController: _stableController,
                                      scale: 1,
                                      endPoint: state.progressEndpoint,
                                    ),
                                  ),
                                ),
                                Container(
                                  height: SizeService().screenHeight * 0.96,
                                  width: SizeService().screenWidth,
                                  alignment: Alignment.center,
                                  child: CustomPaint(
                                    size: Size(
                                        SizeService().screenWidth *
                                            MenuConstants
                                                .kMenuDropletAnimationWidthFactor,
                                        SizeService().screenHeight *
                                            MenuConstants
                                                .kMenuDropletAnimationHeightFactor),
                                    painter: WaterProgressIndicator(
                                      theme:
                                          BlocProvider.of<ConfigBloc>(context)
                                              .state
                                              .config
                                              .appTheme,
                                      isCircular: true,
                                      colorTheme: Constants
                                          .ColorTheme.defaultforeground,
                                      hasInitialBackground: true,
                                      isDroplet: true,
                                      backgroundColorIndex: 0,
                                      bottomElevation: MenuConstants
                                              .kMenuDropletAnimationBottomPaddingFactor *
                                          SizeService().heightUnit,
                                      stableAnimationEnabled: false,
                                      Rvalue: animation.value,
                                      scale: MenuConstants
                                          .kMenuDropletAnimationScaleFactor,
                                      endPoint:
                                          /* (state.progress / 100).floor() * 100 +
                                                100 */
                                          state.progress,
                                      backgroundColor: MenuConstants
                                              .kMenuDropletAnimationBackgroundColor[
                                          BlocProvider.of<ConfigBloc>(context)
                                              .state
                                              .config
                                              .appTheme]!,
                                    ),
                                  ),
                                ),
                                CustomPaint(
                                  size: Size(SizeService().screenWidth,
                                      SizeService().screenHeight),
                                  painter: ProgressPainter(
                                    theme: BlocProvider.of<ConfigBloc>(context)
                                        .state
                                        .config
                                        .appTheme,
                                    dataTopMargin: SizeService().screenHeight *
                                        MenuConstants
                                            .kMenuProgressPainterTextTopMarginFactor,
                                    target: state.target,
                                    amount: state.current,
                                    value: animation.value,
                                    animationController: _progressController,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                  ),
                ), ////
                SizedBox(
                  height: SizeService().screenHeight,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        MenuWaterData(),
                        Container(
                          margin: MenuConstants.kMenuAddWaterButtonMargin,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const DrinkUpButton(),
                              /* const DrinkListScroll(), */
                              /* RepaintBoundary(
                                  child: DrinkList(
                                    /* borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                bottomLeft: Radius.circular(10)), */
                                  
                                    height: 96,
                                    backgroundColor: Color.fromARGB(0, 63, 26, 26),
                                    /* margin:
                                const EdgeInsets.only(left: 4, right: 4 + 10, bottom: 0), */
                                    margin: const EdgeInsets.fromLTRB(
                                        0, 0, /* 55 */ 0, 54),
                                    items: bottles,
                                    marginBetweenItems: 4,
                                  ),
                                ), */
                            ],
                          ),
                        ),

                        /* SizedBox(
                            height: 50,
                          ), */
                        /* Container(
                      /* color: Color.fromARGB(255, 22, 0, 145), */
                      height: MenuScreenConstants.drinkListHeight,
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                      alignment: Alignment.centerRight,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 2,
                              height: MenuScreenConstants.drinkListItemHeight - 1,
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 240, 240, 240),
                                  borderRadius: BorderRadius.circular(30)),
                            ),
                            /* const SizedBox(
                              width: 4,
                            ), */
                            const SizedBox(
                                width: 50,
                                child: /* Icon(
                                  Icons.arrow_forward_ios,
                                  size: 12,
                                  color: Color.fromARGB(255, 0, 253, 21),
                                  weight: 20,
                                ) */
                                    Padding(
                                        padding: EdgeInsets.only(left: 5),
                                        child: Text(
                                          "See\nMore",
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontFamily: 'Nexa',
                                              fontWeight: FontWeight.w900,
                                              color: Color.fromARGB(
                                                  255, 114, 114, 114)),
                                        ))),
                          ])), */
                      ]),
                ),
              ],
            ),
          ]),
    ]);
  }

  /* List<DrinkListItem> generateWaterBottles() {
    List<DrinkListItem> containers = [];

    for (int i = 0; i < 20; i++) {
      containers.add(DrinkListItem(
        width: 74,
        /* margin: EdgeInsets.all(3), */
        height: 80,
        padding: const EdgeInsets.all(5),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        mainAxisAligment: MainAxisAlignment.spaceEvenly,
        titleColor: const Color.fromARGB(255, 255, 255, 255),
        /* borderRadius: BorderRadius.only(
            topRight: Radius.circular(6),
            topLeft: Radius.circular(6),
            bottomLeft: Radius.circular(6),
            bottomRight: Radius.circular(6)), */

        borderRadius: BorderRadius.circular(4),
        titleFontWeight: FontWeight.w900,
        /* border: /* Border(
            top: BorderSide(
                color: Color.fromARGB(255, 185, 185, 185), width: 0.1),
            left: BorderSide(
                color: Color.fromARGB(255, 160, 160, 160), width: 0.1),
            bottom: BorderSide(
                color: Color.fromARGB(255, 160, 160, 160), width: 0.1)) */
            Border.all(color: Color.fromARGB(250, 214, 214, 214), width: 0), */
        title: "${300 + i * 10} ml",
        onTap: () {
          BlocProvider.of<WaterProgressBloc>(context)
              .add(WaterProgressIncreased(amount: 300 + i * 10));
        },
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              generateRandomWhitishColor(
                  opacity: 1, start: 250, preference: 2, prominance: 0.5),
              generateRandomWhitishColor(
                  opacity: 1, start: 150, preference: 2, prominance: 0.5),

              /* Color.fromARGB(0, 1, 81, 255),
              Color.fromARGB(0, 71, 0, 129), */
            ]),
        titleFontSize: 11,
        titleFontFamily: 'Nexa',
        label: "${300 + i * 10} ml",
        labelColor: const Color.fromARGB(255, 41, 41, 41),
        labelFontWeight: FontWeight.w700,
        spaceBetweenElements: 3,
        labelFontSize: 9,
        boxShadow: const [
          /* BoxShadow(
              offset: Offset(3, 3),
              color: Color.fromARGB(255, 240, 240, 240),
              blurRadius: 10) */
        ],
      ));
    }

    /* for (int i = 0; i < 20; i++) {
      containers.add();
    } */
    return containers;
  } */
}
