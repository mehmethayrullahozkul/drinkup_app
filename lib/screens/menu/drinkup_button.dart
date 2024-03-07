import 'package:drinkup_app/constants/route_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:drinkup_app/constants/menu_constants.dart' as MenuConstants;
import 'package:drinkup_app/blocs/config/config_bloc.dart';
import 'package:drinkup_app/blocs/water_progress/water_progress_bloc.dart';

import 'package:drinkup_app/services/size/size_service.dart';
import 'package:go_router/go_router.dart';

class DrinkUpButton extends StatelessWidget {
  const DrinkUpButton();

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        /*  */
        child: Container(
          alignment: Alignment.center,
          /* clipBehavior: Clip.hardEdge, */
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(SizeService().heightUnit *
                  MenuConstants.kMenuAddWaterButtonRadiusFactor),
              color: MenuConstants.kMenuAddWaterButtonBackgroundColor[
                  BlocProvider.of<ConfigBloc>(context).state.config.appTheme]!,
              boxShadow: MenuConstants.kMenuAddWaterButtonBoxShadow),
          width: SizeService().widthUnit *
              MenuConstants.kMenuAddWaterButtonWidthFactor,
          height: SizeService().heightUnit *
              MenuConstants.kMenuAddWaterButtonHeightFactor,
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                /* BlocProvider.of<WaterProgressBloc>(context)
                    .add(const WaterProgressIncreased(amount: 200)); */
                /* GoRouter.of(context).pushNamed(
                  'addwater',
                  extra: BlocProvider.of<WaterProgressBloc>(context),
                ); */
                GoRouter.of(context).pushNamed(Routes.addWaterDialog.name);
              },
              child: SizedBox.expand(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: SizeService().heightUnit *
                            MenuConstants.kMenuAddWaterButtonLabelHeightFactor,
                        alignment: Alignment.center,
                        child: Text(
                          MenuConstants.kMenuAddWaterButtonLabel[
                              BlocProvider.of<ConfigBloc>(context)
                                  .state
                                  .config
                                  .language]!,
                          style: TextStyle(
                              fontSize: SizeService().fontSize *
                                  MenuConstants
                                      .kMenuAddWaterButtonLabelFontSizeFactor,
                              fontFamily: MenuConstants
                                  .kMenuAddWaterButtonLabelFontFamily,
                              fontWeight: MenuConstants
                                  .kMenuAddWaterButtonLabelFontWeight,
                              color:
                                  MenuConstants.kMenuAddWaterButtonLabelColor[
                                      BlocProvider.of<ConfigBloc>(context)
                                          .state
                                          .config
                                          .appTheme]),
                        ),
                      ),
                      /* SizedBox(
                                                    width: 10,
                                                  ),
                                                  Container(
                                                    height: 30,
                                                    width: 30,
                                                    margin: EdgeInsets.fromLTRB(
                                                        0, 0, 0, 0),
                                                    child: Icon(
                                                      Ionicons.add,
                                                      size: 20,
                                                      color: Color.fromARGB(
                                                          255, 41, 41, 41),
                                                    ),
                                                  ), */
                    ]),
              ),
            ),
          ),
        ));
  }
}
