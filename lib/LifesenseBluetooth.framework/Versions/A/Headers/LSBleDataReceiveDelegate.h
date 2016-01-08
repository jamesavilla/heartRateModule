//
//  LSBleDataReceiveDelegate.h
//  LsBluetooth-Test
//
//  Created by lifesense on 14-8-12.
//  Copyright (c) 2014年 com.lifesense.ble. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BleManagerProfiles.h"

//连接状态
typedef enum{
    CONNECTED_SUCCESS=1,
    CONNECTED_FAILED=2,
    DISCONNECTED=3
} DeviceConnectState;

//A4设备上传的命令请求编码
typedef enum{
    
    COMMAND_REQUEST_C7=199,
    COMMAND_REQUEST_C9=201,
    COMMAND_REQUEST_CA=202,
    COMMAND_REQUEST_CE=206,
    
}CommandRequestCode;

@protocol LSBleDataReceiveDelegate <NSObject>

@optional

//接收体重测量数据
-(void)bleManagerDidReceiveWeightMeasuredData:(LSWeightData*)data;

//接收计步器测量数据
-(void)bleManagerDidReceivePedometerMeasuredData:(LSPedometerData*)data;

//接收血压计测量数据
-(void)bleManagerDidReceiveSphygmometerMeasuredData:(LSSphygmometerData *)data;

//接收身高测量数据
-(void)bleManagerDidReceiveHeightMeasuredData:(LSHeightData*)data;

//接收脂肪秤测量数据
-(void)bleManagerDidReceiveWeightAppendMeasuredData:(LSWeightAppendData*)data;

//接收产品用户信息
-(void)bleManagerDidReceiveProductUserInfo:(LSProductUserInfo *)userInfo;

//接收产品用户信息写成功回调
-(void)bleManagerDidWriteSuccessForProductUserInfo:(NSString *)deviceId memberId:(NSString *)memberId;

//接收计步器用户信息写成功回调
-(void)bleManagerDidWriteSuccessForPedometerUserInfo:(NSString *)deviceId memberId:(NSString *)memberId;

//接收计步器闹钟设置成功回调
-(void)bleManagerDidWriteSuccessForAlarmClock:(NSString *)deviceId memberId:(NSString *)memberId;

/*
 *新增加接口部分，支持厨房秤
 */

//接收设备的详细信息
-(void)bleManagerDidDiscoveredDeviceInfo:(LSDeviceInfo *)deviceInfo;

//接收厨房秤的测量数据
-(void)bleManagerDidReceiveKitchenScaleMeasuredData:(LSKitchenScaleData *)kitchenData;

//连接状态改变
-(void)bleManagerDidConnectStateChange:(DeviceConnectState)connectState deviceName:(NSString *)deviceName;


//接收Ａ4设备的运动测量数据
-(void)bleManagerDidReceivePedometerMeasuredDataForA4:(NSArray *)dataList commandCode:(CommandRequestCode)code;

//接收Ａ4设备的睡眠测量数据
-(void)bleManagerDidReceivePedometerSleepInfoForA4:(NSArray *)sleepInfoList;

@end
