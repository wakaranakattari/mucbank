(**
   类型模块 - mucbank 的数据类型定义
   交易类型 - 表示一笔银行交易记录
   字段: id(唯一标识符), name(交易名称), amount(金额), date(日期), description(描述)
*)
type transaction = {
  id: int;
  name: string;
  amount: float;
  date: string;
  description: string;
}