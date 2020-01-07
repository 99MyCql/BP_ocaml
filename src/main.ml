(*---------------------------------------------------------------------------
  @name: main.ml
  @description: 运行入口文件，测试神经网络
-----------------------------------------------------------------------------*)

open Printf
open Graphics


let data_count = 500  (* 数据集大小 *)


(* 使用 y=x^2 模型对 BP 模块进行测试 *)
let test1 () =
  let x_count = 1 and y_count = 1 and mid_count = 10 in
  let x_arr = Array.make_matrix data_count x_count 0. in
  let y_arr = Array.make_matrix data_count y_count 0. in

  (* 生成符合 y=x^2 模型的数据 *)
  let rec for1 i =
    let rec for2 j =
      if j < 0 then ()
      else (
        x_arr.(i).(j) <- (2. *. Random.float 1. -. 1.);   (* 生成(-1,1)之间的随机数 x *)
        y_arr.(i).(j) <- x_arr.(i).(j) *. x_arr.(i).(j) +. Random.float 0.1;  (* 生成 y=x^2 ，添加噪音更真实 *)
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

  (* 初始化神经网络 *)
  BP.init x_count
          mid_count
          y_count
          ~eta:0.5
          ~max_train_count:2000
          ~precision:0.0001
          ~train_gap:200;

  (* 训练神经网络 *)
  BP.train x_arr y_arr;

  (* 预测数据 *)
  let y_pred_arr = BP.predict x_arr in

  (* 在控制台对比原数据和预测数据 *)
  printf "original[10-20]: ";
  Util.print_matrix (Util.get_subMatrix y_arr 10 20);
  printf "predict[10-20]: ";
  Util.print_matrix (Util.get_subMatrix y_pred_arr 10 20);

  (* 画图对比原数据和预测数据 *)
  let x_arr_temp = Array.map (fun x -> int_of_float (x.(0) *. 300. +. 300.)) x_arr in   (* x 值 *)
  let y_arr_temp = Array.map (fun x -> int_of_float (x.(0) *. 300.)) y_arr in           (* 原 y 值 *)
  let y_pred_arr_temp = Array.map (fun x -> int_of_float (x.(0) *. 300.)) y_pred_arr in (* 预测 y 值 *)
  open_graph " 600x300";  (* 打开一个600x300的窗口 *)
  set_line_width 5;       (* 设置画线宽度为2 *)
  moveto 220 280;         (* 将绘图点移动到(250,280)处 *)
  draw_string "original: red, predict: green";    (* 显示标题 *)
  Util.scatter x_arr_temp y_arr_temp red;         (* 画原数据散点图 *)
  Util.scatter x_arr_temp y_pred_arr_temp green;  (* 画预测数据的散点图 *)
  read_line ();
;;

let main () =
  test1()
in
main ();;