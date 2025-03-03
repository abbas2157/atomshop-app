import 'dart:async';
import 'package:atomshop/common/widgets/loading.dart';
import 'package:atomshop/features/home/controller/slider_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePageSliderWidget extends StatefulWidget {
  const HomePageSliderWidget({super.key});

  @override
  HomePageSliderWidgetState createState() => HomePageSliderWidgetState();
}

class HomePageSliderWidgetState extends State<HomePageSliderWidget> {
  final SliderController sliderController = Get.put(SliderController());
  final PageController _pageController = PageController();
  int _currentPage = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_currentPage < sliderController.sliderList.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0; // Loop back
      }
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (sliderController.isLoading.value) {
        return SizedBox(
          height: MediaQuery.sizeOf(context).height * 0.16,
          child: const ShimmerLoading(height: 180),
        );
      }

      if (sliderController.sliderList.isEmpty) {
        return const Center(child: Text("No sliders available"));
      }

      return SizedBox(
        height: MediaQuery.sizeOf(context).height * 0.16,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            PageView.builder(
              controller: _pageController,
              onPageChanged: (int page) {
                setState(() {
                  _currentPage = page;
                });
              },
              itemCount: sliderController.sliderList.length,
              itemBuilder: (context, index) {
                var slider = sliderController.sliderList[index];
                return ClipRRect(
                  child: CachedNetworkImage(
                    imageUrl: slider['picture'],
                    width: double.infinity,
                    height: 180,
                    fit: BoxFit.fill,
                    placeholder: (context, url) =>
                        const ShimmerLoading(height: 180),
                    errorWidget: (context, url, error) => Container(
                      height: 180,
                      color: Colors.grey[200],
                      child: const Center(child: Icon(Icons.broken_image)),
                    ),
                  ),
                );
              },
            ),
            // Dots Indicator
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white54,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(sliderController.sliderList.length, (index) {
                      return Container(
                        width: 8.0,
                        height: 8.0,
                        margin: const EdgeInsets.symmetric(horizontal: 4.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _currentPage == index ? Colors.black : Colors.white,
                        ),
                      );
                    }),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
