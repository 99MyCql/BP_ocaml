(*---------------------------------------------------------------------------
  @name: BP.ml
  @description: BP神经网络模块
-----------------------------------------------------------------------------*)

open Printf ;;

type tpNetwork = {
  mutable x_count       : int;
  mutable mid_count     : int;
  mutable y_count       : int;
  mutable x2mid_weight  : float array array;
  mutable mid2y_weight  : float array array;
  mutable mid_theta     : float array;
  mutable y_theta       : float array;
}

let g_network : tpNetwork = {
  x_count = 0;
  mid_count = 0;
  y_count = 0;
  x2mid_weight = [||];
  mid2y_weight = [||];
  mid_theta = [||];
  y_theta = [||];
}

let g_eta = ref 0.
let g_precision = ref 0.
let g_max_train_count = ref 0

let init
    ?(eta=0.3)
    ?(max_train_count=100)
    ?(precision=0.0001)
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

  let print_row x =
    printf "[";
    Array.iter (fun x -> printf "%f " x) x;
    printf "]\n"
  in
  printf "[\n";
  Array.iter print_row g_network.x2mid_weight;
  printf "]\n";
;;

let train x_list y_list =
  true ;;

let predict x_list =
  true ;;
