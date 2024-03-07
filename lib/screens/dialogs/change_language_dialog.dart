import 'package:carousel_slider/carousel_slider.dart';
import 'package:drinkup_app/blocs/water_progress/water_progress.dart';
import 'package:drinkup_app/screens/dialogs/dialog_schema.dart';
import 'package:drinkup_app/screens/menu/drinklistscroll.dart';
import 'package:drinkup_app/services/size/size_service.dart';
import 'package:drinkup_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:drinkup_app/screens/dialogs/dialog_page_wrap.dart';
import 'package:drinkup_app/blocs/config/config_bloc.dart';
import 'package:drinkup_app/models/config/config_model.dart';
import 'package:drinkup_app/constants/constants.dart';

class ChangeLanguageDialog extends StatefulWidget {
  final Key? key;
  final Offset? anchorPoint;
  final Color? barrierColor;
  final bool barrierDismissible;
  final String? barrierLabel;
  final bool useSafeArea;
  final CapturedThemes? themes;

  const ChangeLanguageDialog({
    this.key,
    this.anchorPoint,
    this.barrierColor = const Color.fromARGB(213, 255, 0, 0),
    this.barrierDismissible = true,
    this.barrierLabel,
    this.useSafeArea = true,
    this.themes,
  });

  @override
  _ChangeLanguageDialogState createState() => _ChangeLanguageDialogState();
}

class _ChangeLanguageDialogState extends State<ChangeLanguageDialog> {
  late Language selectedLanguage;

  void _onSelectedValueChange(int value) {
    setState(() {});
  }

  @override
  void initState() {
    selectedLanguage =
        BlocProvider.of<ConfigBloc>(context).state.config.language;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _onLanguageChange(Language language) {
    selectedLanguage = language;
    BlocProvider.of<ConfigBloc>(context).add(ConfigChanged(
        config: BlocProvider.of<ConfigBloc>(context)
            .state
            .config
            .copyWith(newLanguage: language)));
  }

  @override
  Widget build(BuildContext context) {
    return DialogSchema(
        width: SizeService().screenWidth * 0.7,
        title: 'Select Language',
        alignment: Alignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(vertical: 20),
            child: SizedBox(
              width: SizeService().screenWidth * 0.5,
              child: CarouselSlider(
                items: [
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Color.fromARGB(159, 146, 146, 146),
                          width: 0.2,
                        ),
                      ),
                    ),
                    child: Text(
                      'Default(English)',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: Color.fromARGB(255, 110, 110, 110),
                        fontFamily: 'Sofia-Pro',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    /* padding: EdgeInsets.symmetric(vertical: 10), */
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Color.fromARGB(159, 131, 131, 131),
                          width: 0.2,
                        ),
                      ),
                    ),
                    child: Text(
                      'English',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: Color.fromARGB(255, 110, 110, 110),
                        fontFamily: 'Sofia-Pro',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    /* padding: EdgeInsets.symmetric(vertical: 10), */
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Color.fromARGB(159, 136, 136, 136),
                          width: 0.2,
                        ),
                      ),
                    ),
                    child: Text(
                      'Türkçe',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: Color.fromARGB(255, 110, 110, 110),
                        fontFamily: 'Sofia-Pro',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
                options: CarouselOptions(
                  scrollPhysics: ClampingScrollPhysics(),
                  clipBehavior: Clip.none,
                  scrollDirection: Axis.vertical,
                  enableInfiniteScroll: false,
                  reverse: false,
                  enlargeCenterPage: true,
                  padEnds: false,
                  enlargeFactor: 0.6,
                  viewportFraction: 0.8,
                  aspectRatio: 2.0,
                  initialPage: 0,
                  height: 90,
                  autoPlay: false,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          // Buttons
          Container(
              width: double.infinity,
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    child: Text(
                      'Close',
                      style: TextStyle(
                        fontSize: 13,
                        color: Color.fromARGB(255, 34, 34, 34),
                        fontFamily: 'Gotham',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: SizeService().screenWidth * 0.3,
                  ),
                  Container(
                    child: Text(
                      'Save',
                      style: TextStyle(
                        fontSize: 13,
                        color: Color.fromARGB(255, 34, 34, 34),
                        fontFamily: 'Gotham',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  )
                ],
              ))
        ]);
  }
}
