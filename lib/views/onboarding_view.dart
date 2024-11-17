import 'package:flutter/material.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  _OnboardingViewState createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  int _currentPage = 0;
  PageController _pageController = PageController(initialPage: 0);

  final List<Map<String, String>> onboardingData = [
    {
      "image": "assets/images/cat&vet.jpg", // Ensure the image is optimized
      "title": "Welcome to Pet Health",
      "description": "Manage your pet’s health effortlessly with a few taps."
    },
    {
      "image": "assets/images/catScan.jpg",
      "title": "Scan Symptoms Easily",
      "description": "Quickly scan and monitor your pet’s symptoms."
    },
    {
      "image": "assets/images/cat&HR.png",
      "title": "Get Accurate Diagnosis",
      "description": "Receive accurate health reports tailored for your pet."
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (value) {
                  setState(() {
                    _currentPage = value;
                  });
                },
                itemCount: onboardingData.length,
                itemBuilder: (context, index) => OnboardingContent(
                  image: onboardingData[index]["image"]!,
                  title: onboardingData[index]["title"]!,
                  description: onboardingData[index]["description"]!,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                onboardingData.length,
                (index) => buildDot(index),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/home');
                    },
                    child: const Text(
                      "Skip",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_currentPage == onboardingData.length - 1) {
                        // TODO: Navigate to the next screen (e.g., home screen)
                        Navigator.pushReplacementNamed(context, '/home');
                      } else {
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.ease,
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.yellow.shade700,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: Text(
                      _currentPage == onboardingData.length - 1
                          ? "Get Started"
                          : "Next",
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  AnimatedContainer buildDot(int index) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.only(right: 8),
      height: 12,
      width: _currentPage == index ? 25 : 12,
      decoration: BoxDecoration(
        color: _currentPage == index ? Colors.yellow.shade700 : Colors.grey,
        borderRadius: BorderRadius.circular(6),
      ),
    );
  }
}

class OnboardingContent extends StatelessWidget {
  final String image, title, description;

  const OnboardingContent({
    super.key,
    required this.image,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Image: High-quality image, optimized for mobile screens
        Container(
          height: _height * 0.54,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.vertical(
              bottom: Radius.circular(30),
            ),
            border: Border.all(
              width: 2,
              color: Colors.black,
            ),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(
                image,
              ),
            ),
          ),
        ),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            children: [
              const SizedBox(height: 15),
              // Title: Large, bold, and eye-catching
              Text(
                title,
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              // Description: Smaller, lighter font for readability
              Text(
                description,
                textAlign: TextAlign.center,
                style: TextStyle(
                  height: 1.5,
                  letterSpacing: 1.2,
                  wordSpacing: 3,
                  fontSize: 17,
                  fontStyle: FontStyle.italic,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
