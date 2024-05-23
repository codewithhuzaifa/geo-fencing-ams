import 'package:attendance_system/presentation/controllers/Home/home_controller.dart';
import 'package:attendance_system/presentation/widgets/bottomsheet_widget.dart';
import 'package:attendance_system/utils/app_export.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Text('Mark Attendance'),
            const Spacer(),
            Obx(
              () => controller.isAttendanceMarked.value
                  ? const Icon(Icons.check, color: Colors.green)
                  : const Icon(Icons.close, color: Colors.red),
            ),
            const SizedBox(width: 10),
            IconButton(
                onPressed: () {
                  Get.bottomSheet(Obx(() => BottomSheetWidget(
                        isAttendanceMarked: controller.isAttendanceMarked.value,
                        altitiude: controller.altitude!,
                        distance: controller.distance!,
                        officeRadius: controller.officeRadius,
                      )));
                },
                icon: const Icon(Icons.info_outline_rounded)),
            IconButton(
                onPressed: () {
                  controller.isAttendanceMarked.value
                      ? null
                      : controller.checkLocationAltitude();
                },
                icon: const Icon(Icons.refresh_outlined))
          ],
        ),
      ),
      body: SafeArea(
          child: Stack(
        children: [
          GoogleMap(
            onMapCreated: controller.onMapCreated,
            mapType: MapType.normal,
            compassEnabled: true,
            myLocationEnabled: true,
            initialCameraPosition: CameraPosition(
              zoom: 18,
              target: controller.officeLocation,
              // tilt: 20,
              // bearing: 90
            ),
            markers: {
              Marker(
                  markerId: const MarkerId('office_location_marker'),
                  position: controller.officeLocation,
                  infoWindow: const InfoWindow(title: 'Office Location')),
            },
            circles: controller.circles,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 6, left: 12, right: 60),
            child: SizedBox(
                width: double.infinity,
                child: Obx(
                  () => ElevatedButton(
                    onPressed: controller.isButtonEnabled.value
                        ? controller.markAttendance
                        : null,
                    child: const Text('Mark Attendance'),
                  ),
                )),
          ),
        ],
      )),
    );
  }
}
