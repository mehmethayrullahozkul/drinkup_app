import 'package:drinkup_app/models/water_data/water_data_model.dart';
import 'package:drinkup_app/utils/utils.dart';
import 'package:drinkup_app/screens/schemas/base.dart';
import 'package:drinkup_app/services/water_data/water_data_service.dart';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:drinkup_app/constants/constants.dart' as Constants;
import 'package:drinkup_app/screens/paints/radial_progress.dart';

import 'package:drinkup_app/models/water_unit/water_unit_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:drinkup_app/services/size/size_service.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:drinkup_app/constants/progress_constants.dart'
    as ProgressConstants;
import 'package:drinkup_app/blocs/water_progress/water_progress_bloc.dart';
import 'package:drinkup_app/blocs/config/config_bloc.dart';
import 'package:go_router/go_router.dart';

class ProgressScreen extends StatefulWidget {
  const ProgressScreen({super.key});

  @override
  State<ProgressScreen> createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreen>
    with TickerProviderStateMixin {
  late List<WaterUnit24Hour> waterUnits;
  late WaterData? waterData;
  late AnimationController _radialProgressAnimationController;
  late Animation<double> animation;
  late Tween<double> _animationTween = Tween<double>(begin: 0, end: 0);
  late Future<bool> _refreshFuture;
  int dataCount = 0;
  /*  Widget svg = SvgPicture.asset(
    'assets/images/bg-t1/blue-purple-bg-1.svg',
    semanticsLabel: 'Acme Logo',
    fit: BoxFit.cover,
  ); */

  Future<bool> _refreshPage() async {
    await RepositoryProvider.of<WaterDataService>(context).refresh();
    waterUnits =
        RepositoryProvider.of<WaterDataService>(context).getUnitsBy24Hour();
    waterData = RepositoryProvider.of<WaterDataService>(context).data;
    _animationTween = Tween<double>(begin: 0, end: waterData!.progress);
    /* _radialProgressAnimationController.forward(); */
    return true;
  }

  @override
  void initState() {
    _refreshFuture = _refreshPage();
    _radialProgressAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    animation = _animationTween.animate(
      CurvedAnimation(
        parent: _radialProgressAnimationController,
        curve: Curves.easeInOut,
      ),
    );
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback(
        (_) => _radialProgressAnimationController.forward());
  }

  @override
  void dispose() {
    _radialProgressAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
        future: _refreshFuture,
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.hasData) {
            animation = _animationTween.animate(
              CurvedAnimation(
                parent: _radialProgressAnimationController,
                curve: Curves.easeInOut,
              ),
            );
            return BlocConsumer<WaterProgressBloc, WaterProgressState>(
                listener: (context, state) {
              _refreshPage();
            }, builder: (context, state) {
              return DecoratedBox(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: ProgressConstants.kProgressBackgroundColors[
                            BlocProvider.of<ConfigBloc>(context)
                                .state
                                .config
                                .appTheme]!)),
                child: SingleChildScrollView(
                  child: Column(children: [
                    // AppBar
                    Container(
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
                            blurRadius:
                                Constants.kAppBarShadowBlurRadiusFactor *
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
                                  fontSize:
                                      Constants.kAppBarTitleFontSizeFactor *
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
                                GoRouter.of(context).go('/settings');
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
                    Container(
                        padding: EdgeInsets.symmetric(
                            vertical: SizeService().heightUnit *
                                ProgressConstants
                                    .kProgressSectionOuterPaddingVerticalFactor,
                            horizontal: SizeService().widthUnit *
                                ProgressConstants
                                    .kProgressSectionOuterPaddingHorizontalFactor),
                        margin: EdgeInsets.only(
                          top: SizeService().heightUnit *
                              ProgressConstants
                                  .kProgressSectionOuterTopMarginFactor,
                          left: SizeService().widthUnit *
                              ProgressConstants
                                  .kProgressSectionOuterMarginHorizontalFactor,
                          right: SizeService().widthUnit *
                              ProgressConstants
                                  .kProgressSectionOuterMarginHorizontalFactor,
                        ),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: EdgeInsets.all(
                                  SizeService().widthUnit *
                                      ProgressConstants
                                          .kProgressSectionInnerPaddingFactor,
                                ),
                                decoration: BoxDecoration(
                                    color: ProgressConstants
                                        .kProgressSectionBackgroundColor,
                                    borderRadius: BorderRadius.circular(
                                        SizeService().heightUnit *
                                            ProgressConstants
                                                .kProgressSectionBorderRadiusFactor),
                                    border: Border.all(
                                        color: ProgressConstants
                                            .kProgressSectionBorderColor,
                                        width: SizeService().heightUnit *
                                            ProgressConstants
                                                .kProgressSectionBorderWidthFactor)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      child: Text(
                                          ProgressConstants
                                                  .kProgressProgressSectionTitle[
                                              BlocProvider.of<ConfigBloc>(
                                                      context)
                                                  .state
                                                  .config
                                                  .language]!,
                                          style: TextStyle(
                                            color: ProgressConstants
                                                .kProgressProgressSectionTitleColor,
                                            fontFamily: ProgressConstants
                                                .kProgressProgressSectionTitleFontFamily,
                                            fontSize: SizeService().fontSize *
                                                ProgressConstants
                                                    .kProgressProgressSectionTitleFontSizeFactor,
                                            fontWeight: ProgressConstants
                                                .kProgressProgressSectionTitleFontWeight,
                                          )),
                                    ),
                                    // Water Circle
                                    Container(
                                      alignment: Alignment.center,
                                      width: double.infinity,
                                      height: SizeService().heightUnit *
                                          ProgressConstants
                                              .kProgressProgressSectionCircleOuterSizeFactor,
                                      child: RepaintBoundary(
                                          child: AnimatedBuilder(
                                        animation:
                                            _radialProgressAnimationController,
                                        builder: (context, state) {
                                          return CustomPaint(
                                            size: Size(
                                                SizeService().heightUnit *
                                                    ProgressConstants
                                                        .kProgressProgressSectionCircleInnerSizeFactor,
                                                SizeService().heightUnit *
                                                    ProgressConstants
                                                        .kProgressProgressSectionCircleInnerSizeFactor),
                                            painter: RadialProgressPainter(
                                              strokeWidth: SizeService()
                                                      .heightUnit *
                                                  ProgressConstants
                                                      .kProgressProgressSectionCircleStrokeWidthFactor,
                                              target: waterData!.target,
                                              value: animation.value,
                                            ),
                                          );
                                        },
                                      )),
                                    ),
                                    // Water Data
                                    Container(
                                      alignment: Alignment.center,
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Expanded(
                                                child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                    ProgressConstants
                                                            .kProgressProgressSectionSubtitle[
                                                        BlocProvider.of<
                                                                    ConfigBloc>(
                                                                context)
                                                            .state
                                                            .config
                                                            .language]![0],
                                                    style: TextStyle(
                                                      color: ProgressConstants
                                                              .kProgressProgressSectionSubtitleColor[
                                                          BlocProvider.of<
                                                                      ConfigBloc>(
                                                                  context)
                                                              .state
                                                              .config
                                                              .appTheme],
                                                      fontFamily: ProgressConstants
                                                          .kProgressProgressSectionSubtitleFontFamily,
                                                      fontSize: SizeService()
                                                              .fontSize *
                                                          ProgressConstants
                                                              .kProgressProgressSectionSubtitleFontSizeFactor,
                                                      fontWeight: ProgressConstants
                                                          .kProgressProgressSectionSubtitleFontWeight,
                                                    )),
                                                SizedBox(
                                                  height: SizeService()
                                                          .heightUnit *
                                                      ProgressConstants
                                                          .kProgressProgressSectionSubtitleSpacingFactor,
                                                ),
                                                Container(
                                                  child: Text(
                                                      '${waterData!.target} ml',
                                                      style: TextStyle(
                                                        color: ProgressConstants
                                                                .kProgressProgressSectionValueColor[
                                                            BlocProvider.of<
                                                                        ConfigBloc>(
                                                                    context)
                                                                .state
                                                                .config
                                                                .appTheme]!,
                                                        fontFamily:
                                                            ProgressConstants
                                                                .kProgressProgressSectionValueFontFamily,
                                                        fontSize: SizeService()
                                                                .fontSize *
                                                            ProgressConstants
                                                                .kProgressProgressSectionValueFontSizeFactor,
                                                        fontWeight:
                                                            ProgressConstants
                                                                .kProgressProgressSectionValueFontWeight,
                                                      )),
                                                ),
                                              ],
                                            )),
                                            Expanded(
                                                child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                    ProgressConstants
                                                            .kProgressProgressSectionSubtitle[
                                                        BlocProvider.of<
                                                                    ConfigBloc>(
                                                                context)
                                                            .state
                                                            .config
                                                            .language]![1],
                                                    style: TextStyle(
                                                      color: ProgressConstants
                                                              .kProgressProgressSectionSubtitleColor[
                                                          BlocProvider.of<
                                                                      ConfigBloc>(
                                                                  context)
                                                              .state
                                                              .config
                                                              .appTheme],
                                                      fontFamily: ProgressConstants
                                                          .kProgressProgressSectionSubtitleFontFamily,
                                                      fontSize: SizeService()
                                                              .fontSize *
                                                          ProgressConstants
                                                              .kProgressProgressSectionSubtitleFontSizeFactor,
                                                      fontWeight: ProgressConstants
                                                          .kProgressProgressSectionSubtitleFontWeight,
                                                    )),
                                                SizedBox(
                                                  height: SizeService()
                                                          .heightUnit *
                                                      ProgressConstants
                                                          .kProgressProgressSectionSubtitleSpacingFactor,
                                                ),
                                                Container(
                                                  child: Text(
                                                      '${waterData!.amount} ml',
                                                      style: TextStyle(
                                                        color: ProgressConstants
                                                                .kProgressProgressSectionValueColor[
                                                            BlocProvider.of<
                                                                        ConfigBloc>(
                                                                    context)
                                                                .state
                                                                .config
                                                                .appTheme]!,
                                                        fontFamily:
                                                            ProgressConstants
                                                                .kProgressProgressSectionValueFontFamily,
                                                        fontSize: SizeService()
                                                                .fontSize *
                                                            ProgressConstants
                                                                .kProgressProgressSectionValueFontSizeFactor,
                                                        fontWeight:
                                                            ProgressConstants
                                                                .kProgressProgressSectionValueFontWeight,
                                                      )),
                                                ),
                                              ],
                                            )),
                                            Expanded(
                                                child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                    ProgressConstants
                                                            .kProgressProgressSectionSubtitle[
                                                        BlocProvider.of<
                                                                    ConfigBloc>(
                                                                context)
                                                            .state
                                                            .config
                                                            .language]![2],
                                                    style: TextStyle(
                                                      color: ProgressConstants
                                                              .kProgressProgressSectionSubtitleColor[
                                                          BlocProvider.of<
                                                                      ConfigBloc>(
                                                                  context)
                                                              .state
                                                              .config
                                                              .appTheme],
                                                      fontFamily: ProgressConstants
                                                          .kProgressProgressSectionSubtitleFontFamily,
                                                      fontSize: SizeService()
                                                              .fontSize *
                                                          ProgressConstants
                                                              .kProgressProgressSectionSubtitleFontSizeFactor,
                                                      fontWeight: ProgressConstants
                                                          .kProgressProgressSectionSubtitleFontWeight,
                                                    )),
                                                SizedBox(
                                                  height: SizeService()
                                                          .heightUnit *
                                                      ProgressConstants
                                                          .kProgressProgressSectionSubtitleSpacingFactor,
                                                ),
                                                Text(
                                                    '${math.max(waterData!.target - waterData!.amount, 0)} ml',
                                                    style: TextStyle(
                                                      color: ProgressConstants
                                                              .kProgressProgressSectionValueColor[
                                                          BlocProvider.of<
                                                                      ConfigBloc>(
                                                                  context)
                                                              .state
                                                              .config
                                                              .appTheme]!,
                                                      fontFamily: ProgressConstants
                                                          .kProgressProgressSectionValueFontFamily,
                                                      fontSize: SizeService()
                                                              .fontSize *
                                                          ProgressConstants
                                                              .kProgressProgressSectionValueFontSizeFactor,
                                                      fontWeight: ProgressConstants
                                                          .kProgressProgressSectionValueFontWeight,
                                                    )),
                                              ],
                                            )),
                                          ]),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                  height: SizeService().heightUnit *
                                      ProgressConstants
                                          .kProgressSectionBetweenSpacingFactor),
                              Container(
                                height: SizeService().heightUnit *
                                    ProgressConstants
                                        .kProgressSingleBoxHeightFactor,
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 6,
                                      child: Container(
                                        margin: EdgeInsets.only(
                                            right: SizeService().widthUnit *
                                                ProgressConstants
                                                    .kProgressSingleBoxHorizontalMarginFactor),
                                        padding: EdgeInsets.all(SizeService()
                                                .widthUnit *
                                            ProgressConstants
                                                .kProgressSingleBoxPaddingFactor),
                                        decoration: BoxDecoration(
                                            color: ProgressConstants
                                                .kProgressSingleBoxBackgroundColor,
                                            borderRadius: BorderRadius.circular(
                                                SizeService().widthUnit *
                                                    ProgressConstants
                                                        .kProgressSingleBoxBorderRadiusFactor),
                                            border: Border.all(
                                                color: ProgressConstants
                                                    .kProgressSingleBoxBorderColor,
                                                width: SizeService()
                                                        .heightUnit *
                                                    ProgressConstants
                                                        .kProgressSectionBorderWidthFactor)),
                                        child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                  ProgressConstants
                                                          .kProgressSingleBoxTitle[
                                                      BlocProvider.of<
                                                                  ConfigBloc>(
                                                              context)
                                                          .state
                                                          .config
                                                          .language]![0],
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: ProgressConstants
                                                        .kProgressSingleBoxTitleColor,
                                                    fontFamily: ProgressConstants
                                                        .kProgressSingleBoxTitleFontFamily,
                                                    fontSize: SizeService()
                                                            .fontSize *
                                                        ProgressConstants
                                                            .kProgressSingleBoxTitleFontSizeFactor,
                                                    fontWeight: ProgressConstants
                                                        .kProgressSingleBoxTitleFontWeight,
                                                  )),
                                              Text('1.5 L',
                                                  style: TextStyle(
                                                    color: ProgressConstants
                                                        .kProgressSingleBoxValueColor,
                                                    fontFamily: ProgressConstants
                                                        .kProgressSingleBoxValueFontFamily,
                                                    fontSize: SizeService()
                                                            .fontSize *
                                                        ProgressConstants
                                                            .kProgressSingleBoxValueFontSizeFactor,
                                                    fontWeight: ProgressConstants
                                                        .kProgressSingleBoxValueFontWeight,
                                                  )),
                                            ]),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 5,
                                      child: Container(
                                        padding: EdgeInsets.all(SizeService()
                                                .widthUnit *
                                            ProgressConstants
                                                .kProgressSingleBoxPaddingFactor),
                                        decoration: BoxDecoration(
                                            color: ProgressConstants
                                                .kProgressSingleBoxBackgroundColor,
                                            borderRadius: BorderRadius.circular(
                                                SizeService().widthUnit *
                                                    ProgressConstants
                                                        .kProgressSingleBoxBorderRadiusFactor),
                                            border: Border.all(
                                                color: ProgressConstants
                                                    .kProgressSingleBoxBorderColor,
                                                width: SizeService()
                                                        .heightUnit *
                                                    ProgressConstants
                                                        .kProgressSectionBorderWidthFactor)),
                                        child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                  ProgressConstants
                                                          .kProgressSingleBoxTitle[
                                                      BlocProvider.of<
                                                                  ConfigBloc>(
                                                              context)
                                                          .state
                                                          .config
                                                          .language]![1],
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: ProgressConstants
                                                        .kProgressSingleBoxTitleColor,
                                                    fontFamily: ProgressConstants
                                                        .kProgressSingleBoxTitleFontFamily,
                                                    fontSize: SizeService()
                                                            .fontSize *
                                                        ProgressConstants
                                                            .kProgressSingleBoxTitleFontSizeFactor,
                                                    fontWeight: ProgressConstants
                                                        .kProgressSingleBoxTitleFontWeight,
                                                  )),
                                              Text('9.3 L',
                                                  style: TextStyle(
                                                    color: ProgressConstants
                                                        .kProgressSingleBoxValueColor,
                                                    fontFamily: ProgressConstants
                                                        .kProgressSingleBoxValueFontFamily,
                                                    fontSize: SizeService()
                                                            .fontSize *
                                                        ProgressConstants
                                                            .kProgressSingleBoxValueFontSizeFactor,
                                                    fontWeight: ProgressConstants
                                                        .kProgressSingleBoxValueFontWeight,
                                                  )),
                                            ]),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 5,
                                      child: Container(
                                        margin: EdgeInsets.only(
                                            left: SizeService().widthUnit *
                                                ProgressConstants
                                                    .kProgressSingleBoxHorizontalMarginFactor),
                                        padding: EdgeInsets.all(SizeService()
                                                .widthUnit *
                                            ProgressConstants
                                                .kProgressSingleBoxPaddingFactor),
                                        decoration: BoxDecoration(
                                            color: ProgressConstants
                                                .kProgressSingleBoxBackgroundColor,
                                            borderRadius: BorderRadius.circular(
                                                SizeService().widthUnit *
                                                    ProgressConstants
                                                        .kProgressSingleBoxBorderRadiusFactor),
                                            border: Border.all(
                                                color: ProgressConstants
                                                    .kProgressSingleBoxBorderColor,
                                                width: SizeService()
                                                        .heightUnit *
                                                    ProgressConstants
                                                        .kProgressSectionBorderWidthFactor)),
                                        child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                  ProgressConstants
                                                          .kProgressSingleBoxTitle[
                                                      BlocProvider.of<
                                                                  ConfigBloc>(
                                                              context)
                                                          .state
                                                          .config
                                                          .language]![2],
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: ProgressConstants
                                                        .kProgressSingleBoxTitleColor,
                                                    fontFamily: ProgressConstants
                                                        .kProgressSingleBoxTitleFontFamily,
                                                    fontSize: SizeService()
                                                            .fontSize *
                                                        ProgressConstants
                                                            .kProgressSingleBoxTitleFontSizeFactor,
                                                    fontWeight: ProgressConstants
                                                        .kProgressSingleBoxTitleFontWeight,
                                                  )),
                                              Text('3 Days',
                                                  style: TextStyle(
                                                    color: ProgressConstants
                                                        .kProgressSingleBoxValueColor,
                                                    fontFamily: ProgressConstants
                                                        .kProgressSingleBoxValueFontFamily,
                                                    fontSize: SizeService()
                                                            .fontSize *
                                                        ProgressConstants
                                                            .kProgressSingleBoxValueFontSizeFactor,
                                                    fontWeight: ProgressConstants
                                                        .kProgressSingleBoxValueFontWeight,
                                                  )),
                                            ]),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                  height: SizeService().heightUnit *
                                      ProgressConstants
                                          .kProgressSectionBetweenSpacingFactor),
                              // 24 Hours Start
                              SizedBox(
                                width: double.infinity,
                                child: Container(
                                  padding: EdgeInsets.fromLTRB(12, 12, 12, 6),
                                  decoration: BoxDecoration(
                                      color: ProgressConstants
                                          .kProgressSingleBoxBackgroundColor,
                                      borderRadius: BorderRadius.circular(8)),
                                  /* margin: EdgeInsets.only(
                                          right: SizeService().widthUnit *
                                              ProgressConstants
                                                  .kProgressSingleBoxHorizontalMarginFactor *
                                              1), */
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        child: const Text('Last 24 Hours',
                                            style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 243, 243, 243),
                                              fontFamily: 'Sofia-Pro',
                                              fontSize: 13,
                                              fontWeight: FontWeight.w600,
                                            )),
                                      ),
                                      Container(
                                        alignment: Alignment.center,
                                        height: 120,
                                        margin: EdgeInsets.only(top: 20),
                                        decoration: BoxDecoration(
                                          color: Colors.transparent,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                        ),
                                        child: LineChart(LineChartData(
                                          minY: 0,
                                          minX: 1,
                                          maxY: 4000,
                                          gridData: FlGridData(
                                            show: true,
                                          ),
                                          titlesData: FlTitlesData(
                                            topTitles: AxisTitles(
                                              sideTitles:
                                                  SideTitles(showTitles: false),
                                            ),
                                            rightTitles: AxisTitles(
                                              sideTitles:
                                                  SideTitles(showTitles: false),
                                            ),
                                            leftTitles: AxisTitles(
                                              sideTitles: SideTitles(
                                                interval: 2000,
                                                reservedSize: 24,
                                                showTitles: true,
                                                getTitlesWidget: (value, meta) {
                                                  return SideTitleWidget(
                                                    space: 8,
                                                    axisSide: AxisSide.bottom,
                                                    child: Text(
                                                        meta.formattedValue,
                                                        style: TextStyle(
                                                            color: const Color
                                                                .fromARGB(255,
                                                                230, 230, 230),
                                                            fontSize: 10)),
                                                  );
                                                },
                                              ),
                                            ),
                                            bottomTitles: AxisTitles(
                                              axisNameSize: 13,
                                              axisNameWidget: Text(
                                                'Time',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 10,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                              sideTitles: SideTitles(
                                                  getTitlesWidget:
                                                      (value, meta) {
                                                    return SideTitleWidget(
                                                      space: 10,
                                                      axisSide: AxisSide.bottom,
                                                      child: Text(
                                                          meta.formattedValue,
                                                          style: TextStyle(
                                                              color: const Color
                                                                  .fromARGB(
                                                                  255,
                                                                  230,
                                                                  230,
                                                                  230),
                                                              fontSize: 10)),
                                                    );
                                                  },
                                                  interval: 4,
                                                  reservedSize: 24,
                                                  showTitles: true),
                                            ),
                                          ),
                                          borderData: FlBorderData(
                                              border: Border(
                                                  bottom: BorderSide(
                                                      color:
                                                          const Color.fromARGB(
                                                              68,
                                                              255,
                                                              255,
                                                              255),
                                                      width: 1),
                                                  left: BorderSide(
                                                      color:
                                                          const Color.fromARGB(
                                                              68,
                                                              255,
                                                              255,
                                                              255),
                                                      width: 1.2),
                                                  right: BorderSide(
                                                      color:
                                                          Colors.transparent),
                                                  top: BorderSide(
                                                      color:
                                                          Colors.transparent))),
                                          lineBarsData: [
                                            LineChartBarData(
                                              spots: List.generate(
                                                  waterUnits.length, (index) {
                                                return FlSpot(
                                                    waterUnits[index]
                                                        .hour
                                                        .toDouble(),
                                                    waterUnits[index]
                                                        .amount
                                                        .toDouble());
                                              }),
                                              isCurved: false,
                                              barWidth: 2,
                                              dotData: FlDotData(
                                                getDotPainter:
                                                    (p0, p1, p2, p3) {
                                                  return FlDotCirclePainter(
                                                    radius: 4,
                                                    color: Colors.white,
                                                    strokeWidth: 5,
                                                    strokeColor:
                                                        Colors.transparent,
                                                  );
                                                },
                                                checkToShowDot:
                                                    (spot, barData) {
                                                  return (spot.x % 4 == 0);
                                                },
                                              ),
                                              gradient: LinearGradient(
                                                begin: Alignment.topCenter,
                                                end: Alignment.bottomCenter,
                                                colors: [
                                                  Color.fromARGB(
                                                      255, 255, 255, 255),
                                                  Color.fromARGB(
                                                      255, 255, 255, 255),
                                                ],
                                              ),
                                              isStrokeCapRound: true,
                                              belowBarData: BarAreaData(
                                                  color: const Color.fromARGB(
                                                      59, 255, 255, 255),
                                                  show: true),
                                            ),
                                          ],
                                        )),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                  height: SizeService().heightUnit *
                                      ProgressConstants
                                          .kProgressSectionBetweenSpacingFactor),
                              SizedBox(
                                width: double.infinity,
                                child: Container(
                                  padding: EdgeInsets.fromLTRB(12, 12, 12, 6),
                                  decoration: BoxDecoration(
                                      color: ProgressConstants
                                          .kProgressSingleBoxBackgroundColor,
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        child: const Text('Last Week',
                                            style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 245, 245, 245),
                                              fontFamily: 'Sofia-Pro',
                                              fontSize: 13,
                                              fontWeight: FontWeight.w600,
                                            )),
                                      ),
                                      Container(
                                        alignment: Alignment.center,
                                        height: 120,
                                        margin: EdgeInsets.only(top: 14),
                                        decoration: BoxDecoration(
                                          color: Colors.transparent,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                        ),
                                        child: LineChart(LineChartData(
                                          minY: 0,
                                          minX: 1,
                                          maxY: 16000,
                                          gridData: FlGridData(
                                            show: true,
                                          ),
                                          titlesData: FlTitlesData(
                                            topTitles: AxisTitles(
                                              sideTitles:
                                                  SideTitles(showTitles: false),
                                            ),
                                            rightTitles: AxisTitles(
                                              sideTitles:
                                                  SideTitles(showTitles: false),
                                            ),
                                            leftTitles: AxisTitles(
                                              sideTitles: SideTitles(
                                                interval: 4000,
                                                reservedSize: 24,
                                                showTitles: true,
                                                getTitlesWidget: (value, meta) {
                                                  return SideTitleWidget(
                                                    space: 8,
                                                    axisSide: AxisSide.bottom,
                                                    child: Text(
                                                        meta.formattedValue,
                                                        style: TextStyle(
                                                            color: const Color
                                                                .fromARGB(255,
                                                                230, 230, 230),
                                                            fontSize: 10)),
                                                  );
                                                },
                                              ),
                                            ),
                                            bottomTitles: AxisTitles(
                                              axisNameSize: 13,
                                              axisNameWidget: Text(
                                                'Time',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 10,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                              sideTitles: SideTitles(
                                                  getTitlesWidget:
                                                      (value, meta) {
                                                    return SideTitleWidget(
                                                      space: 10,
                                                      axisSide: AxisSide.bottom,
                                                      child: Text(
                                                          meta.formattedValue,
                                                          style: TextStyle(
                                                              color: const Color
                                                                  .fromARGB(
                                                                  255,
                                                                  230,
                                                                  230,
                                                                  230),
                                                              fontSize: 10)),
                                                    );
                                                  },
                                                  interval: 4,
                                                  reservedSize: 24,
                                                  showTitles: true),
                                            ),
                                          ),
                                          borderData: FlBorderData(
                                              border: Border(
                                                  bottom: BorderSide(
                                                      color:
                                                          const Color.fromARGB(
                                                              68,
                                                              255,
                                                              255,
                                                              255),
                                                      width: 1),
                                                  left: BorderSide(
                                                      color:
                                                          const Color.fromARGB(
                                                              68,
                                                              255,
                                                              255,
                                                              255),
                                                      width: 1.2),
                                                  right: BorderSide(
                                                      color:
                                                          Colors.transparent),
                                                  top: BorderSide(
                                                      color:
                                                          Colors.transparent))),
                                          lineBarsData: [
                                            LineChartBarData(
                                              spots: List.generate(
                                                  waterUnits.length, (index) {
                                                return FlSpot(
                                                    waterUnits[index]
                                                        .hour
                                                        .toDouble(),
                                                    waterUnits[index]
                                                        .amount
                                                        .toDouble());
                                              }),
                                              isCurved: false,
                                              barWidth: 2,
                                              dotData: FlDotData(
                                                getDotPainter:
                                                    (p0, p1, p2, p3) {
                                                  return FlDotCirclePainter(
                                                    radius: 4,
                                                    color: Colors.white,
                                                    strokeWidth: 5,
                                                    strokeColor:
                                                        Colors.transparent,
                                                  );
                                                },
                                                checkToShowDot:
                                                    (spot, barData) {
                                                  return (spot.x % 4 == 0);
                                                },
                                              ),
                                              gradient: LinearGradient(
                                                begin: Alignment.topCenter,
                                                end: Alignment.bottomCenter,
                                                colors: [
                                                  Color.fromARGB(
                                                      255, 255, 255, 255),
                                                  Color.fromARGB(
                                                      255, 255, 255, 255),
                                                ],
                                              ),
                                              isStrokeCapRound: true,
                                              belowBarData: BarAreaData(
                                                  color: const Color.fromARGB(
                                                      59, 255, 255, 255),
                                                  show: true),
                                            ),
                                          ],
                                        )),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                  height: Constants
                                          .kBottomNavigationBarHeightFactor *
                                      SizeService().heightUnit),
                            ])),
                  ]),
                ),
              );
            });
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return const Center(child: Text('An error occurred'));
          }
        });
  }
}
