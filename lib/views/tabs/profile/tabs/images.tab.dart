import '../../../../constants/images.dart';
import '../../../../config/extensions.dart';
import 'package:flutter/material.dart';

class ImagesTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<String> data = [
      AppImages.landingBanner,
      AppImages.landingBanner2,
      AppImages.landingBanner3,
      AppImages.landingBanner4,
      AppImages.landingBanner5,
    ];
    return Container(
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
          childAspectRatio: 0.85,
        ),
        itemCount: data.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.greenAccent,
              image: DecorationImage(
                image: AssetImage(data[index]),
                fit: BoxFit.cover,
              ),
            ),
          ).fadeInList(index, false);
        },
      ),
    );
  }
}
