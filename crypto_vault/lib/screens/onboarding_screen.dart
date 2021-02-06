import 'package:flutter/material.dart';

import 'package:crypto_vault/constants.dart';
import 'package:crypto_vault/data/onboarding_data.dart';
import 'package:crypto_vault/widgets/onboarding_slide.dart';
import 'package:crypto_vault/widgets/custom_button.dart';
import 'package:crypto_vault/screens/home_screen.dart';

class OnboardingScreen extends StatefulWidget {
  static const routeName = '/onboarding';

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int _currPage;
  PageController _slidesController;

  @override
  void initState() {
    _currPage = 0;
    _slidesController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _slidesController.dispose();
    super.dispose();
  }

  AnimatedContainer _buildDot(int index) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      margin: EdgeInsets.only(right: 6),
      height: 8,
      width: _currPage == index ? 24 : 8,
      decoration: BoxDecoration(
        color: _currPage == index ? primaryColor : secondaryColor,
        borderRadius: BorderRadius.circular(4),
        boxShadow: [
          BoxShadow(
            color: _currPage == index ? primaryColor : secondaryColor,
            blurRadius: _currPage == index ? 4.0 : 0.0,
          ),
        ],
      ),
    );
  }

  void doneBtnPressHandler(BuildContext ctx) {
    // Navigator.of(ctx).popAndPushNamed(MyHomePage.routeName);
    Navigator.of(ctx).pushReplacementNamed(HomePage.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            height: 120,
            // color: Colors.orange,
            alignment: Alignment.bottomCenter,
            child: Image.asset(
              'assets/icons/LogoText_white.png',
              width: 256,
            ),
          ),
          Flexible(
            fit: FlexFit.tight,
            child: PageView.builder(
              controller: _slidesController,
              itemBuilder: (context, index) => OnboardingSlide(
                imageUrl: SLIDES[index].imageUrl,
                title: SLIDES[index].title,
                description: SLIDES[index].description,
              ),
              itemCount: SLIDES.length,
              onPageChanged: (val) {
                setState(() {
                  _currPage = val;
                });
              },
            ),
          ),
          Container(
            alignment: Alignment.topCenter,
            height: 56,
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                _currPage != 0
                    ? CustomButton(
                        onTap: () {
                          setState(() {
                            _slidesController.previousPage(
                              duration: Duration(milliseconds: 400),
                              curve: Curves.easeInOut,
                            );
                          });
                        },
                        text: 'PREV',
                      )
                    : SizedBox(
                        width: 89,
                      ),
                Row(
                  children: List.generate(
                    SLIDES.length,
                    (index) => _buildDot(index),
                  ),
                ),
                _currPage == SLIDES.length - 1
                    ? CustomButton(
                        onTap: () {doneBtnPressHandler(context);},
                        text: 'DONE',
                      )
                    : CustomButton(
                        onTap: () {
                          setState(() {
                            _slidesController.nextPage(
                              duration: Duration(milliseconds: 400),
                              curve: Curves.easeInOut,
                            );
                          });
                        },
                        text: 'NEXT',
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
