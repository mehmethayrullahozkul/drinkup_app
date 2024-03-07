import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:drinkup_app/blocs/config/config_bloc.dart';
import 'package:drinkup_app/models/config/config_model.dart';
import 'package:drinkup_app/constants/constants.dart';

class CustomDialog<T> extends Page<T> {
  final Offset? anchorPoint;
  final Color? barrierColor;
  final bool barrierDismissible;
  final String? barrierLabel;
  final bool useSafeArea;
  final CapturedThemes? themes;

  // Define the builder function directly inside the class
  final WidgetBuilder builder = (BuildContext context) {
    return /* AlertDialog(
      title: Text('Dialog Title'),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text('Dialog content goes here...'),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            // Action to perform when the first button is pressed.
          },
          child: Text('Button 1'),
        ),
        TextButton(
          onPressed: () {
            // Action to perform when the second button is pressed.
          },
          child: Text('Button 2'),
        ),
      ],
    ); */
        Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: Container(
        width: 300, // Adjust width as needed
        padding: EdgeInsets.all(20),
        /* color: Colors.white, */ // Dialog background color
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Dialog Title',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Dialog content goes here...',
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                  onPressed: () {
                    // Action to perform when the first button is pressed.
                    BlocProvider.of<ConfigBloc>(context).add(ConfigChanged(
                        config: Config(
                            appTheme: AppTheme.light,
                            language: Language.turkish)));
                  },
                  child: Text('Turkish'),
                ),
                TextButton(
                  onPressed: () {
                    BlocProvider.of<ConfigBloc>(context).add(ConfigChanged(
                        config: Config(
                            appTheme: AppTheme.dark,
                            language: Language.english)));

                    // Action to perform when the first button is pressed.
                  },
                  child: Text('English'),
                ),
                TextButton(
                  onPressed: () {
                    GoRouter.of(context).pop();
                    // Action to perform when the second button is pressed.
                  },
                  child: Text('Close'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  };

  CustomDialog({
    this.anchorPoint,
    this.barrierColor = Colors.black54,
    this.barrierDismissible = true,
    this.barrierLabel,
    this.useSafeArea = true,
    this.themes,
    super.key,
    super.name,
    super.arguments,
    super.restorationId,
  });

  @override
  Route<T> createRoute(BuildContext context) => DialogRoute<T>(
        context: context,
        settings: this,
        builder: builder, // Use the directly defined builder
        anchorPoint: anchorPoint,
        barrierColor: barrierColor,
        barrierDismissible: barrierDismissible,
        barrierLabel: barrierLabel,
        useSafeArea: useSafeArea,
        themes: themes,
      );
}
