(*---------------------------------------------------------------------------
  @name: util.ml
  @description: 工具模块
-----------------------------------------------------------------------------*)

open Graphics
open Printf

(* 打印 Array 一维数组 *)
let print_row row =
  printf "[ ";
  Array.iter (fun x -> printf "%f " x) row;
  printf "]\n"
;;

(* 打印 Array 类型矩阵/二维数组 *)
let print_matrix matr =
  printf "[\n";
  Array.iter print_row matr;
  printf "]\n";
;;

(* 获取 Array 矩阵中的子矩阵 *)
let get_subMatrix matr start_pos end_pos =
  assert (start_pos >= 0);
  assert (end_pos >= start_pos);

  let subMat = Array.make (end_pos - start_pos) [|0.|] in
  let rec for1 i =
    if i = end_pos then subMat
    else (
      subMat.(i-start_pos) <- matr.(i);
      for1 (i+1);
    )
  in
  for1 start_pos
;;

(* 画散点图 *)
let scatter x_arr y_arr color =
  let rec for1 i =
    if i < 0 then ()
    else (
      (* printf "x:%d, y:%d\n" x_arr.(i) y_arr.(i); *)
      draw_circle x_arr.(i) y_arr.(i) 1;  (* 用画小圆代替画点 *)
      for1 (i-1);
    )
  in
  set_color color;
  for1 ((Array.length x_arr) - 1);

;;