import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutterwarehouseapp/src/themes/theme_color.dart';

class ImageNetworkWidget extends StatelessWidget {
  final String uri;
  final BoxFit fit;
  final double width;
  final double height;

  const ImageNetworkWidget({ Key key,
    this.uri,
    this.fit,
    this.width = 100,
    this.height = 100
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (uri == null || uri.isEmpty)
      return Image.network(
        'https://www.trendsetter.com/pub/media/catalog/product/placeholder/default/no_image_placeholder.jpg',
        fit: fit ?? BoxFit.cover,
      );
    return CachedNetworkImage(
      height: height,
      width: width,
      imageUrl: uri,
      fit: fit ?? BoxFit.cover,
      progressIndicatorBuilder: (
        context,
        url, downloadProgress,
      ) =>
          Center(
        child: CircularProgressIndicator(
          value: downloadProgress.progress,
          valueColor: AlwaysStoppedAnimation<Color>(
              AppColor.primaryColor),
        ),
      ),
      errorWidget: (context, url, error) => Center(
        child: Icon(
          Icons.error,
          color: AppColor.primaryColor,
        ),
      ),
    );
  }
}
