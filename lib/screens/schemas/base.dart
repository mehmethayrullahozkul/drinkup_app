import 'package:flutter/material.dart';

class ScreenSchema extends StatefulWidget {
  final bool appBarAfterBody;
  final double appBarTopMargin;
  final List<Widget> children;
  final Decoration? decoration;
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry padding;
  final double? height;
  final double? width;
  final Color backgroundColor;
  final MainAxisAlignment mainAxisAligment;
  final CrossAxisAlignment crossAxisAlignment;
  final Widget? appBar;
  final double spaceBetweenItems;
  const ScreenSchema({
    this.appBarAfterBody = false,
    super.key,
    this.appBar,
    required this.children,
    this.decoration,
    this.margin = EdgeInsets.zero,
    this.padding = EdgeInsets.zero,
    this.height,
    this.width,
    this.backgroundColor = Colors.transparent,
    this.mainAxisAligment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.spaceBetweenItems = 0.0,
    this.appBarTopMargin = 0.0,
  });

  @override
  State<ScreenSchema> createState() => _ScreenSchemaState();
}

class _ScreenSchemaState extends State<ScreenSchema> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: widget.width ?? MediaQuery.of(context).size.width,
        height: widget.height ?? MediaQuery.of(context).size.height,
        decoration:
            widget.decoration ?? BoxDecoration(color: widget.backgroundColor),
        margin: widget.margin,
        padding: widget.padding,
        child: DefaultTextStyle(
          style: const TextStyle(color: Colors.black, fontFamily: 'Sofia-Pro'),
          child: Stack(
            /* clipBehavior: Clip.hardEdge, */
            children: [
              Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: widget.mainAxisAligment,
                crossAxisAlignment: widget.crossAxisAlignment,
                children: [
                  ...widget.children,
                ],
              ),
              if (widget.appBar != null)
                Padding(
                  padding: EdgeInsets.only(top: widget.appBarTopMargin),
                  child: SizedBox(height: 80, child: widget.appBar!),
                ),
            ],
          ),
          /* if (widget.appBar != null) widget.appBar!, */
        ));
  }
}
