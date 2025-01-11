import 'package:flutter/material.dart';
import 'package:app_tracking_transparency/app_tracking_transparency.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App Tracking Transparency',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _trackingStatus = 'Unknown';

  @override
  void initState() {
    super.initState();
    _requestTrackingPermission();
  }

  Future<void> _requestTrackingPermission() async {
    // Obtiene el estado actual del permiso.
    final status = await AppTrackingTransparency.trackingAuthorizationStatus;

    // Si el estado es "notDetermined", solicita el permiso.
    if (status == TrackingStatus.notDetermined) {
      final newStatus = await AppTrackingTransparency.requestTrackingAuthorization();
      setState(() {
        _trackingStatus = newStatus.toString();
      });
    } else {
      setState(() {
        _trackingStatus = status.toString();
      });
    }

    // Obtén el identificador de publicidad si es necesario.
    final advertisingId = await AppTrackingTransparency.getAdvertisingIdentifier();
    debugPrint('Advertising ID: $advertisingId');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('App Tracking Transparency')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Tracking Status: $_trackingStatus',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _requestTrackingPermission,
              child: Text('Request Tracking Permission Again'),
            ),
          ],
        ),
      ),
    );
  }
}
