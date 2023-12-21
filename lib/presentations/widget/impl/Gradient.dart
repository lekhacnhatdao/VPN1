import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Cstomgradient extends StatefulWidget {
  const Cstomgradient({super.key, required this.color, this.child, this.begin, this.end});
  final List<Color> color;
  final Widget ? child;
  final Alignment ? begin ;
  final Alignment ? end ;
  @override
  State<Cstomgradient> createState() => _CstomgradientState();
}

class _CstomgradientState extends State<Cstomgradient> {
  @override
  Widget build(BuildContext context) {
    return ShaderMask(
                  blendMode: BlendMode.srcIn,
                  shaderCallback: (Rect bounds) => LinearGradient(
                    begin: widget.begin ?? Alignment.topCenter,
                    end: widget.end ?? Alignment.bottomCenter,
                    colors:widget.color,

                  ).createShader(bounds), child:widget.child,);
  }
}