// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:parallel/widget/__.dart';
//
// class AddLinkBS extends StatelessWidget {
//   final RxString inputValue = ''.obs;
//   final TextEditingController controller;
//   AddLinkBS({
//     super.key,
//     required this.controller,
//   }) {
//     inputValue.value = controller.text;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return FractionallySizedBox(
//       heightFactor: 0.35,
//       child: Container(
//         decoration: BoxDecoration(
//           color: Get.theme.scaffoldBackgroundColor,
//           borderRadius: const BorderRadius.only(
//             topLeft: Radius.circular(15),
//             topRight: Radius.circular(15),
//           ),
//         ),
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           children: [
//             SizedBox(
//               width: Get.width,
//               child: Text(
//                 'txt_add_link'.tr.toUpperCase(),
//                 textAlign: TextAlign.start,
//                 style: Get.textTheme.bodyLarge!.copyWith(fontSize: 12),
//               ),
//             ),
//             const SizedBox(height: 6),
//             PInputTextFieldWidget(
//               controller: controller,
//               hintText: 'txt_tap_twice_to_paste'.tr,
//               leadingIcon: 'add_link',
//               onChanged: (value) => inputValue.value = value,
//             ),
//             const SizedBox(height: 40),
//             Obx(
//                   () => PButtonWidget(
//                 width: 220,
//                 text: 'txt_add'.tr.toUpperCase(),
//                 // wanrning: Get.theme.colorScheme.secondary,
//                 onPressed: inputValue.isEmpty
//                     ? null
//                     : () => Get.back(result: controller.text),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }