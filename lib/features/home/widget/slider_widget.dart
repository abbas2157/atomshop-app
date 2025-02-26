import 'package:atomshop/common/widgets/loading.dart';
import 'package:atomshop/features/home/controller/slider_controller.dart';
import 'package:flutter/material.dart';

import 'dart:async';
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
        // Show shimmer effect when loading
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SizedBox(
            height: 180,
            child: ShimmerLoading(height: 180, borderRadius: 12),
          ),
        );
      }

      if (sliderController.sliderList.isEmpty) {
        return const Center(child: Text("No sliders available"));
      }

      return SizedBox(
        height: 180,
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
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    slider['picture'],
                    width: double.infinity,
                    height: 180,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return ShimmerLoading(height: 180, borderRadius: 12);
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 180,
                        color: Colors.grey[200],
                        child: const Center(child: Icon(Icons.broken_image)),
                      );
                    },
                  ),
                );
              },
            ),
            // Dots Indicator
            Positioned(
              right: 10,
              bottom: 10,
              child: Row(
                children:
                    List.generate(sliderController.sliderList.length, (index) {
                  return Container(
                    width: 8.0,
                    height: 8.0,
                    margin: const EdgeInsets.symmetric(horizontal: 4.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _currentPage == index
                          ? Colors.blue
                          // ignore: deprecated_member_use
                          : Colors.grey.withOpacity(0.5),
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      );
    });
  }
}
