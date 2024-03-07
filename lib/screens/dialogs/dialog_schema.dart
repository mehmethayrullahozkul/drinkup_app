import 'package:drinkup_app/services/size/size_service.dart';
import 'package:flutter/material.dart';

class DialogSchema extends StatelessWidget {
  final List<Widget> children;
  final String title;
  final double width;
  final bool hasTitle;

  final Alignment alignment;

  const DialogSchema(
      {super.key,
      required this.children,
      this.hasTitle = true,
      this.title = '',
      required this.alignment,
      required this.width});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      alignment: alignment,
      insetPadding: EdgeInsets.zero,
      backgroundColor: const Color.fromARGB(0, 255, 0, 0),
      child: Container(
        width: width,
        /* padding: EdgeInsets.fromLTRB(20, 20, 20, 20), */
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
                color: Color.fromARGB(111, 20, 20, 20),
                offset: Offset(0, 0),
                blurRadius: 10,
                spreadRadius: 0),
          ],
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromARGB(255, 250, 250, 250),
              Color.fromARGB(255, 250, 250, 250),
            ],
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            (hasTitle)
                ? Container(
                    padding: EdgeInsets.only(bottom: 6),
                    width: width,
                    /* decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Color.fromARGB(48, 68, 68, 68),
                    width: 0.2,
                  ),
                ),
              ), */
                    child: Text(
                      title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        color: Color.fromARGB(255, 87, 87, 87),
                        fontFamily: 'Gotham',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  )
                : SizedBox(),
            /*  SizedBox(height: 0), */
            ...children
          ],
        ),
      ),
    );
  }
}
