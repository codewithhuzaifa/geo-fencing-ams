import 'package:attendance_system/domain/models/date_time.dart';
import '../../../utils/app_export.dart';

class BottomSheetWidget extends StatelessWidget {
  const BottomSheetWidget({
    super.key,
    required this.isAttendanceMarked,
    required this.altitiude,
    required this.distance,
    required this.officeRadius,
  });

  final bool isAttendanceMarked;
  final double altitiude;
  final double? distance;
  final double? officeRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      width: double.infinity,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12), topRight: Radius.circular(12))),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Current Attendance Status',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              Text(
                isAttendanceMarked
                    ? "Congratulations! Your today's attendance is marked."
                    : "Your attendance is not marked yet!",
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
              ),
              const SizedBox(height: 6),
              const Text(
                'Check In Date',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              Text(
                isAttendanceMarked ? date! : ' - / - / - ',
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
              ),
              const SizedBox(height: 6),
              const Text(
                'Check In Time',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              Text(
                isAttendanceMarked ? time! : ' - / - / - ',
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
              ),
              const SizedBox(height: 6),
              const Text(
                'Altitude Information',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const Text(
                'For marking attendance, your altitude should be in between: -10.40 to -10.30',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
              ),
              const SizedBox(height: 3),
              Text(
                'Your current altitude is: ${altitiude.toStringAsFixed(2)}',
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
              ),
              const SizedBox(height: 6),
              const Text(
                'Distance Information',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              Text(
                'For marking attendance, your distance between office & your current location should be: $officeRadius meters',
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
              ),
              const SizedBox(height: 3),
              Text(
                'Your current distance is: ${distance!.toStringAsFixed(2)} meters',
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
