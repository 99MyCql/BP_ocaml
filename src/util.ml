(*---------------------------------------------------------------------------
  @name: util.ml
  @description: 工具模块
-----------------------------------------------------------------------------*)

open Printf

(* 打印 Array 一维数组 *)
let print_row row =
  printf "[";
  Array.iter (fun x -> printf "%f " x) row;
  printf "]\n"
;;

(* 打印 Array 类型矩阵/二维数组 *)
let print_matrix matr =
  printf "[\n";
  Array.iter print_row matr;
  printf "]\n";
;;