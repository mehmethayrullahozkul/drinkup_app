import 'dart:math';

import 'package:drinkup_app/constants/menu_constants.dart' as MenuConstants;
import 'package:flutter/material.dart';

class DrinkList extends StatefulWidget {
  final List<Widget> items;
  final double height;
  final double width;
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry padding;
  final Color backgroundColor;
  final MainAxisAlignment mainAxisAligment;
  final CrossAxisAlignment crossAxisAlignment;
  final double marginBetweenItems;
  final BorderRadiusGeometry borderRadius;

  const DrinkList(
      {super.key,
      required this.items,
      this.height = MenuConstants.drinkListHeight,
      this.width = MenuConstants.drinkListWidth,
      this.margin = MenuConstants.drinkListMargin,
      this.padding = MenuConstants.drinkListPadding,
      this.backgroundColor = MenuConstants.drinkListBackgroundColor,
      this.mainAxisAligment = MenuConstants.drinkListMainAxisAligment,
      this.crossAxisAlignment = MenuConstants.drinkListCrossAxisAlignment,
      this.marginBetweenItems = MenuConstants.drinkListMarginBetweenItems,
      this.borderRadius = MenuConstants.drinkListBorderRadius});

  @override
  State<DrinkList> createState() => _DrinkListState();
}

class _DrinkListState extends State<DrinkList>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      height: widget.height,
      width: widget.width,
      decoration: BoxDecoration(
          color: widget.backgroundColor, borderRadius: widget.borderRadius),
      margin: widget.margin,
      clipBehavior: Clip.hardEdge,
      padding: widget.padding,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 20,
        itemBuilder: (context, index) {
          return UnconstrainedBox(
            child: Padding(
              padding: EdgeInsets.only(
                  left: widget.marginBetweenItems / 2,
                  right: widget.marginBetweenItems / 2),
              child: widget.items[index],
            ),
          );
        },
      ),
    );
  }
}

class DrinkListItem extends StatelessWidget {
  final String imagePath;
  final double height;
  final double width;
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry padding;
  final Color backgroundColor;
  final Axis axis;
  final String label;
  final String title;
  final VoidCallback? onTap;
  final Color titleColor;
  final double titleFontSize;
  final String titleFontFamily;
  final FontWeight titleFontWeight;
  final Color labelColor;
  final double labelFontSize;
  final String labelFontFamily;
  final FontWeight labelFontWeight;
  final MainAxisAlignment mainAxisAligment;
  final CrossAxisAlignment crossAxisAlignment;
  final double spaceBetweenElements;
  final List<BoxShadow> boxShadow;
  final LinearGradient? gradient;
  final Border? border;
  final BorderRadius borderRadius;

  const DrinkListItem(
      {super.key,
      this.imagePath = MenuConstants.drinkListItemImagePath,
      this.height = MenuConstants.drinkListItemHeight,
      this.width = MenuConstants.drinkListItemWidth,
      this.margin = MenuConstants.drinkListItemMargin,
      this.padding = MenuConstants.drinkListItemPadding,
      this.backgroundColor = MenuConstants.drinkListItemBackgroundColor,
      this.axis = Axis.vertical,
      this.label = '',
      this.title = '',
      this.onTap,
      this.titleColor = MenuConstants.drinkListItemTitleColor,
      this.titleFontSize = MenuConstants.drinkListItemTitleFontSize,
      this.titleFontFamily = MenuConstants.drinkListItemTitleFontFamily,
      this.titleFontWeight = MenuConstants.drinkListItemTitleFontWeight,
      this.labelColor = MenuConstants.drinkListItemLabelColor,
      this.labelFontSize = MenuConstants.drinkListItemLabelFontSize,
      this.labelFontFamily = MenuConstants.drinkListItemLabelFontFamily,
      this.labelFontWeight = MenuConstants.drinkListItemLabelFontWeight,
      this.mainAxisAligment = MenuConstants.drinkListItemMainAxisAligment,
      this.crossAxisAlignment = MenuConstants.drinkListItemCrossAxisAlignment,
      this.spaceBetweenElements =
          MenuConstants.drinkListItemSpaceBetweenElements,
      this.boxShadow = MenuConstants.drinkListItemBoxShadow,
      this.gradient,
      this.borderRadius = MenuConstants.drinkListItemBorderRadius,
      this.border});

  static final List<Image> _waterBottle = [
    /* Image(
        image: ResizeImage(
            const AssetImage(
                'assets/images/water-bottles/bottle-regular-nc-1.png'),
            width: MenuConstants.drinkListItemImageWidth.toInt())), */
    Image.asset('assets/images/water-bottles/bottle-regular-nc-1.png',
        fit: BoxFit.fitWidth, width: MenuConstants.drinkListItemImageWidth),
    Image.asset('assets/images/water-bottles/bottle-regular-nc-2.png',
        fit: BoxFit.fitWidth, width: MenuConstants.drinkListItemImageWidth),
    Image.asset('assets/images/water-bottles/bottle-regular-nc-3.png',
        fit: BoxFit.fitWidth, width: MenuConstants.drinkListItemImageWidth),
    Image.asset('assets/images/water-bottles/bottle-regular-nc-4.png',
        fit: BoxFit.fitWidth, width: MenuConstants.drinkListItemImageWidth),
    Image.asset('assets/images/water-bottles/bottle-regular-nc-5.png',
        fit: BoxFit.fitWidth, width: MenuConstants.drinkListItemImageWidth),

    /* Image(
        image: ResizeImage(
            const AssetImage(
                'assets/images/water-bottles/bottle-regular-nc-1.png'),
            width: MenuConstants.drinkListItemImageWidth.toInt())), */
    /* Image(
        image: ResizeImage(
            const AssetImage(
                'assets/images/water-bottles/bottle-regular-nc-3.png'),
            width: MenuConstants.drinkListItemImageWidth.toInt())),
    Image(
        image: ResizeImage(
            const AssetImage(
                'assets/images/water-bottles/bottle-regular-nc-4.png'),
            width: MenuConstants.drinkListItemImageWidth.toInt())),
    Image(
        image: ResizeImage(
            const AssetImage(
                'assets/images/water-bottles/bottle-regular-nc-5.png'),
            width: MenuConstants.drinkListItemImageWidth.toInt())),
    Image(
        image: ResizeImage(
            const AssetImage(
                'assets/images/water-bottles/bottle-regular-nc-6.png'),
            width: MenuConstants.drinkListItemImageWidth.toInt())), */
    /* Image(
        image: ResizeImage(
            const AssetImage(
                'assets/images/water-bottles/bottle-coffee-cup-1.png'),
            width: MenuConstants.drinkListItemImageWidth.toInt())),
    Image(
        image: ResizeImage(
            const AssetImage(
                'assets/images/water-bottles/bottle-coffee-cup-2.png'),
            width: MenuConstants.drinkListItemImageWidth.toInt())),
    Image(
        image: ResizeImage(
            const AssetImage('assets/images/water-bottles/bottle-drink-1.png'),
            width: MenuConstants.drinkListItemImageWidth.toInt())), */
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
          border: border,
          color: backgroundColor,
          gradient: gradient,
          borderRadius: borderRadius,
          boxShadow: boxShadow),
      child: (axis == Axis.vertical)
          ? Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Stack(children: [
                  InkWell(
                    onTap: onTap ?? () {},
                    child: SizedBox(
                      width: width,
                      height: height,
                      child: Column(
                          mainAxisAlignment: mainAxisAligment,
                          crossAxisAlignment: crossAxisAlignment,
                          children: [
                            /* Image(
                              image: ResizeImage(AssetImage(imagePath),
                                  height: MenuConstants.drinkListItemImageHeight
                                      .toInt(),
                                  width: MenuConstants.drinkListItemImageWidth
                                      .toInt()),
                            ), */
                            /* SizedBox(height: 10), */
                            SizedBox(
                                width: MenuConstants.drinkListItemImageWidth,
                                height: MenuConstants.drinkListItemImageHeight,
                                child: _waterBottle[
                                    Random().nextInt(_waterBottle.length)]),
                            /*  if (title != '')
                              SizedBox(height: spaceBetweenElements), */
                            Text(
                              title,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: titleColor,
                                fontSize: titleFontSize,
                                fontFamily: titleFontFamily,
                                fontWeight: titleFontWeight,
                              ),
                            ), /*
                            if (label != '')
                              SizedBox(height: spaceBetweenElements), */
                            /* Text(
                              label,
                              style: TextStyle(
                                color: labelColor,
                                fontSize: labelFontSize,
                                fontFamily: labelFontFamily,
                                fontWeight: labelFontWeight,
                              ),
                            ), */
                          ]),
                    ),
                  ),
                  Container(
                      alignment: Alignment.topRight,
                      height: 20,
                      width: double.infinity,
                      /* color: Color.fromARGB(255, 0, 47, 255), */
                      child: GestureDetector(
                          onTap: () {
                            print("delete tab");
                          },
                          child: Container(
                            padding: const EdgeInsets.only(right: 10, top: 2),
                            clipBehavior: Clip.hardEdge,
                            decoration: const BoxDecoration(
                                color: Color.fromARGB(0, 255, 255, 255),
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(4))),
                            alignment: Alignment.center,
                            width: 12,
                            height: 12,
                            child: const Icon(
                              Icons.close_rounded,
                              color: Color.fromARGB(255, 255, 255, 255),
                              size: 10,
                            ),
                          ))),
                ]),
                /* Container(
                  height: 16,
                  alignment: Alignment.center,
                  color: generateRandomWhitishColor(
                      opacity: 0.81,
                      start: 200,
                      preference: 2,
                      prominance: 0.8),
                  width: width,
                  child: Text(label,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w600)),
                ), */
              ],
            )
          : const Row(),
    );
  }
}
