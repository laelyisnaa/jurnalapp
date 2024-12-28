import 'package:flutter/material.dart';

// Main Entry Point
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'JurnalApp',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: UserHomePage(name: 'John Doe'), // Ganti dengan nama pengguna yang sebenarnya setelah login
    );
  }
}

// UserHomePage
class UserHomePage extends StatelessWidget {
  final String name;

  UserHomePage({required this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome $name'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Greeting Banner
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Text(
                'Hello, $name!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
              ),
            ),
            
            // Quick Access Options
            Text(
              'Quick Access',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.grey[700],
              ),
            ),
            const SizedBox(height: 10),

            // Quick Access Cards (Menu Options)
            _buildOption(
              context,
              icon: Icons.article,
              title: 'View Journals',
              onTap: () {
                // Navigate to Journals Page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => JournalsPage()),
                );
              },
            ),
            _buildOption(
              context,
              icon: Icons.account_circle,
              title: 'Profile',
              onTap: () {
                // Navigate to Profile Page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfilePage()),
                );
              },
            ),
            _buildOption(
              context,
              icon: Icons.settings,
              title: 'Settings',
              onTap: () {
                // Navigate to Settings Page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SettingsPage()),
                );
              },
            ),
            _buildOption(
              context,
              icon: Icons.logout,
              title: 'Logout',
              onTap: () {
                // Handle Logout
                _logout(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  // Custom widget for each option
  Widget _buildOption(BuildContext context, {required IconData icon, required String title, required VoidCallback onTap}) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      elevation: 5.0,
      child: ListTile(
        leading: Icon(
          icon,
          size: 30.0,
          color: Colors.blueAccent,
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w600,
          ),
        ),
        trailing: Icon(Icons.arrow_forward_ios),
        onTap: onTap,
      ),
    );
  }

  // Handle Logout
  void _logout(BuildContext context) {
    // Here, you can clear user data and redirect to login page
    // Example:
    // final prefs = await SharedPreferences.getInstance();
    // await prefs.clear();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()), // Redirect to Login Page
    );
  }
}


class JournalsPage extends StatelessWidget {
  final List<Map<String, String>> journals = [
    {
      'title': 'The Impact of Flutter on Mobile Development',
      'author': 'John Doe',
      'year': '2023',
      'abstract': 'This journal discusses the impact of Flutter as a mobile development framework and its growing popularity...',
    },
    {
      'title': 'Exploring AI in Healthcare',
      'author': 'Jane Smith',
      'year': '2022',
      'abstract': 'AI in healthcare is revolutionizing patient care. This paper explores how AI is being implemented in diagnostics...',
    },
    {
      'title': 'Future of Blockchain Technology',
      'author': 'Mark Johnson',
      'year': '2021',
      'abstract': 'Blockchain has evolved beyond cryptocurrency. This article discusses its potential applications in various industries...',
    },
    {
      'title': 'Understanding Quantum Computing',
      'author': 'Alice Williams',
      'year': '2024',
      'abstract': 'Quantum computing is on the brink of a major breakthrough. This journal explores the theoretical and practical aspects...',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Journals'),
      ),
      body: ListView.builder(
        itemCount: journals.length,
        itemBuilder: (context, index) {
          final journal = journals[index];

          return Card(
            margin: EdgeInsets.all(10),
            child: ExpansionTile(
              title: Text(
                journal['title'] ?? '',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              subtitle: Text(
                'by ${journal['author'] ?? ''} (${journal['year'] ?? ''})',
                style: TextStyle(color: Colors.grey),
              ),
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    journal['abstract'] ?? '',
                    style: TextStyle(fontSize: 14),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}



class ProfilePage extends StatelessWidget {
  // Dummy user profile data
  final Map<String, String> userProfile = {
    'profilePhoto': 'https://raw.githubusercontent.com/laelyisnaa/image-url/refs/heads/main/WhatsApp%20Image%202024-12-28%20at%2014.03.12.jpeg', // URL for profile photo
    'username': 'Laely Isna',
    'address': 'Sokaraja lor',
    'gender': 'Perempuan',
    'phone': '085712113924',
    'email': 'isna@gmail.com',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
            // Profile Picture and Username
            Row(
              children: <Widget>[
                CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage(userProfile['profilePhoto']!),
                ),
                const SizedBox(width: 20),
                Text(
                  userProfile['username']!,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Profile Details
            ListTile(
              leading: const Icon(Icons.location_on),
              title: Text('Address'),
              subtitle: Text(userProfile['address']!),
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: Text('Gender'),
              subtitle: Text(userProfile['gender']!),
            ),
            ListTile(
              leading: const Icon(Icons.phone),
              title: Text('Phone Number'),
              subtitle: Text(userProfile['phone']!),
            ),
            ListTile(
              leading: const Icon(Icons.email),
              title: Text('Email Address'),
              subtitle: Text(userProfile['email']!),
            ),
          ],
        ),
      ),
    );
  }
}



// SettingsPage (Example)
class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Center(
        child: Text('This is the Settings page.'),
      ),
    );
  }
}

// LoginPage (For Logging Out)
class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Handle Login Action
            // For example, if login is successful, navigate to UserHomePage
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => UserHomePage(name: 'John Doe')), // Ganti dengan nama yang diterima setelah login
            );
          },
          child: Text('Login'),
        ),
      ),
    );
  }
}
