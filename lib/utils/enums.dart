// 支付类型
enum PayTypeEnum {
  cart, // 集市/购物车 和goods分2种, 但共用一个接口 不是cart, 传订单号
  goods, // 集市 你传支付号
  fieldClaim, // 田地认领
  fieldDecision, // 田地决策
  granary, // 粮仓加工
  special, // 优源专享卡
  remaining // 余额
}
