(**
   银行模块 - mucbank 应用程序的主菜单模块
   包含用户交互的主循环及完整的菜单系统
*)

open Utils
open Types
open Transactions

(**
   menu 函数 - 启动主程序循环，显示交互式菜单
   
   用户界面:
   每次迭代开始时清空终端屏幕，然后显示菜单标题和选项列表。
   
   菜单选项:
   - 1. 添加交易: 调用 add_transaction 函数
   - 2. 查看交易: 调用 view_transactions 函数
   - 3. 退出: 清屏显示再见信息并终止循环
   
   错误处理:
   无效输入会显示错误信息，并提示用户按 Enter 继续。
   程序不会因无效输入而崩溃或退出。
   
   循环控制:
   使用 running 引用作为循环标志。
   只有选择选项 3 时 running := false 才会退出循环。
   
   交互细节:
   每次操作后程序会暂停并等待用户按 Enter 键，
   确保用户能看到操作结果后再返回主菜单。
   
   @return 该函数不返回值 (unit)
*)
let menu () =
  let running = ref true in

  while !running do
    clear_screen ();
    header "mucbank";

    Printf.printf "1. 添加交易\n";
    Printf.printf "2. 查看交易\n";
    Printf.printf "3. 退出\n\n";
    Printf.printf "请选择-个选项：\n";
    Printf.printf "> ";
    let option = read_line () in

    begin match option with
    | "1" ->
      add_transaction ();
      press_enter_to_continue "按回车键继续..."
    | "2" ->
      view_transactions ();
      press_enter_to_continue "按回车键继续..."
    | "3" ->
      clear_screen ();
      header "再见";
      running := false;
    | _ ->
      Printf.printf "无效选项\n";
      press_enter_to_continue "按回车键继续..."
    end;
  done