import 'package:cat_disease_detection/utils/theme_manager.dart';
import 'package:cat_disease_detection/views/browse_diseases_view.dart';
import 'package:cat_disease_detection/views/health_record_view.dart';
import 'package:cat_disease_detection/views/health_tips_view.dart';
import 'package:cat_disease_detection/views/home_view.dart';
import 'package:cat_disease_detection/views/login_view.dart';
import 'package:cat_disease_detection/views/onboarding_view.dart';
import 'package:cat_disease_detection/views/profile_view.dart';
import 'package:cat_disease_detection/views/related_diseases_view.dart';
import 'package:cat_disease_detection/views/scan_view.dart';
import 'package:cat_disease_detection/views/sign_up_view.dart';
import 'package:cat_disease_detection/views/splash_view.dart';
import 'package:cat_disease_detection/views/vet_tips_view.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://mqukaugzgnqtcvgqytbi.supabase.co',
    // Replace with your Supabase project URL
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im1xdWthdWd6Z25xdGN2Z3F5dGJpIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzE4NTcxMjMsImV4cCI6MjA0NzQzMzEyM30.6VdvPkZWIsY6ek-DprVxfgxrtWa6WLesRC1KrGrrXNI', // Replace with your anon key
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({
    super.key,
  });

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeManager.lightMode,
      initialRoute: '/',
      routes: {
        // splash view
        '/': (context) => const SplashView(),
        // login view
        '/login': (context) => const LoginView(),
        // sign up view
        '/signup': (context) => SignUpView(),
        // onboarding view
        '/onboarding': (context) => const OnboardingView(),
        // Home view
        '/home': (context) => const HomeView(),
        // Scan view (Implement this)
        '/scan': (context) => const ScanDiseaseView(),
        // Browse Diseases view (Implement this)
        '/diseases': (context) => const BrowseDiseasesView(),
        // Related diseases View
        '/relateddiseases': (context) => const RelatedDiseaseView(),
        // Vet Recommendations view (Implement this)
        //'/recommendations': (context) => VetRecommendationsView(),
        // Health Tips view (Implement this)
        '/healthtips': (context) => const HealthTipsView(),
        // Health Records view (Placeholder)
        '/healthrecords': (context) => const HealthRecordsView(),
        // Profile Page view (Placeholder)
        '/profile': (context) => const ProfileView(),
        '/vettips': (context) => const VetTipsView(),
      },
      //home: const SplashView(),
    );
  }
}
