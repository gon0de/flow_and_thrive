// lib/main.dart

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

/// Main entry point of the application.
/// Initializes Firebase and runs the Flow & Thrive app.
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Ensure Firebase is initialized.
  runApp(FlowAndThriveApp());
}

/// The main application widget.
class FlowAndThriveApp extends StatelessWidget {
  const FlowAndThriveApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flow & Thrive',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        // Iyashikei subtle aesthetic: soft pastel background, gentle fonts.
        scaffoldBackgroundColor: Colors.lightBlue[50],
        textTheme: TextTheme(
          bodyMedium: TextStyle(
            fontFamily: 'GentiumBasic', // Use a soft, calming font.
            fontSize: 16,
          ),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => OnboardingScreen(),
        '/home': (context) => HomeScreen(),
        '/task': (context) => TaskManagerScreen(),
        '/wellness': (context) => WellnessScreen(),
        '/premium': (context) => PremiumScreen(),
      },
    );
  }
}

/// OnboardingScreen: Welcomes the user and directs them to the HomeScreen.
class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Welcome to Flow & Thrive')),
      body: Center(
        child: ElevatedButton(
          child: Text('Get Started'),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/home');
          },
        ),
      ),
    );
  }
}

/// HomeScreen: Acts as the main dashboard with navigation buttons.
class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flow & Thrive Dashboard'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            NavigationButton(
              label: 'Task Manager',
              routeName: '/task',
            ),
            NavigationButton(
              label: 'Wellness Coach',
              routeName: '/wellness',
            ),
            NavigationButton(
              label: 'Premium Features',
              routeName: '/premium',
            ),
          ],
        ),
      ),
    );
  }
}

/// A reusable navigation button widget.
class NavigationButton extends StatelessWidget {
  final String label;
  final String routeName;

  const NavigationButton(
      {Key? key, required this.label, required this.routeName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
        ),
        child: Text(label, style: TextStyle(fontSize: 18)),
        onPressed: () {
          Navigator.pushNamed(context, routeName);
        },
      ),
    );
  }
}

/// TaskManagerScreen: Allows users to add tasks and view a list.
class TaskManagerScreen extends StatefulWidget {
  const TaskManagerScreen({Key? key}) : super(key: key);

  @override
  _TaskManagerScreenState createState() => _TaskManagerScreenState();
}

class _TaskManagerScreenState extends State<TaskManagerScreen> {
  final TextEditingController _taskController = TextEditingController();
  List<String> tasks = [];

  /// Adds a new task to the list.
  void _addTask() {
    if (_taskController.text.trim().isNotEmpty) {
      setState(() {
        tasks.add(_taskController.text.trim());
        _taskController.clear();
      });
      // Placeholder: trigger gamification reward animation here.
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task Manager'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _taskController,
              decoration: InputDecoration(
                hintText: 'Enter a new task',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 12),
            ElevatedButton(
              onPressed: _addTask,
              child: Text('Add Task'),
            ),
            SizedBox(height: 20),
            Expanded(
              child: tasks.isEmpty
                  ? Center(child: Text('No tasks added yet.'))
                  : ListView.builder(
                      itemCount: tasks.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(tasks[index]),
                          trailing: Icon(Icons.check_circle_outline),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

/// WellnessScreen: Provides a guided breathing exercise with a gentle animation.
class WellnessScreen extends StatefulWidget {
  const WellnessScreen({Key? key}) : super(key: key);

  @override
  _WellnessScreenState createState() => _WellnessScreenState();
}

class _WellnessScreenState extends State<WellnessScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 4),
    )..repeat(reverse: true);
    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.2).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wellness Coach'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Breathe In... Breathe Out...',
                style: TextStyle(fontSize: 20)),
            SizedBox(height: 20),
            ScaleTransition(
              scale: _scaleAnimation,
              child: Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blueAccent.withOpacity(0.3),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// PremiumScreen: Showcases premium features and upsells the subscription.
class PremiumScreen extends StatelessWidget {
  const PremiumScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Premium Features'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Unlock advanced analytics, custom themes, and more!',
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Placeholder: trigger subscription purchase flow integration.
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content: Text('Premium upgrade flow not implemented.')),
                );
              },
              child: Text('Upgrade to Premium'),
            ),
          ],
        ),
      ),
    );
  }
}
