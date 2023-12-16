import 'package:coffee_shopapp/home_screen.dart';
import 'package:coffee_shopapp/login.dart';

import 'package:coffee_shopapp/otp.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class onbording extends StatefulWidget {
  @override
  State<onbording> createState() => _onbordingState();
}

class _onbordingState extends State<onbording> {
  final controller = PageController();
  bool isLastPage = false;
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Widget buildPage({
    required Color color,
    required String urlImage,
    required String title,
    required String subtitle,
  }) =>
      Container(
        color: color,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              urlImage,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
            const SizedBox(
              height: 64,
            ),
            Text(
              title,
              style: TextStyle(
                  color: Colors.teal.shade700,
                  fontSize: 40,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 6,
              ),
              child: Text(
                subtitle,
                style: const TextStyle(color: Colors.black),
              ),
            )
          ],
        ),
      );

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Container(
          padding: const EdgeInsets.only(bottom: 80),
          child: PageView(
            controller: controller,
            onPageChanged: (index) {
              setState(() => isLastPage = index == 2);
            },
            children: [
              buildPage(
                  color: const Color.fromARGB(255, 220, 237, 220),
                  urlImage: 'assets/images/on1.png',
                  title: 'Hello',
                  subtitle:
                      'While you’ve probably put effort into sourcing, shortlisting, and selecting the right baristas to work in your café, you’ll need to pay just as much attention to their onboarding to make sure'),
              buildPage(
                  color: const Color.fromARGB(255, 220, 237, 220),
                  urlImage: 'assets/images/on2.png',
                  title: 'GoodDay',
                  subtitle:
                      'stores aren’t immune, with Starbucks allegedly spending 3000 to replace a single barista in its USA branches. For coffee shops with smaller budgets, this cost could be even higher.'),
              buildPage(
                  color: const Color.fromARGB(255, 220, 237, 220),
                  urlImage: 'assets/images/on3.png',
                  title: 'Welcome',
                  subtitle:
                      'oor portion control when preparing drinks costing you money, as well as more expensive issues that could result from them being unaware of how to properly maintain or use your grinding equipment.'),
            ],
          ),
        ),
        bottomSheet: isLastPage
            ? SizedBox(
                child: TextButton(
                  style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      primary: Colors.white,
                      backgroundColor: Colors.teal.shade700,
                      minimumSize: const Size.fromHeight(80)),
                  child: const Text(
                    'Get Started',
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: () async {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  },
                ),
              )
            : Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                height: 80,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      child: const Text('skip'),
                      onPressed: () => controller.jumpToPage(2),
                    ),
                    Center(
                      child: SmoothPageIndicator(
                        controller: controller,
                        count: 3,
                        effect: WormEffect(
                            spacing: 16,
                            dotColor: Colors.black26,
                            activeDotColor: Colors.teal.shade700),
                        onDotClicked: (index) => controller.animateToPage(index,
                            duration: const Duration(microseconds: 500),
                            curve: Curves.easeIn),
                      ),
                    ),
                    TextButton(
                      child: const Text('next'),
                      onPressed: () => controller.nextPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                      ),
                    ),
                  ],
                ),
              ),
      );
}
