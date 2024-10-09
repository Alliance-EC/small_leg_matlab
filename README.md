# 串联腿Matlab仿真（五连杆改）
### 1. 仿真环境

- Matlab R2023b 
### 2. 文件结构
```
│  sys_calc.m           	系统参数计算
(改)│  small_leg_calc.m     腿参数计算/VMC

│  lb_sfit.sfit        	 	腿长拟合(cftool)
│  leg_sfit.sfit        	转动惯量拟合(cftool)

│  leg_sim.slx          	五连杆仿真
│  leg_sim_calc.m       	用于从仿真中拟合腿部数据
│  sys_sim.slx          	系统仿真

│  sys_calc_whx.m       	哈工程建模，未完成
│  sys_sim_whx.slx

\function\codegen\lib 		生成的cpp函数
/data               		数据文件
/test               		测试函数，目前为空
/IMU_position       		加速度计定位测试
/kalman_observer    		卡尔曼观测器
```
