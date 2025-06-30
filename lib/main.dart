import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';

void main() {
  runApp(BiometricApp());
}

class BiometricApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Biometric Auth',
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      home: BiometricLoginScreen(),
    );
  }
}

class BiometricLoginScreen extends StatefulWidget {
  @override
  _BiometricLoginScreenState createState() => _BiometricLoginScreenState();
}

class _BiometricLoginScreenState extends State<BiometricLoginScreen> {
  final LocalAuthentication auth = LocalAuthentication();
  String _message = 'Please authenticate to proceed';

  Future<void> _authenticate() async {
    bool isAvailable =
        await auth.canCheckBiometrics || await auth.isDeviceSupported();

    if (!isAvailable) {
      setState(() {
        _message = 'Biometric or device authentication not available';
      });
      return;
    }

    try {
      bool authenticated = await auth.authenticate(
        localizedReason: 'Please authenticate to access the app',
        options: const AuthenticationOptions(
          biometricOnly: false, // allow fallback to PIN/password
          stickyAuth: true,
          useErrorDialogs: true,
        ),
      );

      if (authenticated) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => WelcomeScreen()),
        );
      } else {
        setState(() {
          _message = '❌ Authentication Failed';
        });
      }
    } catch (e) {
      setState(() {
        _message = '⚠️ Error: ${e.toString()}';
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _authenticate(); // Auto-auth on launch
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[50],
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.fingerprint, size: 100, color: Colors.deepPurple),
              SizedBox(height: 20),
              Text(
                _message,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 40),
              ElevatedButton.icon(
                onPressed: _authenticate,
                icon: Icon(Icons.lock_open),
                label: Text("Retry Authentication"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome'),
        backgroundColor: Colors.deepPurple,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => BiometricLoginScreen()),
            );
          },
        ),
      ),
      backgroundColor: Colors.deepPurple[50],
      body: Center(
        child: Text(
          '🎉 Welcome!',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.deepPurple,
          ),
        ),
      ),
    );
  }
}
