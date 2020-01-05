# BP-network

## Introduction

基于 OCaml 语言实现 BP 神经网络。

最终，使用 y=x^2 函数模型 和 mnist 手写数字数据集进行训练和预测。

## Project Structure

- `bin/`
- `src/`
  - `BP.ml`
  - `main.ml`
- `README.md`

## Analysis & Design

### Requirement Analysis

- [ ] 实现BP神经网络算法
  - [ ] 初始化
  - [ ] 训练
  - [ ] 预测
- [ ] 使用 y=x^2 模型进行测试
- [ ] 使用 mnist 手写数字数据集进行测试

### Data Structure Design

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

### Interface Design

- `init(x_count, mid_count, y_count, eta=03, max_train_count=100, precision=0.0001)`: 初始化神经网络

- `train(X_list, Y_list)`: 训练神经网络

- `predict(X_list)`: 对输入数据进行预测

### Algorithm Design

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
      update_mid2y()  # 更新中间层到输出层的权值和输出层的阈值
      update_x2mid()  # 更新输入层到中间层的权值和中间层的阈值
    E_mean = sum(E)/len(E)    # 训练完所有样例后，计算累计误差
    if (E_mean < precision)   # 如果误差小于精度，则不进行重复训练
      break
```

## Usage

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
