import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [],
      ),
    );
  }

  // Widget bottomNavBar() {
  //   return Container(
  //     color: AppColor.white,
  //     height: 90,
  //     width: Get.width,
  //     child: Row(
  //       children: [
  //         bottomNavItem(
  //           label: "Accueil",
  //           icon: AssetIcons.home,
  //           selectedIcon: AssetIcons.homeSelect,
  //           page: 0,
  //         ),
  //         bottomNavItem(
  //           page: 1,
  //           label: "Messages",
  //           icon: AssetIcons.mail,
  //           selectedIcon: AssetIcons.mailSelect,
  //         ),
  //         bottomNavItem(
  //           page: 2,
  //           label: "Notifications",
  //           icon: AssetIcons.notification,
  //           selectedIcon: AssetIcons.notificationSelect,
  //         ),
  //         bottomNavItem(
  //           page: 3,
  //           label: "Paramètres",
  //           icon: AssetIcons.setting,
  //           selectedIcon: AssetIcons.settingSelect,
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // Widget bottomNavItem({
  //   required String label,
  //   required String icon,
  //   required String selectedIcon,
  //   required int page,
  // }) {
  //   return Expanded(
  //     child: ActionButon(
  //       onTap: () {
  //         ctrl.currentPage(page);
  //       },
  //       child: Obx(() => Column(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: [
  //               Image.asset(
  //                 ctrl.currentPage.value == page ? selectedIcon : icon,
  //                 height: 20,
  //               ),
  //               space(7),
  //               Text(
  //                 label,
  //                 style: titleBodyStyle(
  //                   fontWeight: ctrl.currentPage.value == page
  //                       ? FontWeight.w600
  //                       : FontWeight.w400,
  //                   color: ctrl.currentPage.value == page
  //                       ? AppColor.primary
  //                       : AppColor.grey,
  //                 ),
  //               )
  //             ],
  //           )),
  //     ),
  //   );
  // }
}
