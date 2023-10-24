import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

import 'package:mallxx_app/const/colors.dart';

class PhotoPreView extends StatefulWidget {
  const PhotoPreView({
    Key? key,
    required this.index,
    required this.images,
  }) : super(key: key);
  final int index;
  final List<String> images;

  @override
  _PhotoPreViewState createState() => _PhotoPreViewState();
}

class _PhotoPreViewState extends State<PhotoPreView> {
//
  late final PageController _pageController =
      PageController(initialPage: widget.index);

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onChangePage(int index) {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GestureDetector(
            onTap: () {
              Get.back();
            },
            child: PhotoViewGallery.builder(
              scrollPhysics: const BouncingScrollPhysics(),
              onPageChanged: _onChangePage,
              itemCount: widget.images.length,
              pageController: _pageController,
              loadingBuilder: (context, event) => Center(
                child: Container(
                  width: 20.0,
                  height: 20.0,
                  child: CircularProgressIndicator(
                    value: event == null
                        ? 0
                        : event.cumulativeBytesLoaded /
                            event.expectedTotalBytes!,
                  ),
                ),
              ),
              builder: (BuildContext context, int index) {
                return PhotoViewGalleryPageOptions(
                  imageProvider: NetworkImage(widget.images[index]),
                  minScale: PhotoViewComputedScale.contained * 0.6,
                  maxScale: PhotoViewComputedScale.covered * 1.1,
                  initialScale: PhotoViewComputedScale.contained,
                );
              },
            ),
          ),
          Positioned(
            top: 50,
            left: 10,
            child: Container(
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                color: Colors.grey,
              ),
              child: GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: const Icon(
                  Icons.close_rounded,
                  color: KWhiteColor,
                  size: 30,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
