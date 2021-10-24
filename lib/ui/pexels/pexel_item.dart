import 'package:alpha_store/models/photo.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


class PhotoItemView extends StatelessWidget {
  const PhotoItemView({
    Key? key,
    required this.item,
  }) :  super(key: key);

  final Photo item;

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Card(
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CachedNetworkImage(
            imageUrl: item.src.medium,
            height: 200,
            fit: BoxFit.cover,
            width: double.maxFinite,
            placeholder: (context, url) => Center(child: Container(
              color: Colors.grey[200],
              height: 200,
              width:  double.maxFinite,
            )),
            errorWidget: (context, url, error) {
              debugPrint('error: $error');
              return Icon(Icons.error);
            },
          ),
        ),
      ),
    );
  }
}

class PexelsItem extends StatelessWidget {
  const PexelsItem({
    Key? key,
    this.onTap,
    this.selected = false,
    required this.animation,
    required this.item,
  }) :  super(key: key);

  final Animation<double> animation;
  final VoidCallback? onTap;
  final Photo item;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.headline4!;
    if (selected) {
      textStyle = textStyle.copyWith(color: Colors.lightGreenAccent[400]);
    }
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: SizeTransition(
        axis: Axis.vertical,
        sizeFactor: animation,
        child: Card(
          elevation: 0,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CachedNetworkImage(
              imageUrl: item.src.medium,
              height: 200,
              fit: BoxFit.cover,
              width: double.maxFinite,
              placeholder: (context, url) => Center(child: Container(
                color: Colors.grey[200],
                height: 200,
                width:  double.maxFinite,
              )),
              errorWidget: (context, url, error) {
                debugPrint('error: $error');
                return Icon(Icons.error);
              },
            ),
          ),
        ),
      ),
    );
  }
}