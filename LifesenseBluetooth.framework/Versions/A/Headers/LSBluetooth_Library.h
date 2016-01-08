//
//  LSBluetooth_Library.h
//  LSBluetooth-Library
//
//  Created by chixiang.cai on 14-11-14.
//  Copyright (c) 2014年 Lifesense. All rights reserved.
//  current version 3.0.1

#import <Foundation/Foundation.h>
#import "LSBLEDeviceManager.h"
#import "NSMutableArray+QueueAdditions.h"


@interface LSBluetooth_Library : NSObject

//version 1.0.0

//version 1.0.1 update records
/*
 * (1)新增支持厨房秤协议，在LSBleDataReceiveDelegate.h新增三个协议回调方法，
 *    用于接收厨房秤的测量数据及连接状态
 * (2)新增用于根据设备电阻值计算脂肪数据的接口，接口的定义在LSBLEDeviceManager.h
 */

//version v1.0.2
/*
 * (1)新增支持设置体重秤（Baby watchh）声音振动提示功能信息,新增LSVibrationVoice对象
 *
 */

//version 1.0.3
/*
 * 版本1.0.3修复了，LifesenseBluetooth.framework在x86_64,armv7系统平台，以及在Xcode6.1编译不通
 * 过的问题
 */

//version 1.0.4
/*
 * 版本1.0.4修复BabyScale测量数据中的电压解析错误问题，修复BabyScale在工作模式2中测量数据接收失败的
 * 问题
 */

//version 1.0.5
/*
 * 版本1.0.5新增支持修改A2手环显示时间小时制（12h/24h）、及运动距离的计算单位（公里/英里）的转换
 * 在LSPedometerUserInfo中新增两个属性hourSystem,lengthUnit
 */


//version 1.0.6
/*
 * 版本1.0.6修复部分设备在配对过程中，若使用少于8位的通讯密码时，出现配对失败的问题
 */

//version 1.0.7
/*
 * 版本1.0.7 新增支持Salter mibody协议的脂肪秤，ＳalterMibody协议的UUID为7882。
 */

//version 1.0.8
/*
 * 新增支持通过命令启动测量的血压计设备，新增专用于连接使用命令启动测量的血压计设备接口
 * connectDevice:(LSDeviceInfo *)lsDevice connectDelegate:(id<LSDeviceConnectDelegate>)connectDelegate;
 * 新增用于启动血压计开始测量的接口 startMeasuring;
 * 新增根据指定的设备类型、设备名称设置配对时采用固定的广播ID接口
 */

//version 1.0.9
/*
 *  修改通过命令启动测量的血压计数据传输协议流程，修改该设备所用的UUID为0x78E9,
 *  该设备不需要通过配对
 *
 */

//version 1.1.0
/*
 * 修复A2协议手环设置用户信息（如身高、体重、星期开始时间、周目标等）失败的问题
 */

//version 2.0.0
/*
 * 版本V2.0.0,使用了新的蓝牙模块结构，对内部的代码结构进行了优化，简化了多余的操作处理,在LSBleDeviceManager中添加用于标识当前API的版本号versionName;
 */

//version 2.0.1
/*
 * 版本V2.0.1,修复了A3协议设备上传设备用户列表时,在解析设备用户名称时保留了空格,同时修改用户名称的长度为16个字符,在厨房秤测量数据中添加设备名称、设备ID属性;
 */


//version 3.0.0
/*
 * 版本V3.0.0删除对A4协议设备的支持，删除Google protocol buffer;
 */

//version 3.0.1

/*
 * 修复A3.1协议设备model number解析错误的问题，修复framework在ios9无法正常工作的问题。
 */

@end
