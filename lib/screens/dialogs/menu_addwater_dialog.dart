import 'package:drinkup_app/blocs/water_progress/water_progress.dart';
import 'package:drinkup_app/screens/dialogs/dialog_page_wrap.dart';
import 'package:drinkup_app/screens/dialogs/dialog_schema.dart';
import 'package:drinkup_app/screens/menu/drinklistscroll.dart';
import 'package:drinkup_app/services/size/size_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:drinkup_app/blocs/config/config_bloc.dart';
import 'package:drinkup_app/models/config/config_model.dart';
import 'package:drinkup_app/constants/constants.dart';

class AddWaterDialog extends StatefulWidget {
  /* late AnimationController controller; */
  final Key? key;

  const AddWaterDialog({
    this.key,
  });

  @override
  _AddWaterDialogState createState() => _AddWaterDialogState();
}

class _AddWaterDialogState extends State<AddWaterDialog> {
  int selectedValue = 200; // Initial selected value

  void _onSelectedValueChange(int value) {
    setState(() {
      selectedValue = value;
    });
  }

  @override
  void initState() {
    super.initState();

    /* animation = Tween<Offset>(begin: 0, end: 1).animate(controller); */
    /* controller.forward(); */
    /* widget.controller.forward(); */
  }

  @override
  void dispose() {
    super.dispose();
  }

  // Define the builder function directly inside the class
  @override
  Widget build(BuildContext context) {
    return DialogSchema(
        width: double.infinity,
        hasTitle: false,
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            /* color: Colors.red,
        width: double.infinity,
        height: double.infinity, */
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              width: double.infinity,
              height: 270,
              child: Dialog(
                insetPadding: EdgeInsets.zero,
                alignment: Alignment.bottomCenter,
                backgroundColor: Colors.transparent,
                /* shape: LinearBorder(), */
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),
                child: Container(
                  width: double.infinity, // Adjust width as needed

                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Color.fromARGB(52, 0, 0, 0),
                          offset: Offset(0, 0),
                          blurRadius: 10,
                          spreadRadius: 0)
                    ],
                    gradient: LinearGradient(
                      stops: [0.0, 0.5, 0.9, 1.0],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        /* Color.fromARGB(255, 151, 0, 197), */
                        Color.fromARGB(255, 73, 0, 133),
                        Color.fromARGB(255, 43, 5, 133),
                        Color.fromARGB(255, 47, 3, 151),
                        Color.fromARGB(255, 12, 3, 151),
                      ],
                    ),
                  ),
                  height: double.infinity,
                  padding: EdgeInsets.all(10),

                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      // Tap Here To Add Button
                      /* Container(
                      width: SizeService().screenWidth * 0.9,
                      height: 30,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 30,
                            margin: EdgeInsets.only(right: 5),
                            clipBehavior: Clip.hardEdge,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(12),
                              ),
                              color: Color.fromARGB(0, 255, 196, 0),
                              /*  border: Border.all(
                                color: Color.fromARGB(160, 245, 245, 245),
                                width: 1,
                              ), */
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onLongPress: () {},
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.favorite_outline,
                                        color: Color.fromARGB(
                                            255, 255, 196, 0),
                                        size: 14,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        'Favourites ',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: const Color.fromARGB(
                                              255, 255, 255, 255),
                                          fontSize: 11,
                                          fontFamily: 'Gotham',
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ]),
                              ),
                            ),
                          ),
                          Container(
                            height: 30,
                            margin: EdgeInsets.only(left: 5),
                            padding: EdgeInsets.all(0),
                            clipBehavior: Clip.hardEdge,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(12),
                              ),
                              color: Color.fromARGB(0, 248, 17, 0),
                              /* border: Border.all(
                                color: Color.fromARGB(160, 245, 245, 245),
                                width: 1,
                              ), */
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () {
                                  controller.reverse();
                                },
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.close_rounded,
                                        color:
                                            Color.fromARGB(255, 248, 17, 0),
                                        size: 14,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        'Close',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: const Color.fromARGB(
                                              255, 255, 255, 255),
                                          fontSize: 11,
                                          fontFamily: 'Gotham',
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ]),
                              ),
                            ),
                          ),
                        ],
                      )), */

                      // Tap Here to Addd 2
                      Container(
                          width: SizeService().screenWidth * 1,
                          height: 100,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                flex: 3,
                                child: UnconstrainedBox(
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                    /* clipBehavior: Clip.hardEdge, */
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(22),
                                      ),
                                      color: Color.fromARGB(0, 248, 17, 0),
                                      /* border: Border.all(
                                          color: Color.fromARGB(160, 245, 245, 245),
                                          width: 1,
                                        ), */
                                    ),
                                    child: Material(
                                      color: Colors.transparent,
                                      child: InkWell(
                                        onTap: () {
                                          /* controller.reverse(); */
                                          AnimatedDialogBuilder.closeDialog(
                                              context);
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 8.0, horizontal: 8),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Icon(
                                                Icons.favorite_outline,
                                                color: Color.fromARGB(
                                                    255, 255, 196, 0),
                                                size: 14,
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                'Favourites',
                                                style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 255, 251, 233),
                                                  fontSize: 11,
                                                  fontFamily: 'Sofia-Pro',
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 6,
                                child: Container(
                                  margin: EdgeInsets.only(top: 40),
                                  height: 60,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  /* clipBehavior: Clip.hardEdge, */
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                          color:
                                              Color.fromRGBO(0, 34, 184, 0.651),
                                          offset: Offset(0, 0),
                                          blurRadius: 10,
                                          spreadRadius: 0)
                                    ],
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(42),
                                    ),
                                    color: Color.fromARGB(255, 0, 58, 248),
                                    /* border: Border.all(
                                  color: Color.fromARGB(160, 245, 245, 245),
                                  width: 1,
                                ), */
                                  ),
                                  child: Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      onTap: () {
                                        AnimatedDialogBuilder.closeDialog(
                                            context);
                                        BlocProvider.of<WaterProgressBloc>(
                                                context)
                                            .add(WaterProgressIncreased(
                                                amount: selectedValue));
                                      },
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              'ADD WATER',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: const Color.fromARGB(
                                                    255, 255, 255, 255),
                                                fontSize: 18,
                                                fontFamily: 'Gotham',
                                                fontWeight: FontWeight.w900,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Icon(
                                              Icons.water_drop_outlined,
                                              color: Colors.white,
                                              size: 24,
                                            ),
                                          ]),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: UnconstrainedBox(
                                  alignment: Alignment.centerRight,
                                  child: Container(
                                    /* clipBehavior: Clip.hardEdge, */
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(12),
                                      ),
                                      color: Color.fromARGB(0, 248, 17, 0),
                                      /* border: Border.all(
                                          color: Color.fromARGB(160, 245, 245, 245),
                                          width: 1,
                                        ), */
                                    ),
                                    child: Material(
                                      color: Colors.transparent,
                                      child: InkWell(
                                        onTap: () {
                                          AnimatedDialogBuilder.closeDialog(
                                              context);
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.cancel_outlined,
                                                color: Color.fromARGB(
                                                    255, 248, 17, 0),
                                                size: 14,
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                'Close',
                                                style: TextStyle(
                                                  color: const Color.fromARGB(
                                                      255, 255, 255, 255),
                                                  fontSize: 11.5,
                                                  fontFamily: 'Sofia-Pro',
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )),

                      // Selected Values
                      Container(
                        width: SizeService().screenWidth * 0.8,
                        /* color: Colors.red, */
                        /* color: const Color.fromARGB(255, 255, 255, 255), */
                        height: 72,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: 2,
                              child: Container(
                                height: 30,
                                width: 70,
                                /* clipBehavior: Clip.hardEdge, */
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  border: Border.all(
                                    color: Color.fromARGB(255, 233, 233, 233),
                                    width: .5,
                                  ),
                                ),
                                alignment: Alignment.center,
                                padding: EdgeInsets.all(5),
                                child: Material(
                                  child: InkWell(
                                    onTap: () {
                                      _onSelectedValueChange(
                                          selectedValue - 200);
                                    },
                                    child: Text(
                                      '-200',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Color.fromARGB(255, 41, 41, 41),
                                        fontSize: 12,
                                        fontFamily: 'Gotham',
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 5,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SizedBox(
                                    child: Text(
                                      '$selectedValue',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 255, 255, 255),
                                        fontSize: 50,
                                        fontFamily: 'Amfibia',
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    width: 70,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Color.fromARGB(255, 255, 255, 255),
                                      border: Border.all(
                                        color:
                                            Color.fromARGB(255, 233, 233, 233),
                                        width: .5,
                                      ),
                                    ),
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.all(5),
                                    child: Text(
                                      '+200',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Color.fromARGB(255, 41, 41, 41),
                                        fontSize: 12,
                                        fontFamily: 'Gotham',
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                  ),
                                  /*  Text(
                                'Amount',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 68, 68, 68),
                                  fontSize: 12,
                                  fontFamily: 'Sofia-Pro',
                                  fontWeight: FontWeight.w300,
                                ),
                              ), */
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      DrinkListScroll(
                          initialValue: selectedValue,
                          onChanged: _onSelectedValueChange),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ]);
  }
}
