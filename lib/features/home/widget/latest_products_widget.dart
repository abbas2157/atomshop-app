import 'package:atomshop/extenstion/alignment_extension.dart';
import 'package:atomshop/features/home/model/latest_products_model.dart';
import 'package:atomshop/style/text_style/text_style.dart';
import 'package:flutter/material.dart';

class LatestProductsWidget extends StatelessWidget {
  const LatestProductsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        // physics: const NeverScrollableScrollPhysics(), // Prevents scrolling conflict
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // 2 items per row
          crossAxisSpacing: 10,
          mainAxisSpacing: 0,
          childAspectRatio: 0.67, // Adjust height-to-width ratio
        ),
        itemCount: latestProducts.length, // Replace with your product list
        itemBuilder: (context, index) {
          final product = latestProducts[index]; // Get product item
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 180,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: product.backgroundColor
                    // border: Border.all(
                    //     color: const Color(0xffF4F5FD), width: 2),
                    ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.black,
                      child: Center(
                        child: Icon(
                          Icons.favorite_border,
                          color: Colors.white,
                        ),
                      ),
                    ).alignTopRight(),
                    Image.asset(
                      product.image,
                      height: 100,
                      // width: 0,
                      fit: BoxFit.cover,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  ProductColorWidget(
                    colors: product.colors,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "All ${product.colors.length} Colors",
                    style: TextStyle(decoration: TextDecoration.underline),
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                product.name,
                style: AppTextStyles.headline3,
              ),
              Text(
                "\$${product.price}",
              ),
                 Text(
              "\$${product.discountedPrice}",style: AppTextStyles.normal.copyWith(color: Color(0xffC0C0C0),decoration: TextDecoration.lineThrough,decorationColor: Color(0xffC0C0C0)),
           
              )
            ],
          );
        },
      ),
    );
  }
}

class ProductColorWidget extends StatelessWidget {
  final List<Color> colors;

  const ProductColorWidget({super.key, required this.colors});

  @override
  Widget build(BuildContext context) {
    int maxColorsToShow = 3;
    bool hasMoreColors = colors.length > maxColorsToShow;

    return SizedBox(
      width: hasMoreColors ? 50 : (colors.length * 20).toDouble(),
      height: 24,
      child: Stack(
        children: [
          // Show up to 3 colors, slightly overlapping
          for (int i = 0;
              i < (hasMoreColors ? maxColorsToShow : colors.length);
              i++)
            Positioned(
              left: i * 15.0, // Adjust this value to control overlap
              child: CircleAvatar(
                radius: 12,
                backgroundColor: colors[i],
                child: colors[i] == Colors.white
                    ? Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.black, width: 1),
                        ),
                      )
                    : null,
              ),
            ),

          // Show "+X" if more than 3 colors exist
          if (hasMoreColors)
            Positioned(
              left: maxColorsToShow * 15.0,
              child: CircleAvatar(
                radius: 12,
                backgroundColor: Colors.grey[300],
                child: Text(
                  "+${colors.length - maxColorsToShow}",
                  style: const TextStyle(
                      fontSize: 10, fontWeight: FontWeight.bold),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
