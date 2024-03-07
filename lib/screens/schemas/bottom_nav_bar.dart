import 'package:drinkup_app/constants/route_constants.dart';
import 'package:drinkup_app/services/size/size_service.dart';
import 'package:flutter/material.dart' hide BottomNavigationBar;

class BottomNavBar extends StatefulWidget {
  final double height;
  final List<BottomNavBarItem> items;
  final BottomNavBarAnimationType animationType;
  final Duration animationDuration;
  final Curve animationCurve;
  final Color backgroundColor;
  final double iconSize;
  final double spaceBetweenLabelAndIcon;
  final double labelSize;
  final bool showLabel;
  final double elevation;
  final double padding;
  final String labelFontFamily;
  final double margin;
  final double itemPadding;
  final double itemMargin;
  final int? startIndex;
  final Border border;
  final Gradient? backgroundGradient;
  final Color selectedColor;
  final Color unselectedColor;
  final FontWeight labelFontWeight;
  final Color itemBackgroundColor;
  final Function(int)? onChange;

  const BottomNavBar(
      {super.key,
      this.startIndex,
      this.border = const Border(),
      this.spaceBetweenLabelAndIcon = 0,
      this.height = 60,
      this.elevation = 0,
      this.showLabel = true,
      this.labelSize = 12,
      this.labelFontWeight = FontWeight.w300,
      this.padding = 0,
      this.margin = 0,
      this.itemPadding = 0,
      this.itemMargin = 0,
      this.labelFontFamily = 'Sofia-Pro',
      this.items = const [],
      this.animationType = BottomNavBarAnimationType.none,
      this.backgroundGradient,
      this.onChange,
      this.selectedColor = const Color.fromARGB(255, 20, 20, 20),
      this.unselectedColor = const Color.fromARGB(255, 252, 0, 0),
      this.iconSize = 24,
      this.animationDuration = const Duration(milliseconds: 10),
      this.animationCurve = Curves.easeInOut,
      this.itemBackgroundColor = Colors.transparent,
      this.backgroundColor = Colors.white});

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar>
    with TickerProviderStateMixin {
  late int pageIndex;
  final List<AnimationController> _controllers = [];
  final List<Animation<Color?>> _animations = [];

  @override
  void initState() {
    pageIndex = widget.startIndex ?? Routes.menu.index;
    super.initState();
    for (int i = 0; i < widget.items.length; i++) {
      _controllers.add(AnimationController(
        vsync: this,
        duration: (i < 1 || i == widget.items.length)
            ? widget.animationDuration * 2
            : widget.animationDuration,
      ));
    }

    for (int i = 0; i < widget.items.length; i++) {
      _animations.add(TweenSequence<Color?>([
        TweenSequenceItem(
            tween: ColorTween(
                begin: widget.unselectedColor, end: widget.selectedColor),
            weight: 0.5),
        TweenSequenceItem(
            tween: ColorTween(
                begin: widget.selectedColor, end: widget.unselectedColor),
            weight: 0.5),
      ]).animate(CurvedAnimation(
        parent: _controllers[i],
        /* ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              _controllers[i].reset();
            }
          } */
        curve: Curves.easeInOut,
      )));
    }
  }

  Future<bool> _animate(int index) async {
    print("current index : ${pageIndex} , index: $index");
    if (pageIndex > index) {
      for (int i = pageIndex; i >= index; i--) {
        print("for $i");
        await _controllers[i].forward();
      }
    } else if (pageIndex < index) {
      for (int i = pageIndex; i <= index; i++) {
        print("for $i");
        await _controllers[i].forward();
      }
    }
    return true;
  }

  @override
  void dispose() {
    for (int i = 0; i < _controllers.length; i++) {
      _controllers[i].dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        gradient: widget.backgroundGradient,
        border: widget.border,
        /* boxShadow: [
          BoxShadow(
            color: Color.fromARGB(159, 55, 0, 255),
            spreadRadius: 0,
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ], */
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal:
              (SizeService().screenWidth - (SizeService().screenWidth * 0.90)) /
                  2.0,
        ),
        child: DefaultTextStyle(
            style: TextStyle(
              color: widget.unselectedColor,
            ),
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: widget.items.length,
                itemExtent:
                    (SizeService().screenWidth / widget.items.length) * 0.90,
                itemBuilder: (context, index) {
                  return Container(
                    height: widget.height,
                    /*  width: widget.height * 1.5, */
                    /* clipBehavior: Clip.hardEdge, */
                    decoration: BoxDecoration(
                      color: widget.itemBackgroundColor,
                      borderRadius: BorderRadius.circular(80),
                    ),
                    child: RepaintBoundary(
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            /* setState(() {});
                          /* await _animate(index); */
                          pageIndex = index; */
                            if (widget.onChange != null) {
                              widget.onChange!(index);
                            }
                            pageIndex = index;
                            /* setState(() {}); */
                          },
                          child: _BottomNavBarItem(
                              widthPercentage: 1 / widget.items.length,
                              icon: widget.items[index].icon,
                              label: widget.items[index].label,
                              iconSize: widget.iconSize,
                              iconColor: pageIndex == index
                                  ? widget.selectedColor
                                  : _animations[index].value!,
                              labelColor: pageIndex == index
                                  ? widget.selectedColor
                                  : _animations[index].value!,
                              labelSize: widget.labelSize,
                              labelFontWeight: widget.labelFontWeight,
                              labelFontFamily: widget.labelFontFamily,
                              spaceBetweenLabelAndIcon:
                                  widget.spaceBetweenLabelAndIcon,
                              showLabel: widget.showLabel,
                              backgroundColor: widget.itemBackgroundColor,
                              padding: widget.itemPadding,
                              margin: widget.itemMargin,
                              iconPadding: widget.itemPadding),
                        ),
                      ),
                    ),
                  );
                })),
      ),
    );
  }
}

enum BottomNavBarAnimationType {
  slide,
  fade,
  none,
}

class BottomNavBarItem {
  final IconData icon;
  final String label;

  BottomNavBarItem({
    required this.icon,
    required this.label,
  }) : super();
}

class _BottomNavBarItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final double iconSize;
  final Color iconColor;
  final Color labelColor;
  final double labelSize;
  final bool showLabel;
  final Color backgroundColor;
  final double padding;

  final double margin;
  final double iconPadding;
  final double labelPadding;
  final String labelFontFamily;
  final double iconMargin;
  final FontWeight labelFontWeight;
  final double spaceBetweenLabelAndIcon;
  final double labelMargin;
  final double? widthPercentage;

  const _BottomNavBarItem({
    this.spaceBetweenLabelAndIcon = 0,
    this.widthPercentage,
    required this.icon,
    required this.label,
    this.labelFontWeight = FontWeight.w300,
    this.iconSize = 20,
    this.iconColor = Colors.white,
    this.labelColor = Colors.white,
    this.labelSize = 12,
    this.showLabel = true,
    this.backgroundColor = const Color.fromARGB(0, 37, 59, 77),
    this.padding = 0,
    this.margin = 0,
    this.iconPadding = 0,
    this.iconMargin = 0,
    this.labelPadding = 0,
    this.labelMargin = 0,
    this.labelFontFamily = 'Sofia-Pro',
  }) : super();

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(padding),
      margin: EdgeInsets.all(margin),
      height: double.infinity,
      width: (widthPercentage != null)
          ? widthPercentage! * MediaQuery.of(context).size.width
          : null,
      /* height: iconSize + labelSize / 2 + 2, */
      child: SizedBox(
        height: iconSize + labelSize * 1.5 + spaceBetweenLabelAndIcon,
        child: Column(
          /* mainAxisSize: MainAxisSize.max, */

          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              padding: EdgeInsets.all(iconPadding),
              margin: EdgeInsets.only(bottom: spaceBetweenLabelAndIcon),
              child: Icon(
                icon,
                size: iconSize,
                color: iconColor,
              ),
            ),
            /*  showLabel
                ? SizedBox(height: spaceBetweenLabelAndIcon)
                : Container(), */
            showLabel
                ? Container(
                    padding: EdgeInsets.all(labelPadding),
                    margin: EdgeInsets.all(labelMargin),
                    decoration: const BoxDecoration(
                      boxShadow: [],
                    ),
                    child: Text(
                      label,
                      style: TextStyle(
                        fontFamily: labelFontFamily,
                        color: labelColor,
                        fontSize: labelSize,
                        fontWeight: labelFontWeight,
                      ),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
