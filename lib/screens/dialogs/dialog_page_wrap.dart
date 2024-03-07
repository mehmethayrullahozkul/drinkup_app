import 'package:drinkup_app/constants/route_constants.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

enum DialogAnimationType { fade, slidefrombottom }

class DialogPageWrap<T> extends Page<T> {
  final Widget child;
  final bool hasAnimation;
  final int forwardAnimationDurationInMilliseconds;
  final DialogAnimationType animationType;
  final int? reverseAnimationDurationInMilliseconds;

  final bool maintainState;

  final bool maintainAnimation;
  final bool maintainSize;
  final bool opaque;
  final bool barrierDismissible;
  final Color? barrierColor;
  final String? barrierLabel;
  final bool useSafeArea;
  final CapturedThemes? themes;
  final Offset? anchorPoint;

  const DialogPageWrap({
    required this.child,
    this.hasAnimation = true,
    this.animationType = DialogAnimationType.fade,
    this.forwardAnimationDurationInMilliseconds = 300,
    this.reverseAnimationDurationInMilliseconds,
    this.maintainState = true,
    this.maintainAnimation = true,
    this.maintainSize = true,
    this.opaque = true,
    this.barrierDismissible = false,
    this.barrierColor = const Color.fromARGB(0, 0, 0, 0),
    this.barrierLabel,
    this.useSafeArea = true,
    this.themes,
    this.anchorPoint,
  });

  @override
  Route<T> createRoute(BuildContext context) {
    print("create route called");
    return DialogRoute<T>(
      builder: (context) {
        if (hasAnimation) {
          /* return child; */
          return AnimatedDialogBuilder(
            animationType: animationType,
            forwardAnimationDurationInMilliseconds:
                forwardAnimationDurationInMilliseconds,
            reverseAnimationDurationInMilliseconds:
                reverseAnimationDurationInMilliseconds ??
                    forwardAnimationDurationInMilliseconds ~/ 2,
            child: child,
          );
        } else {
          return child;
        }
      },
      barrierColor: barrierColor,
      barrierDismissible: barrierDismissible,
      barrierLabel: barrierLabel,
      useSafeArea: useSafeArea,
      context: context,
      settings: this,
    );
  }
}

class AnimatedDialogBuilder extends StatefulWidget {
  final Widget child;
  final DialogAnimationType animationType;
  final int forwardAnimationDurationInMilliseconds;
  final int reverseAnimationDurationInMilliseconds;

  static void closeDialog(BuildContext context) {
    context
        .findAncestorStateOfType<_AnimatedDialogBuilderState>()!
        ._closeDialog();
  }

  const AnimatedDialogBuilder({
    super.key,
    required this.child,
    required this.animationType,
    required this.forwardAnimationDurationInMilliseconds,
    required this.reverseAnimationDurationInMilliseconds,
  });

  @override
  _AnimatedDialogBuilderState createState() => _AnimatedDialogBuilderState();
}

class _AnimatedDialogBuilderState extends State<AnimatedDialogBuilder>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;

  void _closeDialog() {
    controller.reverse();
  }

  @override
  void initState() {
    controller = AnimationController(
      duration:
          Duration(milliseconds: widget.forwardAnimationDurationInMilliseconds),
      reverseDuration:
          Duration(milliseconds: widget.reverseAnimationDurationInMilliseconds),
      vsync: this,
    )..addStatusListener((status) {
        if (status == AnimationStatus.dismissed) {
          GoRouter.of(context).pop();
        }
      });
    animation = Tween<double>(begin: 0, end: 1)
        .animate(CurvedAnimation(parent: controller, curve: Curves.easeInOut));
    controller.forward();

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    /*
     *  Build Called Right After GoRouter.pop
     *  Don't show the dialog if the current route is not the dialog route
     *  Can be used to prevent rebuilding the dialog when the route changes
    */
    if (GoRouter.of(context)
            .routeInformationProvider
            .value
            .uri
            .pathSegments
            .last ==
        Routes.menu.path) {
      return const SizedBox();
    }
    return Stack(children: [
      GestureDetector(
        onTap: () {
          _closeDialog();
        },
        child: FadeTransition(
          opacity: animation,
          child: Container(
            color: Color.fromARGB(82, 0, 0, 0),
            width: double.infinity,
            height: double.infinity,
          ),
        ),
      ),
      Builder(builder: (context) {
        switch (widget.animationType) {
          case DialogAnimationType.fade:
            return FadeTransition(
              opacity: animation,
              child: widget.child,
            );
          case DialogAnimationType.slidefrombottom:
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0.0, 1.0),
                end: const Offset(0.0, 0.0),
              ).animate(controller),
              child: widget.child,
            );
        }
      }),
    ]);
  }
}
