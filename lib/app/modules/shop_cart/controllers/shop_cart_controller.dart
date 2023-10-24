import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:mallxx_app/app/models/cart_model.dart';
import 'package:mallxx_app/app/modules/root/controllers/field_controller.dart';
import 'package:oktoast/oktoast.dart';
import '/app/routes/app_pages.dart';
import '../../../models/cart_list_model.dart';
import '../../root/providers/cart_provider.dart';

class ShopCartController extends GetxController with StateMixin<CartDataModel> {
  final cartProvider = Get.put(CartProvider());
  final fieldController = Get.find<FieldController>();

  final isEdit = false.obs;

  final cartData = CartDataModel().obs;
  final today = RxList<CartGoodsModel>();
  final notSend = RxList<CartGoodsModel>();
  final invalid = RxList<CartGoodsModel>();
  final todaySend = RxList<CartGoodsModel>();

  final isAllCheck = false.obs;
  final isLoading = true.obs;
  final totalPrice = 0.00.obs;
  final isCheck = false.obs;
  final checkedCartIds = [].obs; // 当前选中的商品

  GoodsCountInCartDataModel? cartCountsData; // 购物车数量
  CalcCartTotalPriceDataModel? calcCartTotalPriceDataModel;

  @override
  void onInit() {
    super.onInit();
    getCartCounts();
  }

  Future<void> getCarts() async {
    change(null, status: RxStatus.loading());
    final response = await cartProvider.getCartList(
        address: fieldController.searchModel.mergename!);
    isLoading.value = false;
    if (response.code == 200) {
      getCartCounts();
      if (response.data == null) {
        change(null, status: RxStatus.error(response.msg));
        today.value = [];
        notSend.value = [];
        invalid.value = [];
        todaySend.value = [];
      } else {
        if (response.data != null) {
          cartData.value = response.data!;
          today.value = response.data?.today ?? [];
          notSend.value = response.data?.notSend ?? [];
          invalid.value = response.data?.invalid ?? [];
          todaySend.value = response.data?.todaySend ?? [];
          if (today.isEmpty &&
              notSend.isEmpty &&
              invalid.isEmpty &&
              todaySend.isEmpty) {
            change(response.data, status: RxStatus.empty());
          } else {
            change(response.data, status: RxStatus.success());
          }
        }
      }
      calculateTotalPrice();
    } else {
      change(null, status: RxStatus.error(response.msg));
    }
  }

  // 购物车数量
  Future<void> getCartCounts() async {
    GoodsCountInCartRootModel res = await cartProvider.queryGoodsCountInCart();
    if (res.code == 200) {
      cartCountsData = res.data!;
      update(['update_goods_count']);
    }
  }

  // 改变计数
  void onChangeCartQuantity(CartGoodsModel cart, int specification) {
    cart.goodsNum = specification.toString();
    updateQuantity(id: cart.goodsId!, quantity: specification);
  }

  // 修改购物车数量
  void updateQuantity({required int id, required int quantity}) async {
    EasyLoading.show();
    final response =
        await cartProvider.modifyQuantity(id: id, quantity: quantity);
    EasyLoading.dismiss();
    if (response.code == 200) {
      calculateTotalPrice();
      update(["update_cart_Item"]);
    }
  }

  Future<void> calculateTotalPrice() async {
    List<String> cartIds = [];
    if (today != null || today.length != 0) {
      for (var item in today) {
        if (item.check == true) {
          cartIds.add(item.cartId!.toString());
        }
      }
    }
    if (todaySend != null || todaySend.length != 0) {
      for (var item in todaySend) {
        if (item.check == true) {
          cartIds.add(item.cartId!.toString());
        }
      }
    }
    if (invalid != null || invalid.length != 0) {
      for (var item in invalid) {
        if (item.check == true) {
          cartIds.add(item.cartId!.toString());
        }
      }
    }
    if (notSend != null || notSend.length != 0) {
      for (var item in notSend) {
        if (item.check == true) {
          cartIds.add(item.cartId!.toString());
        }
      }
    }
    checkedCartIds.value = cartIds;
    calcTotalPrice();
  }

  Future<void> calcTotalPrice() async {
    final res = await cartProvider.queryCartGoodsTotalPrice(
        checkedCartIds.isNotEmpty ? checkedCartIds.join(',') : '',
        address: fieldController.searchModel.mergename);
    if (res.code == 200) {
      calcCartTotalPriceDataModel = res.data;
      update(['update_calc_price']);
    }
  }

  void onItemChecked(CartGoodsModel item, bool check) {
    item.check = check;
    changeIsAllCheck();
    update(["update_cart_Item"]);
    calculateTotalPrice();
  }

  void changeIsAllCheck() {
    bool isAll = true;
    for (final item in today) {
      if (item.check == false) {
        isAll = false;
      }
    }
    for (final item in notSend) {
      if (item.check == false) {
        isAll = false;
      }
    }
    for (final item in invalid) {
      if (item.check == false) {
        isAll = false;
      }
    }
    for (final item in todaySend) {
      if (item.check == false) {
        isAll = false;
      }
    }
    this.isAllCheck.value = isAll;
    calculateTotalPrice();
  }

  void onIsAllCheck() {
    isAllCheck.toggle();
    for (final item in todaySend) {
      item.check = isAllCheck.value;
    }
    for (final item in today) {
      item.check = isAllCheck.value;
    }
    for (final item in invalid) {
      item.check = isAllCheck.value;
    }
    for (final item in notSend) {
      item.check = isAllCheck.value;
    }
    calculateTotalPrice();
    update(['update_cart_Item']);
  }

  Future<void> delCartGoods() async {
    EasyLoading.show();
    final res = await cartProvider.queryDelCartGoods(
      checkedCartIds.isNotEmpty ? checkedCartIds.join(',') : '',
    );
    EasyLoading.dismiss();
    if (res.code == 200) {
      Get.back();
      getCarts();
      getCartCounts();
    }
    showToast(res.msg);
  }

  Future<void> onToOrderConfirm() async {
    await Get.toNamed(Routes.ORDER_CONFIRM, arguments: {
      'goodsMap': {
        'cartIds': checkedCartIds.join(','),
        'address': fieldController.searchModel.mergename ?? '',
        'orderSourceType': 1,
      },
    });
    getCarts();
    getCartCounts();
  }

  Future<void> onChangeAddress() async {
    await fieldController.onSelectAddress(false, changeCarts: getCarts);
  }
}
