import 'package:flutter/material.dart';
import '../models/image_cache.dart' as cache;
import 'dart:io';
import '../models/auth_service.dart' show AuthService;

class CachedImage extends StatefulWidget {
  final String imageUrl;
  final double height;

  const CachedImage(
    this.imageUrl, {
    this.height = 200,
  });

  @override
  _CachedImageState createState() => _CachedImageState();
}

class _CachedImageState extends State<CachedImage> {
  @override
  Widget build(BuildContext context) {
    final authToken = AuthService.getIdTokenAsync ?? '';
    print('authToken = $authToken');
    return FutureBuilder<String>(
      future: cache.ImageCache.loadImage(widget.imageUrl),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            height: widget.height,
            width: double.infinity,
            child: Center(
              child: CircularProgressIndicator(),
            ),
            color: Theme.of(context).backgroundColor,
          );
        } else {
          if (!snapshot.hasData || snapshot.data.isEmpty) {
            return Image.network(
              'widget.imageUrl',
              headers: {
                "Authorization": "Bearer $authToken",
              },
              height: widget.height,
              width: double.infinity,
              fit: BoxFit.fitWidth,
            );
          } else {
            return Image.file(
              File(snapshot.data),
              height: widget.height,
              width: double.infinity,
              fit: BoxFit.fitWidth,
            );
          }
        }
      },
    );
  }
}
