import 'package:get/get.dart';

import '../modules/about_me/bindings/about_me_binding.dart';
import '../modules/about_me/views/about_me_view.dart';
import '../modules/account_info/bindings/account_info_binding.dart';
import '../modules/account_info/views/account_info_view.dart';
import '../modules/account_security/bindings/account_security_binding.dart';
import '../modules/account_security/views/account_security_view.dart';
import '../modules/address_book/bindings/address_book_binding.dart';
import '../modules/address_book/views/address_book_view.dart';
import '../modules/appraise_order/bindings/appraise_order_binding.dart';
import '../modules/appraise_order/views/appraise_order_view.dart';
import '../modules/bind_tel/bindings/bind_tel_binding.dart';
import '../modules/bind_tel/views/bind_tel_view.dart';
import '../modules/change_gender/bindings/change_gender_binding.dart';
import '../modules/change_gender/views/change_gender_view.dart';
import '../modules/change_member_avatar/bindings/change_member_avatar_binding.dart';
import '../modules/change_member_avatar/forgot_pwd/bindings/forgot_pwd_binding.dart';
import '../modules/change_member_avatar/forgot_pwd/views/forgot_pwd_view.dart';
import '../modules/change_member_avatar/splash/bindings/splash_binding.dart';
import '../modules/change_member_avatar/splash/views/splash_view.dart';
import '../modules/change_member_avatar/views/change_member_avatar_view.dart';
import '../modules/change_member_name/bindings/change_member_name_binding.dart';
import '../modules/change_member_name/views/change_member_name_view.dart';
import '../modules/change_password/bindings/change_password_binding.dart';
import '../modules/change_password/views/change_password_view.dart';
import '../modules/change_pay_pwd/bindings/change_pay_pwd_binding.dart';
import '../modules/change_pay_pwd/views/change_pay_pwd_view.dart';
import '../modules/change_phone/bindings/change_phone_binding.dart';
import '../modules/change_phone/views/change_phone_view.dart';
import '../modules/comment/bindings/comment_binding.dart';
import '../modules/comment/views/comment_view.dart';
import '../modules/comment_detail/bindings/comment_detail_binding.dart';
import '../modules/comment_detail/views/comment_detail_view.dart';
import '../modules/country_region/bindings/country_region_binding.dart';
import '../modules/country_region/views/country_region_view.dart';
import '../modules/field_detail/bindings/field_detail_binding.dart';
import '../modules/field_detail/complaint_view/bindings/complaint_view_binding.dart';
import '../modules/field_detail/complaint_view/views/complaint_view_view.dart';
import '../modules/field_detail/live_streaming/bindings/live_streaming_binding.dart';
import '../modules/field_detail/live_streaming/views/live_streaming_view.dart';
import '../modules/field_detail/real_time_list/bindings/real_time_list_binding.dart';
import '../modules/field_detail/real_time_list/real-time_player/bindings/real_time_player_binding.dart';
import '../modules/field_detail/real_time_list/real-time_player/views/real_time_player_view.dart';
import '../modules/field_detail/real_time_list/views/real_time_list_view.dart';
import '../modules/field_detail/share_detail/bindings/share_detail_binding.dart';
import '../modules/field_detail/share_detail/views/share_detail_view.dart';
import '../modules/field_detail/views/field_detail_view.dart';
import '../modules/field_detail/vr360/bindings/vr360_binding.dart';
import '../modules/field_detail/vr360/views/vr360_view.dart';
import '../modules/find_detail/bindings/find_detail_binding.dart';
import '../modules/find_detail/views/find_detail_view.dart';
import '../modules/foodie_articles/bindings/foodie_articles_binding.dart';
import '../modules/foodie_articles/views/foodie_articles_view.dart';
import '../modules/forget_pay_pwd/bindings/forget_pay_pwd_binding.dart';
import '../modules/forget_pay_pwd/views/forget_pay_pwd_view.dart';
import '../modules/goods_detail/bindings/goods_detail_binding.dart';
import '../modules/goods_detail/views/goods_detail_view.dart';
import '../modules/granary/operation_records/bindings/operation_records_binding.dart';
import '../modules/granary/operation_records/views/operation_records_view.dart';
import '../modules/granary/process/bindings/process_binding.dart';
import '../modules/granary/process/views/process_view.dart';
import '../modules/guess_like/bindings/guess_like_binding.dart';
import '../modules/guess_like/views/guess_like_view.dart';
import '../modules/health_butler/bindings/health_butler_binding.dart';
import '../modules/health_butler/views/health_butler_view.dart';
import '../modules/image_text_upload/bindings/image_text_upload_binding.dart';
import '../modules/image_text_upload/views/image_text_upload_view.dart';
import '../modules/land_list/bindings/land_list_binding.dart';
import '../modules/land_list/views/land_list_view.dart';
import '../modules/language/bindings/language_binding.dart';
import '../modules/language/views/language_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/message_center/bindings/message_center_binding.dart';
import '../modules/message_center/my_notice_list/bindings/my_notice_list_binding.dart';
import '../modules/message_center/my_notice_list/views/my_notice_list_view.dart';
import '../modules/message_center/views/message_center_view.dart';
import '../modules/my_activity_forecast/bindings/my_activity_forecast_binding.dart';
import '../modules/my_activity_forecast/views/my_activity_forecast_view.dart';
import '../modules/my_assets/bindings/my_assets_binding.dart';
import '../modules/my_assets/views/my_assets_view.dart';
import '../modules/my_balance/bindings/my_balance_binding.dart';
import '../modules/my_balance/views/my_balance_view.dart';
import '../modules/my_comment/bindings/my_comment_binding.dart';
import '../modules/my_comment/views/my_comment_view.dart';
import '../modules/my_dislikes/bindings/my_dislikes_binding.dart';
import '../modules/my_dislikes/views/my_dislikes_view.dart';
import '../modules/my_footprint/bindings/my_footprint_binding.dart';
import '../modules/my_footprint/views/my_footprint_view.dart';
import '../modules/my_gift_card/balance_use_record_list/bindings/balance_use_record_list_binding.dart';
import '../modules/my_gift_card/balance_use_record_list/views/balance_use_record_list_view.dart';
import '../modules/my_gift_card/bindings/my_gift_card_binding.dart';
import '../modules/my_gift_card/views/my_gift_card_view.dart';
import '../modules/my_integral/bindings/my_integral_binding.dart';
import '../modules/my_integral/views/my_integral_view.dart';
import '../modules/my_likes/bindings/my_likes_binding.dart';
import '../modules/my_likes/views/my_likes_view.dart';
import '../modules/my_order/bindings/my_order_binding.dart';
import '../modules/my_order/views/my_order_view.dart';
import '../modules/my_order_detail/bindings/my_order_detail_binding.dart';
import '../modules/my_order_detail/views/my_order_detail_view.dart';
import '../modules/my_refund_order/bindings/my_refund_order_binding.dart';
import '../modules/my_refund_order/views/my_refund_order_view.dart';
import '../modules/my_refund_order_detail/bindings/my_refund_order_detail_binding.dart';
import '../modules/my_refund_order_detail/views/my_refund_order_detail_view.dart';
import '../modules/my_vip/bindings/my_vip_binding.dart';
import '../modules/my_vip/views/my_vip_view.dart';
import '../modules/my_webview/bindings/my_webview_binding.dart';
import '../modules/my_webview/views/my_webview_view.dart';
import '../modules/order_confirm/bindings/order_confirm_binding.dart';
import '../modules/order_confirm/order_choose_coupon/bindings/order_choose_coupon_binding.dart';
import '../modules/order_confirm/order_choose_coupon/views/order_choose_coupon_view.dart';
import '../modules/order_confirm/views/order_confirm_view.dart';
import '../modules/order_deliver/bindings/order_deliver_binding.dart';
import '../modules/order_deliver/views/order_deliver_view.dart';
import '../modules/order_detail/bindings/order_detail_binding.dart';
import '../modules/order_detail/views/order_detail_view.dart';
import '../modules/order_payment/bindings/order_payment_binding.dart';
import '../modules/order_payment/views/order_payment_view.dart';
import '../modules/order_success/bindings/order_success_binding.dart';
import '../modules/order_success/views/order_success_view.dart';
import '../modules/payment_options/bindings/payment_options_binding.dart';
import '../modules/payment_options/views/payment_options_view.dart';
import '../modules/privacy_policy/bindings/privacy_policy_binding.dart';
import '../modules/privacy_policy/views/privacy_policy_view.dart';
import '../modules/product_info/bindings/product_info_binding.dart';
import '../modules/product_info/views/product_info_view.dart';
import '../modules/register/bindings/register_binding.dart';
import '../modules/register/views/register_view.dart';
import '../modules/reset_pay_pwd/bindings/reset_pay_pwd_binding.dart';
import '../modules/reset_pay_pwd/views/reset_pay_pwd_view.dart';
import '../modules/root/bindings/root_binding.dart';
import '../modules/root/views/root_view.dart';
import '../modules/search_view/bindings/search_view_binding.dart';
import '../modules/search_view/views/search_view_view.dart';
import '../modules/set_pay_pwd/bindings/set_pay_pwd_binding.dart';
import '../modules/set_pay_pwd/views/set_pay_pwd_view.dart';
import '../modules/setting/bindings/setting_binding.dart';
import '../modules/setting/views/setting_view.dart';
import '../modules/shop_cart/bindings/shop_cart_binding.dart';
import '../modules/shop_cart/views/shop_cart_view.dart';
import '../modules/video_upload/bindings/video_upload_binding.dart';
import '../modules/video_upload/views/video_upload_view.dart';
import 'middleware/login_middleware.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.ROOT;

  static final routes = [
    GetPage(
      name: _Paths.ROOT,
      page: () => RootView(),
      binding: RootBinding(),
    ),
    GetPage(
      name: _Paths.PRODUCT_INFO,
      page: () => ProductInfoView(),
      binding: ProductInfoBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
      middlewares: [LoginClosedMiddleware()],
    ),
    GetPage(
      name: _Paths.SETTING,
      page: () => SettingView(),
      binding: SettingBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.ADDRESS_BOOK,
      page: () => AddressBookView(),
      binding: AddressBookBinding(),
    ),
    GetPage(
      name: _Paths.ACCOUNT_SECURITY,
      page: () => AccountSecurityView(),
      binding: AccountSecurityBinding(),
    ),
    GetPage(
      name: _Paths.PAYMENT_OPTIONS,
      page: () => PaymentOptionsView(),
      binding: PaymentOptionsBinding(),
    ),
    GetPage(
      name: _Paths.PRIVACY_POLICY,
      page: () => PrivacyPolicyView(),
      binding: PrivacyPolicyBinding(),
    ),
    GetPage(
      name: _Paths.LANGUAGE,
      page: () => LanguageView(),
      binding: LanguageBinding(),
    ),
    GetPage(
      name: _Paths.COUNTRY_REGION,
      page: () => CountryRegionView(),
      binding: CountryRegionBinding(),
    ),
    GetPage(
      name: _Paths.ABOUT_ME,
      page: () => AboutMeView(),
      binding: AboutMeBinding(),
    ),
    GetPage(
      name: _Paths.SHOP_CART,
      page: () => ShopCartView(),
      binding: ShopCartBinding(),
    ),
    GetPage(
      name: _Paths.ORDER_CONFIRM,
      page: () => OrderConfirmView(),
      binding: OrderConfirmBinding(),
      children: [
        GetPage(
            name: _Paths.ORDER_CHOOSE_COUPON,
            page: () => OrderChooseCouponView(),
            binding: OrderChooseCouponBinding()),
      ],
    ),
    GetPage(
      name: _Paths.ORDER_SUCCESS,
      page: () => OrderSuccessView(),
      binding: OrderSuccessBinding(),
      children: [
        GetPage(
          name: _Paths.SEARCH_VIEW,
          page: () => const SearchViewView(),
          binding: SearchViewBinding(),
        ),
      ],
    ),
    GetPage(
      name: _Paths.MY_ORDER,
      page: () => MyOrderView(),
      binding: MyOrderBinding(),
    ),
    GetPage(
      name: _Paths.ORDER_DELIVER,
      page: () => OrderDeliverView(),
      binding: OrderDeliverBinding(),
    ),
    GetPage(
      name: _Paths.ORDER_DETAIL,
      page: () => OrderDetailView(),
      binding: OrderDetailBinding(),
    ),
    GetPage(
      name: _Paths.COMMENT,
      page: () => CommentView(),
      binding: CommentBinding(),
    ),
    GetPage(
      name: _Paths.COMMENT_DETAIL,
      page: () => CommentDetailView(),
      binding: CommentDetailBinding(),
    ),
    GetPage(
      name: _Paths.MESSAGE_CENTER,
      page: () => MessageCenterView(),
      binding: MessageCenterBinding(),
      children: [
        GetPage(
          name: _Paths.MY_NOTICE_LIST,
          page: () => const MyNoticeListView(),
          binding: MyNoticeListBinding(),
        ),
      ],
    ),
    GetPage(
      name: _Paths.MY_COMMENT,
      page: () => MyCommentView(),
      binding: MyCommentBinding(),
    ),
    GetPage(
      name: _Paths.LAND_LIST,
      page: () => LandListView(),
      binding: LandListBinding(),
    ),
    GetPage(
      name: _Paths.OPERATION_RECORDS,
      page: () => const OperationRecordsView(),
      binding: OperationRecordsBinding(),
    ),
    GetPage(
      name: _Paths.PROCESS,
      page: () => const ProcessView(),
      binding: ProcessBinding(),
    ),
    GetPage(
      name: _Paths.FIELD_DETAIL,
      page: () => const FieldDetailView(),
      binding: FieldDetailBinding(),
      children: [
        GetPage(
          name: _Paths.COMPLAINT_VIEW,
          page: () => const ComplaintViewView(),
          binding: ComplaintViewBinding(),
        ),
        GetPage(
          name: _Paths.REAL_TIME_LIST,
          page: () => const RealTimeListView(),
          binding: RealTimeListBinding(),
          children: [
            GetPage(
              name: _Paths.REAL_TIME_PLAYER,
              page: () => const RealTimePlayerView(),
              binding: RealTimePlayerBinding(),
            ),
          ],
        ),
        GetPage(
          name: _Paths.LIVE_STREAMING,
          page: () => const LiveStreamingView(),
          binding: LiveStreamingBinding(),
        ),
        GetPage(
          name: _Paths.VR360,
          page: () => const Vr360View(),
          binding: Vr360Binding(),
        ),
        GetPage(
          name: _Paths.SHARE_DETAIL,
          page: () => const ShareDetailView(),
          binding: ShareDetailBinding(),
        ),
      ],
    ),
    GetPage(
      name: _Paths.GOODS_DETAIL,
      page: () => const GoodsDetailView(),
      binding: GoodsDetailBinding(),
      children: [
        GetPage(
          name: _Paths.ORDER_PAYMENT,
          page: () => const OrderPaymentView(),
          binding: OrderPaymentBinding(),
        ),
        GetPage(
          name: _Paths.MY_ASSETS,
          page: () => const MyAssetsView(),
          binding: MyAssetsBinding(),
        ),
        GetPage(
          name: _Paths.GUESS_LIKE,
          page: () => const GuessLikeView(),
          binding: GuessLikeBinding(),
        ),
        GetPage(
          name: _Paths.MY_LIKES,
          page: () => const MyLikesView(),
          binding: MyLikesBinding(),
        ),
        GetPage(
          name: _Paths.MY_DISLIKES,
          page: () => const MyDislikesView(),
          binding: MyDislikesBinding(),
        ),
        GetPage(
          name: _Paths.MY_FOOTPRINT,
          page: () => const MyFootprintView(),
          binding: MyFootprintBinding(),
        ),
        GetPage(
          name: _Paths.HEALTH_BUTLER,
          page: () => const HealthButlerView(),
          binding: HealthButlerBinding(),
        ),
        GetPage(
          name: _Paths.MY_INTEGRAL,
          page: () => const MyIntegralView(),
          binding: MyIntegralBinding(),
        ),
      ],
    ),
    GetPage(
      name: _Paths.MY_BALANCE,
      page: () => const MyBalanceView(),
      binding: MyBalanceBinding(),
    ),
    GetPage(
      name: _Paths.MY_GIFT_CARD,
      page: () => const MyGiftCardView(),
      binding: MyGiftCardBinding(),
      children: [
        GetPage(
          name: _Paths.BALANCE_USE_RECORD_LIST,
          page: () => const BalanceUseRecordListView(),
          binding: BalanceUseRecordListBinding(),
        ),
      ],
    ),
    GetPage(
      name: _Paths.MY_ORDER_DETAIL,
      page: () => const MyOrderDetailView(),
      binding: MyOrderDetailBinding(),
    ),
    GetPage(
      name: _Paths.MY_REFUND_ORDER_DETAIL,
      page: () => const MyRefundOrderDetailView(),
      binding: MyRefundOrderDetailBinding(),
    ),
    GetPage(
      name: _Paths.FIND_DETAIL,
      page: () => const FindDetailView(),
      binding: FindDetailBinding(),
    ),
    GetPage(
      name: _Paths.APPRAISE_ORDER,
      page: () => const AppraiseOrderView(),
      binding: AppraiseOrderBinding(),
    ),
    GetPage(
      name: _Paths.MY_REFUND_ORDER,
      page: () => const MyRefundOrderView(),
      binding: MyRefundOrderBinding(),
    ),
    GetPage(
      name: _Paths.MY_ACTIVITY_FORECAST,
      page: () => const MyActivityForecastView(),
      binding: MyActivityForecastBinding(),
    ),
    GetPage(
      name: _Paths.MY_VIP,
      page: () => const MyVipView(),
      binding: MyVipBinding(),
    ),
    GetPage(
      name: _Paths.ACCOUNT_INFO,
      page: () => const AccountInfoView(),
      binding: AccountInfoBinding(),
    ),
    GetPage(
      name: _Paths.CHANGE_PHONE,
      page: () => const ChangePhoneView(),
      binding: ChangePhoneBinding(),
    ),
    GetPage(
      name: _Paths.CHANGE_PASSWORD,
      page: () => const ChangePasswordView(),
      binding: ChangePasswordBinding(),
    ),
    GetPage(
      name: _Paths.CHANGE_GENDER,
      page: () => const ChangeGenderView(),
      binding: ChangeGenderBinding(),
    ),
    GetPage(
      name: _Paths.CHANGE_MEMBER_NAME,
      page: () => const ChangeMemberNameView(),
      binding: ChangeMemberNameBinding(),
    ),
    GetPage(
      name: _Paths.CHANGE_MEMBER_AVATAR,
      page: () => const ChangeMemberAvatarView(),
      binding: ChangeMemberAvatarBinding(),
      children: [
        GetPage(
          name: _Paths.FORGOT_PWD,
          page: () => const ForgotPwdView(),
          binding: ForgotPwdBinding(),
        ),
        GetPage(
          name: _Paths.SPLASH,
          page: () => const SplashView(),
          binding: SplashBinding(),
        ),
      ],
    ),
    GetPage(
      name: _Paths.CHANGE_PAY_PWD,
      page: () => const ChangePayPwdView(),
      binding: ChangePayPwdBinding(),
    ),
    GetPage(
      name: _Paths.RESET_PAY_PWD,
      page: () => const ResetPayPwdView(),
      binding: ResetPayPwdBinding(),
    ),
    GetPage(
      name: _Paths.FORGET_PAY_PWD,
      page: () => const ForgetPayPwdView(),
      binding: ForgetPayPwdBinding(),
    ),
    GetPage(
      name: _Paths.MY_WEBVIEW,
      page: () => const MyWebviewView(),
      binding: MyWebviewBinding(),
    ),
    GetPage(
      name: _Paths.BINDTEL,
      page: () => BindTelView(),
      binding: BindTelBinding(),
    ),
    GetPage(
      name: _Paths.SET_PAY_PWD,
      page: () => const SetPayPwdView(),
      binding: SetPayPwdBinding(),
    ),
    GetPage(
      name: _Paths.IMAGE_TEXT_UPLOAD,
      page: () => const ImageTextUploadView(),
      binding: ImageTextUploadBinding(),
    ),
    GetPage(
      name: _Paths.VIDEO_UPLOAD,
      page: () => const VideoUploadView(),
      binding: VideoUploadBinding(),
    ),
    GetPage(
      name: _Paths.FOODIE_ARTICLES,
      page: () => const FoodieArticlesView(),
      binding: FoodieArticlesBinding(),
    ),
  ];
}
