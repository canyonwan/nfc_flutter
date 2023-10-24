import '/app/models/address_model.dart';
import '/app/models/response_model.dart';
import '../../../providers/base_provider.dart';

class AddressProvider extends BaseProvider {
  static const String addressListUrl = "apitest/member_address_list";
  static const String deleteAddressUrl = "apitest/member_address_del";
  static const String addAddressUrl = "apitest/member_address";

  Future<MyAddressListRootModel> getAddressList(
      {int? isDefault, int? addressId}) async {
    final response = await post(addressListUrl, {
      'is_default': isDefault,
      'address_id': addressId,
    });
    return MyAddressListRootModel.fromJson(response.body);
  }

  Future<ResponseData> deleteAddress(int id) async {
    final response = await post(deleteAddressUrl, {"address_id": id});
    return ResponseData.fromJson(response.body);
  }

  Future<ResponseData> saveMyAddress(MyAddressItem address) async {
    final response = await post(addAddressUrl, address.toJson());
    return ResponseData.fromJson(response.body);
  }
}
