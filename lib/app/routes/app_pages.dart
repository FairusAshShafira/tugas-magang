import 'package:get/get.dart';

import '../modules/add_data/bindings/add_data_binding.dart';
import '../modules/add_data/views/add_data_view.dart';
import '../modules/admin_page/bindings/admin_page_binding.dart';
import '../modules/admin_page/views/admin_page_view.dart';
import '../modules/edit_data/bindings/edit_data_binding.dart';
import '../modules/edit_data/views/edit_data_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/home_page/bindings/home_page_binding.dart';
import '../modules/home_page/views/home_page_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/notification/bindings/notification_binding.dart';
import '../modules/notification/views/notification_view.dart';
import '../modules/query/bindings/query_binding.dart';
import '../modules/query/views/query_view.dart';
import '../modules/reset_password/bindings/reset_password_binding.dart';
import '../modules/reset_password/views/reset_password_view.dart';
import '../modules/signup/bindings/signup_binding.dart';
import '../modules/signup/views/signup_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.SIGNUP,
      page: () => SignupView(),
      binding: SignupBinding(),
    ),
    GetPage(
      name: _Paths.RESET_PASSWORD,
      page: () => ResetPasswordView(),
      binding: ResetPasswordBinding(),
    ),
    GetPage(
      name: _Paths.ADD_DATA,
      page: () => const AddDataView(),
      binding: AddDataBinding(),
    ),
    GetPage(
      name: _Paths.EDIT_DATA,
      page: () => const EditDataView(),
      binding: EditDataBinding(),
    ),
    GetPage(
      name: _Paths.QUERY,
      page: () => const QueryView(),
      binding: QueryBinding(),
    ),
    GetPage(
      name: _Paths.NOTIFICATION,
      page: () => NotificationView(),
      binding: NotificationBinding(),
    ),
    GetPage(
      name: _Paths.HOME_PAGE,
      page: () => HomePageView(),
      binding: HomePageBinding(),
    ),
    GetPage(
      name: _Paths.ADMIN_PAGE,
      page: () => AdminPageView(),
      binding: AdminPageBinding(),
    ),
  ];
}
