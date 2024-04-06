import 'package:flutter/material.dart';
import 'package:periods/themes/text_styles.dart';

class CustomSnackbar extends StatelessWidget {
  const CustomSnackbar({
    super.key,
    required this.title,
    required this.subTitle,
    required this.color,
  });

  final String title;
  final String subTitle;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          padding: const EdgeInsets.all(
            16,
          ),
          height: 90,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(
              20,
            ),
          ),
          child: Row(
            children: [
              const SizedBox(
                width: 130,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                        style: semiBold.copyWith(
                          fontSize: 16,
                          color: Colors.white,
                        )),
                    const SizedBox(
                      height: 3,
                    ),
                    Text(
                      subTitle,
                      style: regularFont.copyWith(
                          color: Colors.white, fontSize: 12),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: -15,
          child: Image.asset(
            'assets/clock.png',
            fit: BoxFit.contain,
            height: 110,
            width: 150,
          ),
        )
      ],
    );
  }
}
