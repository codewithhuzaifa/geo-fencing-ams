import 'package:attendance_system/domain/models/date_time.dart';
import '../../../utils/app_export.dart';
import 'package:http/http.dart' as http;

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
  }
}

class HomeController extends GetxController {
  @override
  void onInit() {
    checkLocationAltitude();
    super.onInit();
  }

//variables
  LatLng officeLocation = const LatLng(24.923704637618993, 67.09297965078748);
  double officeRadius = 50; // 50 meters radius around office
  double? altitude;
  GoogleMapController? mapController;
  RxBool isButtonEnabled = false.obs;
  RxBool isAttendanceMarked = false.obs;
  double? distance;

  Set<Circle> circles = {
    Circle(
        circleId: const CircleId('officeCircle'),
        center: const LatLng(24.923704637618993, 67.09297965078748),
        radius: 50,
        strokeWidth: 2,
        fillColor: Colors.lightBlueAccent.withOpacity(0.2))
  };

//methods

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void markAttendance() async {
    NetworkTime networkTime = await getCurrentNetworkTime();
    DateTime currentTime = networkTime.dateTime!;
    timeZone = networkTime.timezone;

    isAttendanceMarked.value = true;
    isButtonEnabled.value = false;
    // date = DateFormat('yMd').format(DateTime.now());
    // time = DateFormat.jm().format(DateTime.now());
    date = DateFormat('dd/MM/yyyy').format(currentTime);
    time = DateFormat.jm().format(currentTime);

    debugPrint(timeZone);
  }

  Future<void> checkLocationAltitude() async {
    try {
      LocationPermission permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.always ||
          permission == LocationPermission.whileInUse) {
        Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.bestForNavigation);

        altitude = position.altitude;

        distance = Geolocator.distanceBetween(
            position.latitude,
            position.longitude,
            officeLocation.latitude,
            officeLocation.longitude);

        if ((distance! <= officeRadius) &&
            (altitude != null &&
                (altitude! >= -10.40 && altitude! <= -10.30))) {
          isButtonEnabled.value = true;
        } else {
          isButtonEnabled.value = false;
        }

        debugPrint("Position Altitude ${position.altitude}");
        debugPrint("Position Latitude ${position..latitude}");
        debugPrint("Position longitude ${position.longitude}");
        debugPrint("Position Floor ${position.floor}");
        debugPrint("Distance between Office & Current Position $distance");

        //
      } else if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever ||
          permission == LocationPermission.deniedForever ||
          permission == LocationPermission.unableToDetermine) {
        await Geolocator.openLocationSettings();
        await Geolocator.openAppSettings();
      } else {
        await Geolocator.openLocationSettings();
        await Geolocator.openAppSettings();
      }
    } on PlatformException catch (e) {
      debugPrint("Location getting error $e");
    }
  }

  Future<NetworkTime> getCurrentNetworkTime() async {
    try {
      var response =
          await http.get(Uri.parse('http://worldtimeapi.org/api/ip'));
      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response.body);
        DateTime currentTime = DateTime.parse(data['datetime']);
        DateTime localTime = currentTime.add(const Duration(hours: 5));
        String timezone = data['timezone'];
        return NetworkTime(dateTime: localTime, timezone: timezone);
      } else {
        // Handle error
        throw Exception('Failed to get network time: ${response.reasonPhrase}');
      }
    } catch (e) {
      // Handle error
      throw Exception('Error: $e');
    }
  }
}
