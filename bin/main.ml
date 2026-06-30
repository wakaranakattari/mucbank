(**
   Main 模块 - mucbank 应用程序入口点
   负责初始化界面并启动主菜单
*)

open Mucbank_lib.Utils
open Mucbank_lib.Bank

let () =
  clear_screen ();

  Printf.printf "欢迎来到 mucbank!\n";
  press_enter_to_continue "按回车键开始...";
  menu ()