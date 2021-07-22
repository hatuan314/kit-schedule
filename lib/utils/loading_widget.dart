import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';

class LoadingWidget extends StatefulWidget {
  final Color color;
  final double size;

  const LoadingWidget({
    Key? key,
    required this.color,
    this.size = 50.0,
  }) : super(key: key);

  @override
  _LoadingWidgetState createState() => new _LoadingWidgetState();
}

class _LoadingWidgetState extends State<LoadingWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation1;
  late Animation<double> _animation2;

  @override
  void initState() {
    super.initState();
    _controller = new AnimationController(
        vsync: this, duration: Duration(milliseconds: 1200));
    _animation1 = Tween(begin: 0.0, end: 180.0).animate(
      new CurvedAnimation(
        parent: _controller,
        curve: new Interval(0.0, 0.5, curve: Curves.easeIn),
      ),
    )..addListener(() => setState(() => <String, void>{}));

    _animation2 = Tween(begin: 0.0, end: 180.0).animate(
      new CurvedAnimation(
        parent: _controller,
        curve: new Interval(0.5, 1.0, curve: Curves.easeOut),
      ),
    )..addListener(() => setState(() => <String, void>{}));

    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Matrix4 transform = new Matrix4.identity()
      ..rotateX((0 - _animation1.value) * 0.0174533)
      ..rotateY((0 - _animation2.value) * 0.0174533);
    return Center(
      child: new Transform(
        transform: transform,
        alignment: FractionalOffset.center,
        child: new Container(
          height: widget.size,
          width: widget.size,
          decoration:
              BoxDecoration(shape: BoxShape.circle, color: widget.color),
        ),
      ),
    );
  }
}
