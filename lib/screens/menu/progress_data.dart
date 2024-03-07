/*

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:math' show min;
import 'constraints.dart';
import 'package:drinkup_app/blocs/water_progress/water_progress_bloc.dart';

class ProgressData extends StatefulWidget {
  final EdgeInsets margin;
  @override
  _ProgressDataState createState() => _ProgressDataState();

  const ProgressData({super.key, this.margin = EdgeInsets.zero});
}

class _ProgressDataState extends State<ProgressData>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Tween<double> _animationTween;
  late Animation<double> _animation;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 4));
    _animationTween = Tween<double>(begin: 0.0, end: 0.0);
    _animation = _animationTween.animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WaterProgressBloc, WaterProgressState>(
        bloc: BlocProvider.of<WaterProgressBloc>(context),
        buildWhen: (previous, current) {
          if (previous.progress >= 100) {
            return false;
          }
          return true;
        },
        builder: (context, state) {
          if (state is WaterProgressLoaded) {
            _controller.reset();
            _animationTween.begin = state.oldProgress;
            _animationTween.end = min(state.progress, 100);
            _controller.duration = Duration(
                milliseconds:
                    (min(state.progress - state.oldProgress, 0) * 100).toInt());
            _controller.forward(from: 0.0);
          }
          return Container(
            margin: widget.margin,
            alignment: Alignment.center,
            width: double.infinity,
            child: Container(
              height: 30,
              width: MenuScreenConstants.waterDataWidth / 3,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: MenuScreenConstants.waterDataBackgroundColor,
                border: Border.all(
                    color: MenuScreenConstants.waterDataBorderColor,
                    width: 0.1),
                /* borderRadius: BorderRadius.circular(10.0), */
                borderRadius: /* BorderRadius.only(
                    bottomLeft: Radius.circular(6.0),
                    bottomRight: Radius.circular(6.0)), */
                    const BorderRadius.all(Radius.circular(6.0)),
                boxShadow: MenuScreenConstants.waterDataBoxShadow,
              ),
              child: RepaintBoundary(
                child: AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) => Text(
                    '${_animation.value.toStringAsFixed(1)}%',
                    style: const TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontSize: 9.0,
                        fontWeight: FontWeight.w900,
                        fontFamily: 'Nexa'),
                  ),
                ),
              ),
            ),
          );
        });
  }
}
*/