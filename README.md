# 五连杆轮腿Matlab仿真
### 1. 仿真环境

- Matlab R2023b 
### 2. 文件结构
```
│  sys_calc.m           系统参数计算
│  leg_calc.m           腿参数计算/VMC

│  lb_sfit.sfit         腿长拟合(cftool)
│  leg_sfit.sfit        转动惯量拟合(cftool)

│  leg_sim.slx          五连杆仿真
│  leg_sim_calc.m       用于从仿真中拟合腿部数据
│  sys_sim.slx          系统仿真

│  sys_calc_whx.m       哈工程建模，未完成
│  sys_sim_whx.slx

/data               数据文件
/function           生成的函数
/test               测试函数
/IMU_position       加速度计定位测试
/kalman_observer    卡尔曼观测器
```
### 3.使用指南

首先用Matlab打开当前文件夹，会自动进行参数计算，未自动进行可手动运行`startup.m`

- 参数计算

  在`sys_calc.m`中填入系统参数，运行脚本可得到拟合文件，在`/function`中找到`LQR_k.prj`可生成c++代码供外部使用。

  在`leg_calc.m`中填入五连杆参数，运行脚本会自动生成函数，在`/function`中找到对应的`*.prj`可生成c++代码，在`leg_calc.m`中有函数说明
  
- 启动仿真

  直接双击`sys_sim.slx`即可。
  
  > 仿真运行速度取决于CPU单核性能，通常来说比较缓慢
