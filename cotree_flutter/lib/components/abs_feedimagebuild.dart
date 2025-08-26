import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class AbsFeedimagebuild extends StatelessWidget {
  final List<String> imageUrls;
  final double borderRadius;

  const AbsFeedimagebuild({
    super.key,
    required this.imageUrls,
    this.borderRadius = 12,
  });

  bool isNetworkImage(String url) => url.startsWith('http');

  @override
  Widget build(BuildContext context) {
    final display = imageUrls.length > 4 ? imageUrls.sublist(0, 4) : imageUrls;
    final more = imageUrls.length - 4;

    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: AspectRatio(
        aspectRatio: 1,
        child: display.length == 1
            ? _thumb(context, display, 0)
            : Row(
                children: [
                  Expanded(flex: 2, child: _thumb(context, display, 0)),
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: List.generate(3, (i) {
                        if (i + 1 >= display.length) return const SizedBox();
                        final isLast = i == 2 && more > 0;
                        return Expanded(
                          child: _thumb(context, display, i + 1,
                              overlayCount: isLast ? more : null),
                        );
                      }),
                    ),
                  )
                ],
              ),
      ),
    );
  }

  Widget _thumb(BuildContext context, List<String> list, int idx,
      {int? overlayCount}) {
    return GestureDetector(
      onTap: () => _openCarousel(context, idx),
      child: Stack(children: [
        _buildImage(list[idx]),
        if (overlayCount != null)
          Container(
            color: Colors.black.withValues(alpha: 0.4),
            alignment: Alignment.center,
            child: Text('+$overlayCount',
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold)),
          ),
      ]),
    );
  }

  Widget _buildImage(String url) {
    return isNetworkImage(url)
        ? CachedNetworkImage(
            imageUrl: url,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
            errorWidget: (_, __, ___) => Container(
                color: Colors.grey, child: const Icon(Icons.broken_image)))
        : Image.file(File(url),
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
            errorBuilder: (_, __, ___) => Container(
                color: Colors.grey, child: const Icon(Icons.broken_image)));
  }

  void _openCarousel(BuildContext context, int initialIndex) {
    final controller = CarouselSliderController();
    final items = imageUrls.map((url) {
      return isNetworkImage(url)
          ? CachedNetworkImage(imageUrl: url, fit: BoxFit.contain)
          : Image.file(File(url), fit: BoxFit.contain);
    }).toList();

    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(backgroundColor: Colors.black),
        body: CarouselSlider(
          items: items,
          carouselController: controller,
          options: CarouselOptions(
            initialPage: initialIndex,
            enableInfiniteScroll: false,
            enlargeCenterPage: true,
            autoPlay: false,
            height: double.infinity,
            viewportFraction: 1.0,
            onPageChanged: (index, reason) => debugPrint('Page $index'),
          ),
        ),
      );
    }));
  }
}
