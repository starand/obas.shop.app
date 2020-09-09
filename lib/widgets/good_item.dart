import 'package:flutter/material.dart';
import '../widgets/cached_image.dart';

class GoodItem extends StatefulWidget {
  final String title;
  final int goodId;
  final String imageUrl;

  GoodItem({
    @required Key key,
    @required this.title,
    @required this.goodId,
    @required this.imageUrl,
  }) : super(key: key);

  @override
  _GoodItemState createState() => _GoodItemState();
}

class _GoodItemState extends State<GoodItem> {
  void _selectGood(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(
      '/good',
      arguments: {
        'id': widget.goodId,
        'title': widget.title,
        'image': widget.imageUrl,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _selectGood(context),
      splashColor: Theme.of(context).primaryColor,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 4,
        margin: const EdgeInsets.only(bottom: 10),
        child: Column(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Hero(
                    tag: widget.goodId,
                    child: CachedImage(widget.imageUrl),
                  ),
                ),
                Positioned(
                  bottom: 10,
                  right: 10,
                  child: Container(
                    width: 300,
                    color: Colors.black54,
                    padding: const EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 20,
                    ),
                    child: Text(
                      widget.imageUrl,
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                      softWrap: true,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
