import 'package:attendance_system/presentation/controllers/Home/home_controller.dart';
import 'package:attendance_system/presentation/pages/Home/home_view.dart';
import '../../utils/app_export.dart';

class AppRoute {
  static String initial = '/';

  static List<GetPage<dynamic>>? getPages = [
    GetPage(
      name: initial,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
  ];
}
