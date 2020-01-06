(*---------------------------------------------------------------------------
  @name: BP.ml
  @description: BP神经网络模块
-----------------------------------------------------------------------------*)

open Printf


(* 神经网络结构体/记录 *)
type tpNetwork = {
  mutable x_count       : int;  (* 输入层神经元个数 *)
  mutable mid_count     : int;  (* 中间层神经元个数 *)
  mutable y_count       : int;  (* 输出层神经元个数 *)
  mutable x2mid_weight  : float array array;  (* 输入层到中间层的权值 *)
  mutable mid2y_weight  : float array array;  (* 中间层到输出层的权值 *)
  mutable mid_theta     : float array;  (* 中间层阈值 *)
  mutable y_theta       : float array;  (* 输出层阈值 *)
}

let debug = true                (* 是否开启调试环境 *)
let g_eta = ref 0.              (* 学习率 *)
let g_precision = ref 0.        (* 误差精度 *)
let g_max_train_count = ref 0   (* 最大训练次数 *)

(* 神经网络结构体实例 *)
let g_network : tpNetwork = {
  x_count = 0;
  mid_count = 0;
  y_count = 0;
  x2mid_weight = [||];
  mid2y_weight = [||];
  mid_theta = [||];
  y_theta = [||];
}


(* 打印 Array 一维数组 *)
let print_row row =
  printf "[";
  Array.iter (fun x -> printf "%f " x) row;
  printf "]\n"
;;

(* 打印 Array 类型矩阵 *)
let print_matrix matr =
  printf "[\n";
  Array.iter print_row g_network.x2mid_weight;
  printf "]\n";
;;


(* 初始化神经网络函数 *)
let init
    ?(eta=0.3)
    ?(max_train_count=100)
    ?(precision=0.01)
    x_count
    mid_count
    y_count =

  print_endline "init()";
  g_network.x_count <- x_count;
  g_network.mid_count <- mid_count;
  g_network.y_count <- y_count;
  g_eta := eta;
  g_precision := precision;
  g_max_train_count := max_train_count;
  g_network.x2mid_weight <- Array.make_matrix x_count mid_count 0.5;
  g_network.mid2y_weight <- Array.make_matrix mid_count y_count 0.5;
  g_network.mid_theta <- Array.make mid_count 0.5;
  g_network.y_theta <- Array.make y_count 0.5;

  if debug then print_matrix g_network.x2mid_weight;
  if debug then print_matrix g_network.mid2y_weight;
;;


(* sigmoid 激活函数 *)
let sigmoid x =
  1. /. (1. +. exp(-.x))
;;

(* 计算预测 y 值 *)
let compute_y x =
  if debug then print_endline "===> compute_y()";

  (* 计算中间层输入 *)
  let mid_in = Array.make g_network.mid_count 0. in
  let rec mid_for1 i =
    (* if debug then printf "compute_y->mid_for1->i:%d\n" i; *)
    let rec x_for j sum =
      (* if debug then printf "compute_y->x_for->j:%d\n" j; *)
      if j < 0 then sum
      else x_for (j-1) (sum +. g_network.x2mid_weight.(j).(i) *. x.(j))
    in
    if i < 0 then ()
    else (
      mid_in.(i) <- x_for (g_network.x_count-1) 0.;
      mid_for1 (i-1);
    )
  in
  mid_for1 (g_network.mid_count-1);

  (* 计算中间层输出 *)
  let mid_out = Array.make g_network.mid_count 0. in
  let rec mid_for2 i =
    if i < 0 then ()
    else (
      mid_out.(i) <- sigmoid (mid_in.(i) -. g_network.mid_theta.(i));
      mid_for2 (i-1);
    )
  in
  mid_for2 (g_network.mid_count-1);

  (* 计算输出层输入 *)
  let y_in = Array.make g_network.y_count 0. in
  let rec y_for1 i =
    let rec mid_for3 j sum =
      if j < 0 then sum
      else mid_for3 (j-1) (sum +. g_network.mid2y_weight.(j).(i) *. mid_out.(j))
    in
    if i < 0 then ()
    else (
      y_in.(i) <- mid_for3 (g_network.mid_count-1) 0.;
      y_for1 (i-1);
    )
  in
  y_for1 (g_network.y_count-1);

  (* 计算中间层输出 *)
  let y_out = Array.make g_network.y_count 0. in
  let rec y_for2 i =
    if i < 0 then ()
    else (
      y_out.(i) <- sigmoid (y_in.(i) -. g_network.y_theta.(i));
      y_for2 (i-1);
    )
  in
  y_for2 (g_network.y_count-1);

  y_out, mid_out
;;


(* 计算均方误差 *)
let compute_e y y_out =
  let rec for1 i sum =
    if i < 0 then sum /. 2.
    else for1 (i-1) (sum +. (y_out.(i) -. y.(i)) *. (y_out.(i) -. y.(i)))
  in
  for1 (g_network.y_count-1) 0.
;;


(* 计算中间层到输出层的梯度项 *)
let compute_mid2y_grad y y_out =
  0.001
;;


(* 计算输入层到中间层的梯度项 *)
let compute_x2mid_grad mid2y_grad mid_out =
  0.001
;;


(* 更新中间层到输出层的权值和输出层的阈值 *)
let update_mid2y mid2y_grad mid_out =
  ()
;;


(* 更新输入层到中间层的权值和中间层的阈值 *)
let update_x2mid x2mid_grad =
  ()
;;


(* 训练神经网络函数 *)
let train x_arr y_arr =

  (* 第一层循环，重复训练数据集 *)
  let rec for1 n =
    if debug then print_endline (string_of_int n);
    if n=0 then ()
    else
      let e_arr = Array.make (Array.length x_arr) 1. in  (* 每个样例训练之后的均方误差的数组 *)

      (* 第二层循环，遍历数据集 *)
      let rec for2 i =
        if i < 0 then ()
        else (
          let x = x_arr.(i)
          and y = y_arr.(i) in
          let y_out, mid_out = compute_y x in  (* 计算预测 y 值 *)
          if debug then (
            printf "mid_out->";
            print_row mid_out;
            printf "y_out->";
            print_row y_out;
          );
          e_arr.(i) <- (compute_e y y_out);                         (* 计算均方误差 *)
          let mid2y_grad = compute_mid2y_grad y y_out in            (* 计算中间层到输出层的梯度项 *)
          let x2mid_grad = compute_x2mid_grad mid2y_grad mid_out in (* 计算输入层到中间层的梯度项 *)
          update_mid2y mid2y_grad mid_out;  (* 更新中间层到输出层的权值和输出层的阈值 *)
          update_x2mid x2mid_grad;          (* 更新输入层到中间层的权值和中间层的阈值 *)
          for2 (i-1)
        )
      in
      for2 ((Array.length x_arr)-1);
      if debug then (
        printf "e_arr->";
        print_row e_arr;
      );

      (* 计算累计误差的均值 *)
      let e_mean e_arr =
        (* 计算累计误差的和 *)
        let e_sum e_arr =
          Array.fold_left (fun i s -> i +. s) 0. e_arr;
        in
        (e_sum e_arr) /. float_of_int (Array.length e_arr)
      in
      if (e_mean e_arr) < !g_precision then ()
      else for1 (n-1)
  in
  for1 !g_max_train_count
;;

let predict x_arr =
  true ;;
