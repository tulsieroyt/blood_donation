import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/home/banner_controller.dart';

class BannerCarousel extends StatefulWidget {
  const BannerCarousel({
    super.key,
    this.height,
  });

  final double? height;

  @override
  State<BannerCarousel> createState() => _BannerCarouselState();
}

class _BannerCarouselState extends State<BannerCarousel> {
  final bannerController = Get.put(BannerController());
  final ValueNotifier<int> _currentIndex = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(() {
          // Ensure that the banner list is not empty
          if (bannerController.bannerList.isEmpty) {
            return const Center(
              child: Text("No banners available"),
            );
          }

          return CarouselSlider(
            options: CarouselOptions(
              height: widget.height ?? 180.0,
              onPageChanged: (index, reason) {
                _currentIndex.value = index;
              },
              viewportFraction: 1,
            ),
            // Map the banner list to build the widgets
            items: bannerController.bannerList.map((banner) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 8.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.redAccent),
                  image: DecorationImage(
                    image: NetworkImage(banner.bannerUrl),
                    // Use banner URL to load image
                    fit: BoxFit.cover,
                  ),
                ),
              );
            }).toList(),
          );
        }),
        const SizedBox(
          height: 6,
        ),
        // Dots Indicator
        ValueListenableBuilder<int>(
          valueListenable: _currentIndex,
          builder: (context, index, _) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 0; i < bannerController.bannerList.length; i++)
                  Container(
                    height: 12,
                    width: 12,
                    margin: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                        color:
                            i == index ? Colors.redAccent : Colors.transparent,
                        border: Border.all(
                          color: i == index
                              ? Colors.redAccent
                              : Colors.grey.shade400,
                        ),
                        borderRadius: BorderRadius.circular(30)),
                  ),
              ],
            );
          },
        )
      ],
    );
  }
}
