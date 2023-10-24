import 'package:get/get.dart';

class Messages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'zh_CN': {
          'english': '英文',
          "home": "主页",
          "market": "集市",
          // "category": "粮仓",
          "granary": "粮仓",
          "cart": "购物车",
          "account": "我的",
          "app_name": "购物",
          "women": "女装",
          "lingerie": "内衣",
          "kids": "童装",
          "men": "男装",
          "sport": "运动装",
          "pets": "宠物",
          "recommend": "推荐",
          "home_like": "推荐好物",
          "promotion": "优惠活动",
          "shop_category": "分类",
          "new_products": "新品推荐",
          "search": "搜索关键字",
          "price": "¥%s",
          "flash_sale": "限时秒杀",
          "end_in": "结束时间",
          "edit": "编辑",
          "cart_choice": "全选",
          "checkout": "结算",
          "delete": "删除",
          "finish": "完成",

          "open_member": "立即查看",
          "more_discounts": "享受更多折扣",
          "buy_member": "优源专享卡",
          "integral": "积分",
          "coupon": "优惠券",
          "follow": "关注",
          "dfk": "待付款",
          "dsh": "待收货",
          "dpj": "待评价",
          "all_order": "全部订单",
          "contact_our": "联系客服",
          "add_cart": "加入购物车",
          "buy_now": "立即购买",
          "tab_goods": "商品",
          "tab_evaluate": "评价",
          "tab_detail": "详细",
          "free_return": "无忧退货",
          "quick_refund": "快速退款",
          "free_shipping": "免费包邮",
          "service_description": "服务说明",
          "product_parameters": "商品参数",
          "date_brand": "生产日期、品牌",
          "select_specifications": "选择规格",
          "evaluation": "宝贝评价(%s)",
          "view_all": "查看全部",
          "product_detail": "商品详情",
          "quantity": "数量",
          "please_tick_agree_login": "请勾选同意后再登录",
          "more_exciting_after_login": "登录后更精彩",
          "enter_username": "请输入手机号",
          "enter_password": "请输入密码",
          "enter_verification": "请输入验证码",
          "get_verification_ok": "验证码已发送",
          "read_and_ageree": "已阅读并同意",
          "service_agreement": "《用户协议》及《隐私政策》",
          "login": "登录",
          "register": "注册",
          "or_join_with": "或着",
          "username_langth": "用户名长度必须大于6",
          "password_langth": "密码长度必须大于6",
          "setting": "设置",
          //
          "address_setting": "地址管理",
          "account_security": "账户安全",
          "payment_options": "支付管理",
          "privacy_policy": "隐私政策",
          "language": "语言设置",
          "country_region": "国家地区",
          "about_me": "关于我们",
          "low": "库存紧张",
          "add_success": "添加成功",
          "order_confirm": "确认订单",
          "pay": "确认支付",
          "order_pay": "订单支付",
          "order_detail": "订单详细",
          "order_pay_success": "支付成功",
          "my_address_book": "我的收货地址",
          "cancel": "取消",
          "hint": "温馨提示",
          "delete_address_book": "确定要删除该地址吗?",
          "edit_address": "编辑收货地址",
          "add_address": "添加收货地址",
          "close": "关闭",
          "data_failed": "数据错误",
          // 刷新
          "Pull to refresh": "下拉刷新",
          "No more": "已经到底了",
          "Release ready": "松开刷新",
          "Refreshing...": "刷新中...",
          "Succeeded": "刷新成功!",
          "Pull to load": "上拉加载更多",
          "Loading...": "加载中...",
          "Failed": "失败了",
          "Last updated at %T": "上次更新在 %T",
        },
        'en_US': {
          "english": "english",
          "home": "Hone",
          "category": "Category",
          "cart": "Cart",
          "account": "Account",
          "app_name": "Shopping",
          "women": "WOMEN",
          "lingerie": "Lingerie",
          "kids": "KIDS",
          "men": "MEN",
          "sport": "SPORT",
          "pets": "PETS",
          "recommend": "FOR + YOU",
          "home_like": "You May Aiso Like",
          "promotion": "Promotion",
          "shop_category": "Shop By Category",
          "new_products": "NEW PRODUCTS",
          "search": "Search",
          "price": "\$%s",
          "flash_sale": "Flash Sale",
          "end_in": "End in",
          "edit": "Edit",
          "cart_choice": "All",
          "checkout": "Checkout",
          "delete": "Delete",
          "finish": "Finish",
          "open_member": "Open Now",
          "more_discounts": "Enjoy more discounts",
          "buy_member": "Buy Membership",
          "integral": "Integral",
          "coupon": "Coupon",
          "follow": "Follow",
          //
          "dfk": "Unpaid",
          "dsh": "Processing",
          "dpj": "Shipped",
          "all_order": "All Orders",
          "contact_our": "Contact Customer Service",
          "add_cart": "Add to cart",
          "buy_now": "Buy now",
          "tab_goods": "Goods",
          "tab_evaluate": "Evaluate",
          "tab_detail": "Detail",
          "free_return": "Worry-free return",
          "quick_refund": "Quick Refund",
          "free_shipping": "Free shipping",
          "service_description": "Service Description",
          "product_parameters": "Product parameters",
          "date_brand": "Date of manufacture, brand",
          "select_specifications": "Select Specifications",
          "evaluation": "Baby evaluation (%s)",
          "view_all": "View all",
          "product_detail": "Product Details",
          "quantity": "Quantity",
          "please_tick_agree_login": "Please tick to agree before logging in",
          "more_exciting_after_login": "More exciting after login",
          "enter_username": "Please enter your Username",
          "enter_password": "Please enter password",
          "read_and_ageree": "I have read and agree",
          "service_agreement": "Service Agreement",
          "login": "Login",
          "register": "Register",
          "or_join_with": "Or join with",
          "username_langth": "Username length must be greater than 6",
          "password_langth": "Password length must be greater than 6",
          "setting": "Setting",
          //
          "address_setting": "Address Book",
          "account_security": "Account Security",
          "payment_options": "Payment Options",
          "privacy_policy": "Privac Policy",
          "language": "Language",
          "country_region": "Country/Region",
          "about_me": "About Me",
        }
      };
}
