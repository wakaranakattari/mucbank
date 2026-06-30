(**
   工具模块 - mucbank 的辅助函数集合
   提供清屏、文本居中、标题渲染和暂停功能
*)

(**
   清屏函数 - 使用 ANSI 转义序列清除终端内容
   清空屏幕并重置光标位置到左上角
*)
let clear_screen () =
  Printf.printf "\x1B[2J\x1B[3J\x1B[H"

(**
   文本居中 - 在指定宽度内将文本居中
   
   参数:
   - width: 总宽度
   - text: 需要居中的文本
   
   返回: 补齐空格后的字符串，总长度为 width
   
   算法:
   如果 text 长度 >= width，直接返回原文本
   否则计算左右空格数，用 String.make 生成空格并拼接
*)
let center_text width text =
  let len = String.length text in
  if len >= width then
    text
  else
    let left = (width - len) / 2 in
    let right = width - left - len in
    String.make left ' ' ^ text ^ String.make right ' '

(**
   绘制标题框 - 用 Unicode 边框绘制带标题的方框
   
   格式:
   ┌────────────────────────────────────────┐
   │              标题文本                  │
   └────────────────────────────────────────┘
   
   宽度固定为 40 字符
*)
let header title =
  Printf.printf "┌────────────────────────────────────────┐\n";
  Printf.printf "│%-40s│\n" (center_text 40 title);
  Printf.printf "└────────────────────────────────────────┘\n"

(**
   暂停并等待用户输入 - 显示提示信息后等待 Enter 键
   
   用于分页显示，让用户有时间阅读输出内容
   
   参数:
   - prompt: 显示的提示信息
   
   行为: 打印 prompt，然后丢弃用户输入的整行内容
*)
let press_enter_to_continue prompt =
  Printf.printf "\n%s" prompt;
  ignore (read_line ())