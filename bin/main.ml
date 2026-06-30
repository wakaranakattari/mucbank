type transaction = {
  id: int;
  name: string;
  amount: float;
  date: string;
  description: string;
}

let transactions = ref []
let next_id = ref 1

let clear_screen () =
  Printf.printf "\x1B[2J\x1B[3J\x1B[H"

let center_text width text =
  let len = String.length text in
  if len >= width then
    text
  else
    let left = (width - len) / 2 in
    let right = width - left - len in
    String.make left ' ' ^ text ^ String.make right ' '

let header title =
  Printf.printf "┌────────────────────────────────────────┐\n";
  Printf.printf "│%-40s│\n" (center_text 40 title);
  Printf.printf "└────────────────────────────────────────┘\n"

let add_transaction () =
  clear_screen ();
  header "Add transaction";
  Printf.printf "Add transaction\n";

  Printf.printf "Enter name transaction: ";
  let name_transaction = read_line () in

  Printf.printf "Enter amount transaction: ";

  let amount_transaction = read_line () in

  Printf.printf "Enter date transaction: ";
  let date_transaction = read_line () in

  Printf.printf "Enter description transaction: ";
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
  Printf.printf "Transaction added\n"

let view_transactions () =
  clear_screen ();
  if !transactions = [] then
    Printf.printf "No transactions\n"
  else
    List.iter (fun t ->
      Printf.printf "#%d | %s | %.2f | %s | %s \n"
        t.id t.name t.amount t.date t.description
    ) !transactions

let menu () =
  let running = ref true in

  while !running do
    clear_screen ();

    Printf.printf "Menu\n\n";
    Printf.printf "1. Add transaction\n";
    Printf.printf "2. View transactions\n";
    Printf.printf "3. Exit\n\n";
    Printf.printf "Select an option:\n";
    Printf.printf "> ";
    let option = read_line () in

    begin match option with
    | "1" ->
      add_transaction ();
      Printf.printf "\nPress Enter to continue...";
      ignore (read_line ())
    | "2" ->
      view_transactions ();
      Printf.printf "\nPress Enter to continue...";
      ignore (read_line ())
    | "3" ->
      clear_screen ();
      Printf.printf "Goodbye";
      running := false;
    | _ ->
      Printf.printf "Invalid option\n";
      Printf.printf "\nPress Enter to continue...";
      ignore (read_line ())
    end;
  done

let () =
  clear_screen ();
  Printf.printf "Welcome to Bank\n";
  Printf.printf "\nPress Enter to start...";
  ignore (read_line ());
  menu ()
