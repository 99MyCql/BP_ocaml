(*---------------------------------------------------------------------------
  @name: main.ml
  @description: 运行入口文件，测试神经网络
-----------------------------------------------------------------------------*)

open Printf


let data_count = 500  (* 数据集大小 *)


(* 使用 y=x^2 模型对 BP 模块进行测试 *)
let test1 () =
  let x_count = 1 and y_count = 1 and mid_count = 10 in
  let x_arr = Array.make_matrix data_count x_count 0. in
  let y_arr = Array.make_matrix data_count y_count 0. in

  let rec for1 i =
    let rec for2 j =
      if j < 0 then ()
      else (
        x_arr.(i).(j) <- (2. *. Random.float 1. -. 1.);
        y_arr.(i).(j) <- x_arr.(i).(j) *. x_arr.(i).(j);
        for2 (j-1);
      )
    in
    if i < 0 then ()
    else (
      for2 (x_count-1);
      for1 (i-1);
    )
  in
  for1 (data_count-1);

  BP.init x_count
          mid_count
          y_count
          ~eta:0.9
          ~max_train_count:2000
          ~precision:0.0001
          ~train_gap:200;    (* 初始化神经网络 *)
  BP.train x_arr y_arr;       (* 训练神经网络 *)

  (* let y_pred_arr = BP.predict x_arr in
  printf "source: ";
  Util.print_matrix y_arr;
  printf "predict: ";
  Util.print_matrix y_pred_arr; 预测数据 *)
;;

test1()