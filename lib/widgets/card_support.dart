import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

class CardSupport extends StatelessWidget {
  final String? category;
  final String? image;

  CardSupport(
      {this.category,
        this.image,});

  static const whatappURL = "https://wa.me/2348132515543";
  static const callURL = "tel:+2348132515543";
  static const emailURL = "mailto:support@cashmore.ng?subject=&body=";
  static const twitterURL = 'https://twitter.com/CashMore_NG';
  static const instagramURL = 'https://www.instagram.com/cashmore_nigeria/';
  static const facebookURL = 'https://www.facebook.com/CashMoreNigeria';


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        if(category == "Talk to us on Whatsapp"){
          await launch(whatappURL, forceSafariVC: false);
        }else if(category == "Give us a Call"){

          if (await canLaunch(callURL)) {
            await launch(callURL);
          } else {
            throw 'Could not launch $callURL';
          }
        }else if(category == "Send us a Mail"){

          await launch(emailURL, forceSafariVC: false);
        }else if(category == "Follow on Twitter"){
          await launch(twitterURL, forceSafariVC: false);
        }else if(category == "Follow on Instagram"){
          await launch(instagramURL, forceSafariVC: false);

        }else if(category == "Like on Facebook"){
          await launch(facebookURL, forceSafariVC: false);
        }

      },
      child: Card(
        color: Colors.white,
        elevation: 1.0,
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SvgPicture.asset(
                    image!,
                  ),
                  SizedBox(height: 30.0),
                  Text(
                    category!,
                    style: new TextStyle(
                        fontFamily: 'Pop',
                        fontSize: 14.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}