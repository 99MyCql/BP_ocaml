(*---------------------------------------------------------------------------
  @name: BP.mli
  @description: BP神经网络模块的接口
  @author: dounine
-----------------------------------------------------------------------------*)

(*
  Function init:
    初始化神经网络

  Arguments:
    ?(eta:float = 0.3)            学习率
    ?(max_train_count:int = 100)  最大训练次数
    ?(precision:float = 0.00001)  最小误差精度
    ?(train_gap:int = 10)         每训练 train_gap 次输出相关信息
    x_count:int     输入层神经元
    mid_count:int   中间层神经元
    y_count:int     输出层神经元

  Returns:
    uint: nothing.

  Remark:
*)
val init :
  ?eta:float ->
  ?max_train_count:int ->
  ?precision:float ->
  ?train_gap:int ->
  int ->
  int ->
  int ->
  unit

(*
  Function train:
    训练神经网络

  Arguments:
    x_arr:float array array   x 值训练数据集。第一维是样例，第二维是每个样例的一个或多个输入变量 x
    y_arr:float array array   y 值训练数据集

  Returns:
    uint: nothing.

  Remark: using after init
*)
val train :
  float array array ->
  float array array ->
  unit

(*
  Function predict:
    预测数据

  Arguments:
    x_arr:float array array   x 值预测数据集。第一维是样例，第二维是每个样例的一个或多个输入变量 x

  Returns:
    y_pred_arr:float array array   y 值预测结果数据集

  Remark: using after train
*)
val predict :
  float array array ->
  float array array
