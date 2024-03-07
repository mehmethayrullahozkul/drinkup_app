import 'package:drinkup_app/blocs/config/config_bloc.dart';
import 'package:drinkup_app/services/size/size_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:drinkup_app/constants/constants.dart' as Constants;
import 'package:drinkup_app/constants/menu_constants.dart' as MenuConstants;
import 'package:drinkup_app/utils/utils.dart' as Utils;
import 'dart:math' show max;

import 'package:drinkup_app/blocs/water_progress/water_progress_bloc.dart';

class MenuWaterData extends StatefulWidget {
  Color color = const Color.fromARGB(255, 2, 0, 10);
  @override
  _MenuWaterDataState createState() => _MenuWaterDataState();

  MenuWaterData({super.key});
}

class _MenuWaterDataState extends State<MenuWaterData> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          top: MenuConstants.kMenuWaterDataTopMarginFactor *
              SizeService().heightUnit),
      alignment: Alignment.center,
      child: Container(
        height:
            MenuConstants.kMenuWaterDataHeightFactor * SizeService().heightUnit,
        width:
            SizeService().screenWidth * MenuConstants.kMenuWaterDataWidthFactor,
        child: BlocBuilder<WaterProgressBloc, WaterProgressState>(
            buildWhen: (previous, current) => current is WaterProgressLoaded,
            bloc: BlocProvider.of<WaterProgressBloc>(context),
            builder: (context, state) {
              widget.color = Utils.getMenuTextColorByProgress(state.progress,
                  BlocProvider.of<ConfigBloc>(context).state.config.appTheme);

              return Row(
                children: [
                  Expanded(
                    flex: MenuConstants.kMenuWaterDataItemFlexes[0],
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            MenuConstants.kMenuWaterDataTitles[
                                BlocProvider.of<ConfigBloc>(context)
                                    .state
                                    .config
                                    .language]![0],
                            style: TextStyle(
                                color: widget.color,
                                fontSize: MenuConstants
                                        .kMenuWaterDataTitleFontSizeFactor *
                                    SizeService().fontSize,
                                fontFamily:
                                    MenuConstants.kMenuWaterDataTitleFontFamily,
                                fontWeight: MenuConstants
                                    .kMenuWaterDataTitleFontWeight),
                          ),
                          SizedBox(
                            height: MenuConstants.kMenuWaterDataSpacingFactor *
                                SizeService().heightUnit,
                          ),
                          Text(
                            state.target.toString(),
                            style: TextStyle(
                                color: widget.color,
                                fontSize: MenuConstants
                                        .kMenuWaterDataValueFontSizeFactor *
                                    SizeService().fontSize,
                                fontFamily:
                                    MenuConstants.kMenuWaterDataValueFontFamily,
                                fontWeight: MenuConstants
                                    .kMenuWaterDataValueFontWeight),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: MenuConstants.kMenuWaterDataItemFlexes[1],
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            MenuConstants.kMenuWaterDataTitles[
                                BlocProvider.of<ConfigBloc>(context)
                                    .state
                                    .config
                                    .language]![1],
                            style: TextStyle(
                                color: widget.color,
                                fontSize: MenuConstants
                                        .kMenuWaterDataTitleFontSizeFactor *
                                    SizeService().fontSize,
                                fontFamily:
                                    MenuConstants.kMenuWaterDataTitleFontFamily,
                                fontWeight: MenuConstants
                                    .kMenuWaterDataTitleFontWeight),
                          ),
                          SizedBox(
                            height: MenuConstants.kMenuWaterDataSpacingFactor *
                                SizeService().heightUnit,
                          ),
                          Text(
                            state.current.toString(),
                            style: TextStyle(
                                color: widget.color,
                                fontSize: MenuConstants
                                        .kMenuWaterDataValueFontSizeFactor *
                                    SizeService().fontSize,
                                fontFamily:
                                    MenuConstants.kMenuWaterDataValueFontFamily,
                                fontWeight: MenuConstants
                                    .kMenuWaterDataValueFontWeight),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: MenuConstants.kMenuWaterDataItemFlexes[2],
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            MenuConstants.kMenuWaterDataTitles[
                                BlocProvider.of<ConfigBloc>(context)
                                    .state
                                    .config
                                    .language]![2],
                            style: TextStyle(
                                color: widget.color,
                                fontSize: MenuConstants
                                        .kMenuWaterDataTitleFontSizeFactor *
                                    SizeService().fontSize,
                                fontFamily:
                                    MenuConstants.kMenuWaterDataTitleFontFamily,
                                fontWeight: MenuConstants
                                    .kMenuWaterDataTitleFontWeight),
                          ),
                          SizedBox(
                            height: MenuConstants.kMenuWaterDataSpacingFactor *
                                SizeService().heightUnit,
                          ),
                          Text(
                            max(state.target - state.current, 0).toString(),
                            style: TextStyle(
                                color: widget.color,
                                fontSize: MenuConstants
                                        .kMenuWaterDataValueFontSizeFactor *
                                    SizeService().fontSize,
                                fontFamily:
                                    MenuConstants.kMenuWaterDataValueFontFamily,
                                fontWeight: MenuConstants
                                    .kMenuWaterDataValueFontWeight),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }),
      ),
    );
  }
}
