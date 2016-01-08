//
//  LSBLEDeviceManager.h
//  LifesenseBle
//
//  Created by lifesense on 14-8-1.
//  Copyright (c) 2014年 lifesense. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "BleManagerProfiles.h"
#import "NSMutableArray+QueueAdditions.h"


@interface LSBLEDeviceManager : NSObject
@property(nonatomic)BOOL isBluetoothPowerOn;
@property(nonatomic,strong,readonly)NSString *versionName;

//获取实例对象
+(instancetype)defaultLsBleManager;

//蓝牙状态检测
-(void)checkBluetoothStatus:(void(^)(BOOL isSupportFlags,BOOL isOpenFlags))checkCompletion;

//根据指定条件搜索乐心设备
-(BOOL)searchLsBleDevice:(NSArray *)deviceTypes ofBroadcastType:(BroadcastType)broadcastType searchCompletion:(void(^)(LSDeviceInfo* lsDevice))searchCompletion;

//停止搜索
-(BOOL)stopSearch;

//与设备进行配对
-(BOOL)pairWithLsDeviceInfo:(LSDeviceInfo *)lsDevice pairedDelegate:(id<LSBlePairingDelegate>)pairedDelegate;

//启动测量数据接收服务
-(BOOL)startDataReceiveService:(id<LSBleDataReceiveDelegate>)dataDelegate;

//停止测量数据接收服务
-(BOOL)stopDataReceiveService;

//绑定设备用户编号
-(BOOL)bindingDeviceUsers:(NSUInteger)userNumber userName:(NSString *)name;

//设置测量设备列表
-(void)setMeasureDeviceList:(NSArray *)deviceList;

//添加单个测量设备
-(BOOL)addMeasureDevice:(LSDeviceInfo *)lsDevice;

//根据广播ID删除单个测量设备
-(BOOL)deleteMeasureDevice:(NSString *)broadcastId;

//设置产品的用户信息，对于A3协议的脂肪秤
-(BOOL)setProductUserInfo:(LSProductUserInfo *)userInfo;

//设置计步器的用户信息
-(BOOL)setPedometerUserInfo:(LSPedometerUserInfo *)pedometerUserInfo;

//设置计步器的闹钟信息
-(BOOL)setPedometerAlarmClock:(LSPedometerAlarmClock *)alarmClock;

//set up enable scan device by broadcast name
-(BOOL)setEnableScanBrocastName:(NSArray*)enableDevices;

//new interface for bodyfat parse
-(LSWeightAppendData *)parseAdiposeDataWithResistance:(double)resistance_2 userHeight:(double)height_m userWeight:(double)weight_kg userAge:(int)age userSex:(UserSexType)sex;

//新增加接口，设置A2设备的声音振动提示功能
-(BOOL)setVibrationVoice:(LSVibrationVoice *)vibrationVoice;

//版本1.0.8新增接口，启动血压计开始测量
-(BOOL)startMeasuring;

//版本1.0.8新增接口，连接通过命令启动测量的血压计设备
-(BOOL)connectDevice:(LSDeviceInfo *)pairedDevice connectDelegate:(id<LSDeviceConnectDelegate>)connectDelegate;

//版本1.0.8新增接口，根据指定的设备类型、设备名称设置配对时采用固定的广播ID接口
-(BOOL) setCustomBroadcastID:(NSString *)customBroadcastID deviceName:(NSString *)deviceName deviceType:(NSArray*)deviceTypes;

-(void) setDispatchQueue:(dispatch_queue_t)dispatchQueue;

//版本V2.0.0新增接口，设置是否允许输出log调试信息
-(void) setDebugModeWithPermissions:(NSString *)key;
@end
