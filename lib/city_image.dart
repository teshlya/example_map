import 'dart:math';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:image/image.dart' as image2;


class CityImage extends StatefulWidget {
  String image;
  Point positionImage;
  CityImage(this.image, this.positionImage);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _CityImageState(image, positionImage);
  }

}

class _CityImageState extends State {
  String image;
  Point positionImage;
  _CityImageState(this.image, this.positionImage);


  @override
  Widget build(BuildContext context) {
    return _getImages(context);
  }

  _getImages(BuildContext context) =>
      Positioned(
          left: positionImage.x,
          top: positionImage.y,
          child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              child: IgnorePointer(
                  ignoring: true,
                  child: (_image())),
              onTapDown: (detail) async {
                if (!await _isColorTransparent(detail, context)) {
                  setState(() {
                    Scaffold.of(context).showSnackBar(SnackBar(
                      content: Text(image),
                    ));
                  });
                }
              }));

  _image() =>
      Image.asset(
        image,
      );

  _imageWithGradient() =>
      ShaderMask(
        child: Image.asset(
          image,
        ),
        shaderCallback: (Rect bounds) {
          return LinearGradient(
            colors: [Colors.blue[600], Colors.blue[600]],
            stops: [
              0.0,
              0.1,
            ],
          ).createShader(bounds);
        },
        blendMode: BlendMode.srcATop,
      );

  Future<bool> _isColorTransparent(TapDownDetails detail,
      BuildContext context) async {
    Offset position = _getLocalPosition(detail, context);
    image2.Image _receiptImage = await _loadImage();
    if (_receiptImage == null) return false;
    return _checkTransparent(
        _receiptImage.getPixel(position.dx.round(), position.dy.round()));
  }

  Offset _getLocalPosition(TapDownDetails detail, BuildContext context) {
    RenderBox getBox = context.findRenderObject();
    Offset local = getBox.globalToLocal(detail.globalPosition);
    return local;
  }

  Future<image2.Image> _loadImage() async {
    ByteData imageData = await rootBundle.load(image);
    List<int> bytes = Uint8List.view(imageData.buffer);
    image2.Image _receiptImage = image2.decodeImage(bytes);
    return _receiptImage;
  }

  bool _checkTransparent(int pixel) {
    if (pixel
        .toRadixString(16)
        .length == 8)
      return false;
    else
      return true;
  }
}
