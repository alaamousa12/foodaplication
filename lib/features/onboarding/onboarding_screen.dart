import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:itiflutter/features/home/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});
  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final List<String> title = [
    'Save Your\nMeals\nIngredient',
    'Use Our App\nThe Best\nChoice',
    'Our App\nYour Ultimate\nChoice',
  ];
  final List<String> subtitle = [
    'Add Your Meals and its Ingredients\nand we will save it for you',
    'the best choice for your kitchen\ndo not hesitate',
    'All the best restaurants and their top\nmenus are ready for you',
  ];
  final CarouselSliderController controller = CarouselSliderController();
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/jpg/imageFood.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            bottom: 30,
            left: 32,
            right: 32,
            child: GestureDetector(
              onTap: () {},
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 32),
                height: 400,
                width: 311,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(48),
                  color: Colors.orange.withOpacity(0.9),
                ),
                child: CarouselSlider(
                  carouselController: controller,
                  options: CarouselOptions(
                    height: 470,
                    disableCenter: true,
                    viewportFraction: 1,
                    onPageChanged: (index, reason) {
                      setState(() {
                        currentIndex = index;
                      });
                    },
                  ),
                  items: List.generate(title.length, (index) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Column(
                          children: [
                            SizedBox(height: 20),
                            Text(
                              title[index],
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 23,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 20),
                            Text(
                              subtitle[index],
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(height: 18),
                            DotsIndicator(
                              dotsCount: title.length,
                              position: currentIndex.toDouble(),
                              onTap: (index) {
                                controller.animateToPage(index);
                              },
                              decorator: DotsDecorator(
                                size: Size(30, 10),
                                color: Color(0xffC2c2c2),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                activeColor: Colors.white,
                                activeSize: Size(30, 10),
                                activeShape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                            ),
                            Spacer(),
                            currentIndex == 2
                                ? InkWell(
                                    onTap: () async {
                                      final SharedPreferences prefs =
                                          await SharedPreferences.getInstance();
                                      prefs.setBool('onboarding', false);
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => HomeScreen(),
                                        ),
                                      );
                                    },
                                    child: CircleAvatar(
                                      backgroundColor: Colors.white,
                                      radius: 33,
                                      child: Icon(
                                        Icons.arrow_forward,
                                        color: Colors.orange,
                                      ),
                                    ),
                                  )
                                : Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      InkWell(
                                        onTap: () async {
                                          final SharedPreferences prefs =
                                              await SharedPreferences.getInstance();
                                          prefs.setBool('isfirst', false);
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  HomeScreen(),
                                            ),
                                          );
                                        },
                                        child: Text(
                                          'Skip',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          if (currentIndex < 2) {
                                            currentIndex++;
                                            controller.animateToPage(
                                              currentIndex,
                                            );
                                          }
                                        },
                                        child: Text(
                                          'Next',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                            SizedBox(height: 30),
                          ],
                        );
                      },
                    );
                  }),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
