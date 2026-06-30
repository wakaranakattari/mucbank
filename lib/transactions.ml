(**
   交易模块 - 管理 mucbank 的所有交易操作
   包含交易的创建、存储和查询功能
*)

open Types
open Utils

(**
   交易存储:
   - transactions: 可变列表，存储所有交易记录
   - next_id: 自增计数器，为每笔新交易生成唯一 ID
*)
let transactions = ref []
let next_id = ref 1

(**
   add_transaction () - 交互式添加新交易
   
   流程:
   1. 清屏并显示标题 "添加交易"
   2. 依次提示用户输入:
      - 交易名称
      - 交易金额 (自动转换为 float)
      - 交易日期
      - 交易描述
   3. 使用当前 next_id 创建交易记录
   4. 将交易添加到列表头部
   5. next_id 自增 1
   6. 显示成功消息
   
   注意:
   - 输入金额时若格式错误，程序会崩溃
   - 日期格式不做验证，按字符串存储
   
   @return 不返回值 (unit)
*)
let add_transaction () =
  clear_screen ();
  header "添加交易";

  Printf.printf "输入事务名称：";
  let name_transaction = read_line () in

  Printf.printf "输入交易金额：";
  let amount_transaction = read_line () in

  Printf.printf "输入交易日期：";
  let date_transaction = read_line () in

  Printf.printf "输入交易描述：";
  let description_transaction = read_line () in

  let tx = {
    id = !next_id;
    name = name_transaction;
    amount = float_of_string amount_transaction;
    date = date_transaction;
    description = description_transaction;
  } in

  transactions := tx :: !transactions;
  next_id := !next_id + 1;
  Printf.printf "交易已添加.\n"

(**
   view_transactions () - 显示所有交易记录
   
   流程:
   1. 清屏并显示标题 "查看交易"
   2. 检查交易列表是否为空
      - 空: 显示 "没有交易!"
      - 非空: 遍历列表，格式化输出每笔交易
   
   输出格式:
   #ID | 名称 | 金额 | 日期 | 描述
   
   @return 不返回值 (unit)
*)
let view_transactions () =
  clear_screen ();
  header "查看交易";
  if !transactions = [] then
    Printf.printf "\n没有交易!\n"
  else
    List.iter (fun t ->
      Printf.printf "#%d | %s | %.2f | %s | %s \n"
        t.id t.name t.amount t.date t.description
    ) !transactions

(**
   get_transactions () - 返回当前交易列表
   
   用于其他模块获取交易数据的纯函数。
   
   @return transaction list 当前所有交易的列表
*)
let get_transactions () =
  !transactions