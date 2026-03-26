import 'package:a_one_gt/core/apptheme/apptheme.dart';
import 'package:a_one_gt/features/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

class FullScreenGalleryScreen extends StatefulWidget {
  final List<String> images;
  final int initialIndex;

  const FullScreenGalleryScreen({
    required this.images,
    required this.initialIndex,
  });

  @override
  State<FullScreenGalleryScreen> createState() =>
      _FullScreenGalleryScreenState();
}

class _FullScreenGalleryScreenState extends State<FullScreenGalleryScreen> {
  late int _current;
  late PageController _controller;
  final TransformationController _transformationController =
      TransformationController();

  TapDownDetails? _doubleTapDetails;

  @override
  void initState() {
    super.initState();
    _current = widget.initialIndex;
    _controller = PageController(initialPage: widget.initialIndex);
  }

  @override
  void dispose() {
    _controller.dispose();
    _transformationController.dispose();
    super.dispose();
  }

  void _handleDoubleTap() {
    if (_transformationController.value != Matrix4.identity()) {
      _transformationController.value = Matrix4.identity();
    } else {
      final position = _doubleTapDetails!.localPosition;
      _transformationController.value = Matrix4.identity()
        ..translate(-position.dx * 2, -position.dy * 2)
        ..scale(3.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolors.background,
      appBar: CustomAppBar(title: '${_current + 1} / ${widget.images.length}'),
      body: PageView.builder(
        controller: _controller,
        itemCount: widget.images.length,
        onPageChanged: (index) {
          setState(() {
            _current = index;
            _transformationController.value = Matrix4.identity();
          });
        },
        itemBuilder: (context, index) {
          return GestureDetector(
            onDoubleTapDown: (details) => _doubleTapDetails = details,
            onDoubleTap: _handleDoubleTap,
            child: InteractiveViewer(
              transformationController: _transformationController,
              minScale: 1,
              maxScale: 4,
              child: Center(
                child: Hero(
                  tag: 'product_image_${widget.images[index]}_$index',
                  child: Image.asset(widget.images[index], fit: BoxFit.contain),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
