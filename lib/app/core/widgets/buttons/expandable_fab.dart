
import 'package:flutter/material.dart';

class FabActionButton {
  final Function() onPressed;
  final String title;
  final IconData icon;

  FabActionButton(
      {required this.onPressed, required this.title, required this.icon});
}

// ignore: must_be_immutable
class ExpandableFab extends StatefulWidget {
  List<FabActionButton> fabButtons;

  ExpandableFab({super.key, required this.fabButtons});

  @override
  // ignore: library_private_types_in_public_api
  _ExpandableFabState createState() => _ExpandableFabState();
}

class _ExpandableFabState extends State<ExpandableFab>
    with SingleTickerProviderStateMixin {
  bool isOpened = false;
  AnimationController? _animationController;
  Animation<Color?>? _buttonColor;
  Animation<double>? _animateIcon;
  Animation<double>? _translateButton;
  final Curve _curve = Curves.easeOut;
  final double _fabHeight = 56.0;
  double init = 1.0;

  @override
  initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 500))
          ..addListener(() {
            setState(() {});
          });
    _animateIcon =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController!);
    _buttonColor = ColorTween(
      begin: Colors.green,
      end: Colors.green,
    ).animate(CurvedAnimation(
      parent: _animationController!,
      curve: const Interval(
        0.00,
        1.00,
        curve: Curves.linear,
      ),
    ));
    _translateButton = Tween<double>(
      begin: _fabHeight,
      end: -14.0,
    ).animate(CurvedAnimation(
      parent: _animationController!,
      curve: Interval(
        0.0,
        0.75,
        curve: _curve,
      ),
    ));
  }

  @override
  dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  animate() {
    if (!isOpened) {
      _animationController?.forward();
    } else {
      _animationController?.reverse();
    }
    isOpened = !isOpened;
  }

  Widget toggle() {
    return FloatingActionButton(
      backgroundColor: _buttonColor?.value,
      onPressed: animate,
      tooltip: "Menu",
      child: AnimatedIcon(
        color: Colors.white,
        icon: AnimatedIcons.menu_close,
        progress: _animateIcon!,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        ...widget.fabButtons
            .map((e) {
              return Transform(
                transform: Matrix4.translationValues(
                  0.0,
                  widget.fabButtons.indexOf(e) == 0
                      ? _translateButton!.value
                      : _translateButton!.value *
                          (widget.fabButtons.indexOf(e) + 1).toDouble(),
                  0.0,
                ),
                child: GestureDetector(
                  onTap: e.onPressed,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Transform(
                        transform: Matrix4.translationValues(
                          _translateButton!.value,
                          0.0,
                          0.0,
                        ),
                        child: Visibility(
                          visible: !_animationController!.isDismissed,
                          child: Container(
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                backgroundBlendMode: BlendMode.srcOver,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  e.title,
                                  style: const TextStyle(color: Colors.black54),
                                ),
                              )),
                        ),
                      ),
                      FloatingActionButton(
                        backgroundColor: Colors.white,
                        onPressed: e.onPressed,
                        tooltip: e.title,
                        child: Icon(
                          e.icon,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            })
            .toList()
            .reversed,
        toggle(),
      ],
    );
  }
}
