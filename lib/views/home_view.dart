import '../utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'health_record_view.dart';
import 'profile_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _currentIndex = 0;

  // List of pages for the Bottom Navigation Bar
  final List<Widget> _pages = [
    const HomeDashboard(),
    const HealthRecordsView(),
    const ProfileView(),
  ];

  final List<String> _pagesNames = const ['Home', 'Health Records', 'Profile'];

  // Function to log out
  void _logout() async {
    // Perform logout logic
    // Step 1: Clear any stored user session or preferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs
        .clear(); // Clear the shared preferences (for example, user tokens)

    // Step 2: Navigate to the login page after clearing data
    Navigator.pushReplacementNamed(
        context, '/login'); // Replace current route with the login route
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pagesNames[_currentIndex]),
        centerTitle: true,
        actions: _pagesNames[_currentIndex] == 'Profile' ? [IconButton(
          icon: const Icon(Icons.logout),
          onPressed: _logout, // Log out when tapped
        ),]: [],
      ),
      // Display selected page from the bottom navigation
      body: _pages[_currentIndex],
      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels: false,
        backgroundColor: Constants.mainColor,
        currentIndex: _currentIndex,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.medical_services),
            label: 'Health Records',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}

class HomeDashboard extends StatelessWidget {
  const HomeDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 16.0,
        mainAxisSpacing: 16.0,
        children: [
          _buildFeatureCard(
            context,
            icon: Icons.camera_alt,
            title: 'Scan Symptoms',
            onTap: () {
              Navigator.pushNamed(context, '/scan');
            },
          ),
          _buildFeatureCard(
            context,
            icon: Icons.list_alt,
            title: 'Disease Library',
            onTap: () {
              Navigator.pushNamed(context, '/diseases');
            },
          ),
          _buildFeatureCard(
            context,
            icon: Icons.lightbulb,
            title: 'Vet Tips',
            onTap: () {
              Navigator.pushNamed(context, '/vettips');
            },
          ),
        ],
      ),
    );
  }

  // Helper method to build the feature card for the dashboard
  Widget _buildFeatureCard(BuildContext context,
      {required IconData icon,
      required String title,
      required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 4.0,
        color: Colors.amber.shade100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 48.0, color: Colors.orange),
            const SizedBox(height: 8.0),
            Text(
              title,
              textAlign: TextAlign.center,
              style:
                  const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}

// import 'package:cats_disease_detection/views/browse_diseases_view.dart';
// import 'package:cats_disease_detection/views/scan_view.dart';
// import 'package:flutter/material.dart';
//
// class VetRecommendationsView extends StatelessWidget {
//   const VetRecommendationsView({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return const Center(
//       child: Text('Vet Recommendations Page'),
//     );
//   }
// }
//
// class PetHealthTipsView extends StatelessWidget {
//   const PetHealthTipsView({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return const Center(
//       child: Text('Pet Health Tips Page'),
//     );
//   }
// }
//
// class HomeView extends StatefulWidget {
//   const HomeView({super.key});
//
//   @override
//   State<HomeView> createState() => _HomeViewState();
// }
//
// class _HomeViewState extends State<HomeView> {
//   int _currentIndex = 0;
//   PageController _pageController = PageController();
//
//   // List of pages corresponding to the PageView
//   final List<Widget> _pages = const [
//     ScanView(),
//     BrowseDiseasesView(),
//     VetRecommendationsView(),
//     PetHealthTipsView(),
//   ];
//
//   @override
//   void dispose() {
//     _pageController
//         .dispose(); // Dispose the controller when the widget is disposed
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Home'),
//       ),
//       drawer: Drawer(
//         child: ListView(
//           padding: EdgeInsets.zero,
//           children: <Widget>[
//             UserAccountsDrawerHeader(
//               accountName: Text("John Doe"), // Example user name
//               accountEmail: Text("john.doe@example.com"), // Example email
//               currentAccountPicture: CircleAvatar(
//                 backgroundColor: Colors.white,
//                 child: Text(
//                   "JD", // User's initials
//                   style: TextStyle(fontSize: 40.0, color: Colors.blue),
//                 ),
//               ),
//               decoration: BoxDecoration(
//                 color: Colors.amber.shade600,
//               ),
//             ),
//             ListTile(
//               leading: Icon(Icons.person),
//               title: Text('Profile'),
//               onTap: () {
//                 Navigator.pop(context); // Close the drawer
//               },
//             ),
//             Divider(), // A line separating sections
//             ListTile(
//               leading: Icon(Icons.settings),
//               title: Text('Settings'),
//               onTap: () {
//                 Navigator.pop(context); // Close the drawer
//               },
//             ),
//             ListTile(
//               leading: Icon(Icons.info_outline),
//               title: Text('About'),
//               onTap: () {
//                 Navigator.pop(context); // Close the drawer
//               },
//             ),
//             Divider(),
//             ListTile(
//               leading: Icon(Icons.logout),
//               title: Text('Logout'),
//               onTap: () {
//                 Navigator.pop(context); // Close the drawer
//               },
//             ),
//           ],
//         ),
//       ),
//       // PageView for swipeable pages
//       body: PageView(
//         controller: _pageController,
//         onPageChanged: (index) {
//           setState(() {
//             _currentIndex = index; // Update selected index when swiped
//           });
//         },
//         children: _pages, // Pages to swipe between
//       ),
//       // Optionally, if you still want to keep the BottomNavigationBar for reference or visual indicator
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: _currentIndex,
//         selectedItemColor: Colors.black,
//         unselectedItemColor: Colors.grey,
//         items: const [
//           BottomNavigationBarItem(
//             backgroundColor: Colors.amber,
//             icon: Icon(Icons.home, size: 27),
//             label: 'Home',
//           ),
//           BottomNavigationBarItem(
//             backgroundColor: Colors.amber,
//             icon: Icon(Icons.camera_alt_rounded, size: 27),
//             label: 'Scan',
//           ),
//           BottomNavigationBarItem(
//             backgroundColor: Colors.amber,
//             icon: Icon(Icons.event_note_outlined, size: 27),
//             label: 'Health Record',
//           ),
//           BottomNavigationBarItem(
//             backgroundColor: Colors.amber,
//             icon: Icon(Icons.person, size: 27),
//             label: 'Profile',
//           ),
//         ],
//         onTap: (index) {
//           setState(() {
//             _currentIndex = index;
//             _pageController.animateToPage(
//               index,
//               duration: const Duration(milliseconds: 300),
//               curve: Curves.easeInOut, // Smooth transition
//             );
//           });
//         },
//       ),
//     );
//   }
// }
//
// // import 'package:cats_disease_detection/views/browse_diseases_view.dart';
// // import 'package:cats_disease_detection/views/scan_view.dart';
// // import 'package:flutter/material.dart';
// //
// // class VetRecommendationsView extends StatelessWidget {
// //   const VetRecommendationsView({super.key});
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return const Center(
// //       child: Text('Vet Recommendations Page'),
// //     );
// //   }
// // }
// //
// // class PetHealthTipsView extends StatelessWidget {
// //   const PetHealthTipsView({super.key});
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return const Center(
// //       child: Text('Pet Health Tips Page'),
// //     );
// //   }
// // }
// //
// // class HomeView extends StatefulWidget {
// //   const HomeView({super.key});
// //
// //   @override
// //   State<HomeView> createState() => _HomeViewState();
// // }
// //
// // class _HomeViewState extends State<HomeView> {
// //   int _currentIndex = 0;
// //
// //   // List of pages corresponding to the BottomNavigationBar
// //   final List<Widget> _pages = const [
// //     ScanView(),
// //     BrowseDiseasesView(),
// //     VetRecommendationsView(),
// //     PetHealthTipsView(),
// //   ];
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text('Home'),
// //       ),
// //       // Add the Drawer here
// //       drawer: Drawer(
// //         child: ListView(
// //           padding: EdgeInsets.zero,
// //           children: <Widget>[
// //             UserAccountsDrawerHeader(
// //               accountName: Text("John Doe"), // Example user name
// //               accountEmail: Text("john.doe@example.com"), // Example email
// //               currentAccountPicture: CircleAvatar(
// //                 backgroundColor: Colors.white,
// //                 child: Text(
// //                   "JD", // User's initials
// //                   style: TextStyle(fontSize: 40.0, color: Colors.blue),
// //                 ),
// //               ),
// //               decoration: BoxDecoration(
// //                 color: Colors.amber.shade600,
// //               ),
// //             ),
// //             ListTile(
// //               leading: Icon(Icons.person),
// //               title: Text('Profile'),
// //               onTap: () {
// //                 Navigator.pop(context); // Close the drawer
// //                 setState(() {
// //                   _currentIndex = 0; // Switch to Home page
// //                 });
// //               },
// //             ),
// //             Divider(), // A line separating sections
// //             ListTile(
// //               leading: Icon(Icons.settings),
// //               title: Text('Settings'),
// //               onTap: () {
// //                 Navigator.pop(context); // Close the drawer
// //                 // Navigate to settings page or show settings dialog
// //               },
// //             ),
// //             ListTile(
// //               leading: Icon(Icons.info_outline),
// //               title: Text('About'),
// //               onTap: () {
// //                 Navigator.pop(context); // Close the drawer
// //                 // Show about information or navigate to an about page
// //               },
// //             ),
// //             Divider(),
// //             ListTile(
// //               leading: Icon(Icons.logout),
// //               title: Text('Logout'),
// //               onTap: () {
// //                 // Perform logout logic
// //                 Navigator.pop(context); // Close the drawer
// //                 // Optionally, navigate to a login page
// //               },
// //             ),
// //           ],
// //         ),
// //       ),
// //       body: _pages[_currentIndex], // Show the selected page
// //       // Bottom Navigation Bar
// //       bottomNavigationBar: BottomNavigationBar(
// //         currentIndex: _currentIndex,
// //         selectedItemColor: Colors.black,
// //         unselectedItemColor: Colors.grey,
// //         items: const [
// //           BottomNavigationBarItem(
// //             backgroundColor: Colors.amber,
// //             icon: Icon(Icons.camera_alt, size: 27),
// //             label: 'Scan Symptoms',
// //           ),
// //           BottomNavigationBarItem(
// //             backgroundColor: Colors.amber,
// //             icon: Icon(Icons.list_alt, size: 27),
// //             label: 'Browse Diseases',
// //           ),
// //           BottomNavigationBarItem(
// //             backgroundColor: Colors.amber,
// //             icon: Icon(Icons.favorite, size: 27),
// //             label: 'Vet Recommendations',
// //           ),
// //           BottomNavigationBarItem(
// //             backgroundColor: Colors.amber,
// //             icon: Icon(Icons.lightbulb, size: 27),
// //             label: 'Pet Health Tips',
// //           ),
// //         ],
// //         onTap: (index) {
// //           setState(() {
// //             _currentIndex = index; // Update selected index
// //           });
// //         },
// //       ),
// //     );
// //   }
// // }
