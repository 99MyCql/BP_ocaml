# BP-network

## Introduction

基于 OCaml 语言实现 BP 神经网络。

最终，使用 y=x^2 函数模型 和 mnist 手写数字数据集进行训练和预测。

## Project Structure

- `bin/`: 目标文件目录
- `data/`: mnist手写数字数据集目录
- `src/`: 源代码目录
  - `BP.ml`: BP神经网络模块
  - `BP.mli`: BP模块的接口文件
  - `main.ml`: 运行入口文件，主要用于测试BP和mnist模块
  - `mnist.ml`: 解析mnist数据集模块
  - `mnist.mli`: mnist模块的接口文件
  - `util.ml`: 工具模块，提供打印 Array 数组等接口
  - `util.mli`: 工具模块的接口文件
- `README.md`: 说明文档
- `Makefile`: 工程脚本文件

## Analysis & Design

### Requirement Analysis

- [x] 实现BP神经网络算法。完成者：[dounine](https://github.com/99MyCql)
  - [x] 初始化
  - [x] 训练
  - [x] 预测
  - [x] 使用 y=x^2 模型进行测试
- [x] 解析 mnist 手写数字数据集，并进行测试。完成者：[TayMarine](https://github.com/TayMarine)
  - [x] 解析 mnist 数据集
  - [x] 显示手写数字图片
  - [x] 使用 BP 神经网络进行预测

### Data Structure Design

#### BP

BP神经网络模块中的关键数据结构，如下：

- `x_count : int`: 输入层神经元个数
- `mid_count : int`: 中间层神经元个数
- `y_count : int`: 输出层神经元个数
- `x2mid_weight : float[][]`: 输入层到中间层的权值
- `mid2y_weight : float[][]`: 中间层到输出层的权值
- `mid_theta : float[]`: 中间层阈值
- `y_theta : float[]`: 输出层阈值
- `eta : float`: 学习率
- `precision : float`: 误差精度
- `max_train_count : int`: 最大训练次数

#### Mnist

- `image_info: type`: 用于存储图片数据的记录类型，有四个分量
- `label_info : type`: 用于存储标签数据的记录类型，有两个分量
- `pixel: int[][]`: 二维数组存储所有图片的28*28的像素值，每张图片的像素描述归为一个一维数组
- `single : int[][]`: 存储一张图片的28*28的像素值
- `label_num : int[][]`: 存储所有标签数据

### Interface Design

- `BP`模块(详情见[BP.mli](./src/BP.mli)):

  - `init(x_count, mid_count, y_count, eta=03, max_train_count=100, precision=0.0001)`: 初始化神经网络
  - `train(X_list, Y_list)`: 训练神经网络
  - `predict(X_list)`: 对输入数据进行预测

- `mnist`模块(详情见[mnist.mli](./src/mnist.mli)):

  - `get_data(num)`: 获取mnist数据集中的数据
  - `draw (pixel_ary, color)`: 画图

- `util`模块(详情见[util.mli](./src/util.mli)):

  - `print_row(row)`: 打印一维 Array 数组
  - `print_matrix(matr)`: 打印二维 Array 数组
  - `get_subMatrix(matr, start_pos, end_pos)`: 获取二维数组的子数组
  - `scatter(x_arr, y_arr, color)`: 画散点图

### Algorithm Design

#### BP

主要对`train()`函数进行算法设计：

```design
train(X_list, Y_list):
  for 1 -> max_train_count:   # 重复训练
    float E[]                 # 每一个样例的均方误差
    for X,Y in X_list,Y_list: # 遍历所有样例
      Y_out, mid_out = compute_Y(X) # 根据 X 计算 Y
      E.append(compute_e(Y, Y_out)) # 根据预测值和实际值，计算均方误差
      mid2y_grad = compute_mid2y_grad(Y, Y_out)   # 计算中间层到输出层的梯度项
      x2mid_grad = compute_x2mid_grad(mid2y_grad) # 计算输入层到中间层的梯度项
      update_mid2y(mid2y_grad)  # 更新中间层到输出层的权值和输出层的阈值
      update_x2mid(x2mid_grad)  # 更新输入层到中间层的权值和中间层的阈值
    E_mean = sum(E)/len(E)    # 训练完所有样例后，计算累计误差
    if (E_mean < precision)   # 如果误差小于精度，则不进行重复训练
      break
```

#### Mnist

图片文件中前十六个字节为标记字节，前四个字节为魔数(magic number)，接下来的四个字节为图片数量(值为60,000)，在之后的八个字节分别是每张图片像素点的行数和列数，都是四字节数据。剩下的都是图片像素数据，每个像素点为1个字节，属于灰度图，784个字节为1张图片(28x28=784)。

标签文件中只有前八个字节是标记，与图片文件的前八个字节意义相同。剩下的为标签数据，每个标签1字节，其有效数据的范围在0~9之间。

## Usage

using in linux recommend.

compile:

```bash
make
```

run:

```bash
make run
```

clean:

```bash
make clean
```

## Format

### Git Commit

```cmd
git commit -m "type: description"
```

- type:
  - feat：新功能（feature）
  - fix：修补bug
  - docs：文档（documentation）
  - style：格式（不影响代码运行的变动）
  - refactor：重构（即不是新增功能，也不是修改bug的代码变动）
  - test：增加测试
  - chore：构建过程或辅助工具的变动
- description: 详细描述
