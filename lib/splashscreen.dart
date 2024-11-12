import 'package:flutter/material.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_machine_test/loginscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final Dio _dio = Dio();
  bool isFirstTimeUser = true;

  @override
  void initState() {
    super.initState();
    _checkFirstTimeUser().then((firstTime) {
      isFirstTimeUser = firstTime;
      if (isFirstTimeUser) {
        _sendDeviceInfo();
      }
      _navigateNext();
    });
  }

  Future<void> _sendDeviceInfo() async {
    final deviceInfo = DeviceInfoPlugin();
    final androidInfo = await deviceInfo.androidInfo;

    final data = {
    //   "deviceType": "android",
    //   "deviceId": androidInfo.id,
    //   "deviceName": androidInfo.model,
    //   "deviceOSVersion": androidInfo.version.release,
    //   "deviceIPAddress": "11.433.445.66",
    //   "lat": 9.9312,
    //   "long": 76.2673,
    //   "buyer_gcmid": "",
    //   "buyer_pemid": "",
    //   "app": {
    //     "version": "1.20.5",
    //     "installTimeStamp": DateTime.now().toIso8601String(),
    //   }
    // }
  
    "deviceType": "andriod",
    "deviceId": "C6179909526098",
    "deviceName": "Samsung-MT200",
    "deviceOSVersion": "2.3.6",
    "deviceIPAddress": "11.433.445.66",
    "lat": 9.9312,
    "long": 76.2673,
    "buyer_gcmid": "",
    "buyer_pemid": "",
    "app": {
        "version": "1.20.5",
        "installTimeStamp": "2022-02-10T12:33:30.696Z",
        "uninstallTimeStamp": "2022-02-10T12:33:30.696Z",
        "downloadTimeStamp": "2022-02-10T12:33:30.696Z"
    }
};

    const url = "http://devapiv4.dealsdray.com/api/v2/user/device/add";
    try {
      final response = await _dio.post(url, data: data);
      if (response.statusCode == 200) {
        print("Device info sent successfully");
      } else {
        print("Failed to send device info: ${response.statusCode}");
      }
    } catch (error) {
      print("Error sending device info: $error");
    }
  }

  Future<void> _navigateNext() async {
    await Future.delayed(const Duration(seconds: 3));
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const LoginScreen()));
  }

  Future<bool> _checkFirstTimeUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isFirstTime = prefs.getBool('isFirstTimeUser') ?? true;
    if (isFirstTime) {
      prefs.setBool('isFirstTimeUser', false);
    }
    return isFirstTime;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/background_image.png',
              fit: BoxFit.fill,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 40),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/logo1.png',
                    height: 200,
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Company Name",
                    style: TextStyle(fontSize: 24, color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
