import 'dart:io';

import 'package:flutter/material.dart';
import 'package:openvpn/presentations/widget/impl/app_body_text.dart';
import 'package:openvpn/presentations/widget/impl/app_buttons.dart';
import 'package:openvpn/presentations/widget/impl/app_label_text.dart';
import 'package:openvpn/resources/assets.gen.dart';
import 'package:openvpn/resources/colors.dart';
import 'package:openvpn/resources/strings.dart';
import 'package:openvpn/utils/config.dart';
import 'package:url_launcher/url_launcher.dart';


Future<void> _launchURL(String link) async {
  final url = Uri.parse(link);
  await launchUrl(url, mode: LaunchMode.externalApplication);
}
class RatingDialog extends StatefulWidget {
  const RatingDialog({super.key});

  @override
  _RatingDialogState createState() => _RatingDialogState();
}

class _RatingDialogState extends State<RatingDialog> {
  int _rating = 5;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.scaffoldBackgroundColor,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            child: Image.asset(
              Assets.images.frame.path,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const AppBodyText(
            text: 'Do you like ${Strings.Unlimited} ?',
            textAlign: TextAlign.center,
            size: 20,
            color: AppColors.colorBlue,
          ),
          AppBodyText(
            text: Platform.isIOS
                ? 'Tap a star to rate on the App Store'
                : 'Tap a star to rate on the Google Play',
            textAlign: TextAlign.center,
            size: 14,
            color: AppColors.colorBlue,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (int i = 1; i <= 5; i++)
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _rating = i;
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: i <= _rating
                        ? Assets.icons.icStar2.svg(width: 35)
                        : Assets.icons.icStar1.svg(width: 35),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 16),
          AppButtons(
            text: 'Send Feedback',
            textColor: AppColors.primary,
            backgroundColor: Colors.transparent,
            onPressed: () {
              Navigator.of(context).pop();
              debugPrint('User rated: $_rating stars');
              if (_rating > 3) {
                _launchURL(Config.storeAppUrl);
                // StoreRedirect.redirect(
                //   androidAppId: "com.Padoventi.JackpotVPN",
                // );
              }
            },
          ),
          const SizedBox(height: 10),
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: AppLabelText(
                size: 20,
                text: 'Not now',
                color: AppColors.colorBlue,
              ),
            ),
          )
        ],
      ),
    );
  }
}

