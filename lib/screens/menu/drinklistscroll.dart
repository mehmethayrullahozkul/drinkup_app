import 'package:drinkup_app/services/size/size_service.dart';
import 'package:flutter/material.dart';
import 'package:drinkup_app/utils/utils.dart' as Utils;
import 'package:drinkup_app/screens/menu/drinklist.dart';
import 'package:carousel_slider/carousel_slider.dart';

class DrinkListScroll extends StatefulWidget {
  int initialValue;
  void Function(int) onChanged;
  DrinkListScroll(
      {Key? key, required this.initialValue, required this.onChanged})
      : super(key: key);

  @override
  State<DrinkListScroll> createState() => _DrinkListScrollState();
}

class _DrinkListScrollState extends State<DrinkListScroll> {
  late CarouselController _controller;
  /* late final List<DrinkListItem> bottles; */
  /* late final  List<Widget> waterSteps; */
  int selectedValue = 200; // Initial selected value

  @override
  void initState() {
    /* waterSteps = generateWaterSteps(selectedValue); */
    super.initState();
    _controller = CarouselController();
    _controller.onReady.then((value) {
      _controller.jumpToPage(widget.initialValue);
    });
    /* _bottles = generateWaterBottles(); */
    /* WidgetsBinding.instance!.addPostFrameCallback((_) {
      _scrollController.jumpTo(200);
    }); */
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: SizeService().screenWidth * 0.95,
        margin: EdgeInsets.only(top: 0.0),
        /* color: Colors.red, */
        child: CarouselSlider.builder(
            itemCount: 10,
            itemBuilder: (context, index, realIndex) {
              return GestureDetector(
                onTap: () {
                  _controller.animateToPage(index,
                      curve: Curves.easeInOut,
                      duration: Duration(milliseconds: 300));
                },
                child: Container(
                  /* clipBehavior: Clip.hardEdge, */
                  height: 100,
                  width: 60,
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(28, 255, 255, 255),
                    borderRadius: BorderRadius.circular(60),
                    /* border: Border.all(
                            color: Color.fromARGB(138, 160, 160, 160),
                            width: .5,
                          ), */
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 6,
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Text(
                            '${index * 50 + 200}',
                            style: TextStyle(
                                fontSize: 14.0,
                                /* * constraints.biggest.shortestSide / 60, */
                                fontWeight: FontWeight.w900,
                                color: Colors.white,
                                fontFamily: 'Gotham'),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 5,
                        child: Text(
                          'ml',
                          style: TextStyle(
                              fontSize: 10.0,
                              color: Colors.white,
                              fontFamily: 'Gotham'),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
            carouselController: _controller,

            /* bottles, */
            options: CarouselOptions(
              scrollPhysics: FixedExtentScrollPhysics(),
              height: 60,
              aspectRatio: 1,
              viewportFraction: 0.20,
              initialPage: 4,
              enableInfiniteScroll: true,

              /* autoPlayInterval: Duration(seconds: 3),
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn, */
              enlargeCenterPage: true,
              enlargeFactor: 0.22,
              onPageChanged: (int, reason) {
                if (reason == CarouselPageChangedReason.manual ||
                    reason == CarouselPageChangedReason.controller) {
                  selectedValue = int * 50 + 200;
                  widget.onChanged(selectedValue);
                }
              },
              scrollDirection: Axis.horizontal,
            )));
  }

  /* List<DrinkListItem> generateWaterBottles() {
    List<DrinkListItem> containers = [];

    for (int i = 0; i < 20; i++) {
      containers.add(DrinkListItem(
        width: 74,
        /* margin: EdgeInsets.all(3), */
        height: 50,
        padding: const EdgeInsets.all(5),
        backgroundColor: Color.fromARGB(0, 255, 255, 255),
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
          /* BlocProvider.of<WaterProgressBloc>(context)
              .add(WaterProgressIncreased(amount: 300 + i * 10)); */
        },

        /* gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              /* Utils.generateRandomWhitishColor(
                  opacity: 1, start: 250, preference: 2, prominance: 0.5),
              Utils.generateRandomWhitishColor(
                  opacity: 1, start: 150, preference: 2, prominance: 0.5), */

              /* Color.fromARGB(0, 1, 81, 255),
              Color.fromARGB(0, 71, 0, 129), */
            ]), */
        titleFontSize: 11,
        titleFontFamily: 'Gotham',
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

  /* List<Widget> generateWaterSteps(int selectedValue) {
    return List.generate(10, (index) {
      return Builder(builder: (context) {
        return GestureDetector(
          onTap: () {
            _controller.animateToPage(index,
                curve: Curves.easeInOut, duration: Duration(milliseconds: 300));
          },
          child: Container(
            height: 100,
            width: 120,
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(horizontal: 5.0),
            decoration: BoxDecoration(
              color: Color.fromARGB(28, 255, 255, 255),
              borderRadius: BorderRadius.circular(100),
              /* border: Border.all(
                          color: Color.fromARGB(138, 160, 160, 160),
                          width: .5,
                        ), */
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${(index * 50 + selectedValue)}',
                  style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      fontFamily: 'Gotham'),
                  textAlign: TextAlign.center,
                ),
                Text(
                  'ml',
                  style: TextStyle(
                      fontSize: 10.0,
                      color: Colors.white,
                      fontFamily: 'Gotham'),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );
      });
    });
  } */
}
