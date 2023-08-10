import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parallel/module/profile_edit/edit_profile_controller.dart';
import 'package:parallel/widget/__.dart';
import 'package:parallel/widget/p_list_view_widget.dart';

class CountryWidget extends GetView<EditProfileController> {
  const CountryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PInputTextFieldWidget(
          onChanged: (value) => controller.filterCountries(value),
        ),
        PListViewWidget(
          count: controller.displayedCountries.length,
          onBuildItem: (index) {
            return _itemCountry(controller.displayedCountries[index]);
          },
        )
      ],
    );
  }

  Widget _itemCountry(Map<String, String> country) {
    final String flagUrl = country['flag'].toString();
    final String countryName = country['name'].toString();
    return ListTile(
      leading: Image.network(
        flagUrl,
        width: 40,
        height: 40,
      ),
      title: Text(countryName),
    );
  }
}
