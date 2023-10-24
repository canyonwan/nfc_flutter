import 'package:city_pickers/city_pickers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lpinyin/lpinyin.dart';
import 'package:mallxx_app/app/models/city_data_model.dart';
import 'package:mallxx_app/app/modules/root/providers/field_provider.dart';
import 'package:mallxx_app/const/colors.dart';

import '/app/components/hint.dart';
import '/app/models/address_model.dart';

///
///
typedef ConfirmCallback = void Function(MyAddressItem);

class EditAddressView extends StatefulWidget {
  final MyAddressItem? address;
  final ConfirmCallback onConfirm;

  const EditAddressView({
    Key? key,
    this.address,
    required this.onConfirm,
  }) : super(key: key);

  @override
  _EditAddressViewState createState() => _EditAddressViewState();
}

class _EditAddressViewState extends State<EditAddressView> {
  Map<String, dynamic>? citiesData = {};
  Map<String, String>? provincesData = {};
  final FieldProvider fieldProvider = Get.find<FieldProvider>();

  @override
  void initState() {
    super.initState();
    getCityData();
  }

  Future<void> getCityData() async {
    final res = await fieldProvider.queryCityPickerData();
    if (res.code == 200 && res.data != null) {
      for (var i = 0; i < res.data!.length; i++) {
        if (res.data!.isNotEmpty) {
          provincesData![res.data![i].id.toString()] = res.data![i].name!;
          citiesData = _convertDataToMap(res.data!);
          setState(() {});
        }
      }
    }
  }

  Map<String, dynamic> _convertDataToMap(List<CityItemModel> data) {
    Map<String, dynamic> result = {};
    data.forEach((element) {
      result[element.id.toString()] = <String, dynamic>{};
      element.childrenlist!.forEach((item) {
        String letter =
            PinyinHelper.getFirstWordPinyin(item.name!).substring(0, 1);
        result[element.id.toString()]
            [item.id.toString()] = {'name': item.name, 'alpha': letter};
        if (item.childrenlist != null && item.childrenlist!.isNotEmpty) {
          result[item.id.toString()] = <String, dynamic>{};
          item.childrenlist!.forEach((area) {
            String areaLetter =
                PinyinHelper.getFirstWordPinyin(area.name!).substring(0, 1);
            result[item.id.toString()]
                [area.id.toString()] = {'name': area.name, 'alpha': areaLetter};
          });
        }
      });
    });
    return result;
  }

  MyAddressItem address = MyAddressItem();

  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _regionController = TextEditingController();
  TextEditingController _detailController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _phoneController.dispose();
    _regionController.dispose();
    _detailController.dispose();
  }

  Widget _itemTextField({
    String? value,
    required String title,
    required void Function(String) onChanged,
    bool? enabled,
    VoidCallback? onTap,
    showArrow = false,
  }) {
    return Container(
      // decoration: BoxDecoration(color: KWhiteColor),
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.w),
      child: GestureDetector(
        onTap: onTap,
        child: TextField(
          controller: TextEditingController.fromValue(
            TextEditingValue(
              text: value ?? '',
              selection: TextSelection.fromPosition(
                TextPosition(
                    affinity: TextAffinity.downstream,
                    offset: '${value}'.length),
              ),
            ),
          ),
          enabled: enabled,
          onChanged: onChanged,
          decoration: InputDecoration(
            suffixIcon:
                showArrow ? Icon(Icons.keyboard_arrow_right_outlined) : null,
            fillColor: Colors.grey[200],
            filled: true,
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            icon: Text(
              title,
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.address?.id != null) {
      address = widget.address!;
    }
    _nameController.text = address.addressName ?? "";
    _phoneController.text = address.addressPhone ?? "";
    _regionController.text =
        "${address.province ?? ""} ${address.city ?? ""} ${address.county ?? ""}";
    _detailController.text = address.address ?? "";
    return Scaffold(
      backgroundColor: KWhiteColor,
      appBar: AppBar(
        title: Text(
            widget.address?.id == null ? "add_address".tr : "edit_address".tr),
        centerTitle: true,
      ),
      body: ConstrainedBox(
        constraints: BoxConstraints.expand(),
        child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _itemTextField(
                    title: "收货人    ",
                    value: address.addressName ?? "",
                    onChanged: (value) {
                      setState(() {
                        address.addressName = value;
                      });
                    },
                  ),
                  _itemTextField(
                    value: address.addressPhone ?? "",
                    onChanged: (value) {
                      setState(() {
                        address.addressPhone = value;
                      });
                    },
                    title: "手机号码",
                  ),
                  _itemTextField(
                    value:
                        "${address.province ?? ""} ${address.city ?? ""} ${address.county ?? ""}",
                    onChanged: (value) {},
                    title: "所在地区",
                    enabled: false,
                    showArrow: true,
                    onTap: () async {
                      Result? result = await CityPickers.showCityPicker(
                        context: context,
                        // locationCode: areaId == '' ? '37' : areaId,
                        provincesData: provincesData,
                        citiesData: citiesData,
                      );
                      if (result != null) {
                        setState(() {
                          address.province = result.provinceName;
                          address.city = result.cityName;
                          address.county = result.areaName;
                          // areaId = result.areaId;
                        });
                        // searchModel.mergename =
                        //     '${'中国'},${result.provinceName},${result.cityName},${result.areaName}';
                        // areaId = result.areaId!;
                        // update(['update_location']);
                      }
                    },
                  ),
                  _itemTextField(
                    value: address.address ?? "",
                    onChanged: (value) {
                      setState(() {
                        address.address = value;
                      });
                    },
                    title: "详细地址",
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              width: MediaQuery.of(context).size.width,
              height: 80,
              child: GestureDetector(
                onTap: () {
                  if (address.addressName == null) {
                    Hint.Error("收货人不能为空");
                    return;
                  }

                  if (address.addressPhone == null) {
                    Hint.Error("收货人手机号码不能为空");
                    return;
                  }

                  if (address.province == null ||
                      address.city == null ||
                      address.county == null) {
                    Hint.Error("省市区不能为空");
                    return;
                  }

                  if (address.address == null) {
                    Hint.Error("详细地址不能为空");
                    return;
                  }
                  if (widget.address?.id == null) {
                    widget.onConfirm(address);
                  } else if (widget.address?.id != null) {
                    address.addressId = widget.address!.id;
                    widget.onConfirm(address);
                  }
                },
                child: Container(
                  alignment: Alignment.center,
                  margin:
                      EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 30),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: kAppColor,
                  ),
                  child: Text(
                    "finish".tr,
                    style: TextStyle(color: KWhiteColor, fontSize: 18),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
