import 'package:app_store/extensions/iterable_extensions.dart';
import 'package:flutter/cupertino.dart';

class RatingBar extends StatelessWidget {
  const RatingBar({
    super.key,
    this.total = 5,
    required this.value,
    this.size = 12,
    this.color = const Color(0xFFFBC02D),
    this.spacing = 0,
  });

  final int total;
  final double value;
  final double size;
  final Color color;
  final double spacing;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List<Widget>.generate(total, _buildStar)
            .divide(SizedBox(width: spacing)),
      ),
    );
  }

  Widget _buildStar(int index) {
    double fraction = value - index;
    if (fraction < 0.0) {
      fraction = 0.0;
    } else if (fraction > 1.0) {
      fraction = 1.0;
    }

    return Stack(
      children: <Widget>[
        Icon(
          CupertinoIcons.star,
          size: size,
          color: color,
        ),
        ClipRect(
          clipper: _StarClipper(fraction),
          child: Icon(
            CupertinoIcons.star_fill,
            size: size,
            color: color,
          ),
        ),
      ],
    );
  }
}

class _StarClipper extends CustomClipper<Rect> {
  const _StarClipper(this.fraction) : assert(fraction >= 0 && fraction <= 1);

  final double fraction;

  @override
  Rect getClip(Size size) {
    return Rect.fromLTWH(0, 0, size.width * fraction, size.height);
  }

  @override
  bool shouldReclip(covariant _StarClipper oldClipper) {
    return fraction != oldClipper.fraction;
  }
}
