//
//  DataFormatConverter.h
//  LSBluetooth-Demo
//
//  Created by lifesense on 15/8/20.
//  Copyright (c) 2015年 Lifesense. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <LifesenseBluetooth/LSBLEDeviceManager.h>
#import "BleDevice.h"
#import <UIKit/UIKit.h>
#import <LifesenseBluetooth/LSPedometerAlarmClock.h>
#import "DeviceAlarmClock.h"
#import "DeviceUser.h"
#import "DeviceUserProfiles.h"


@interface DataFormatConverter : NSObject

+(LSDeviceType)stringToDeviceType:(id)type;

+(LSDeviceInfo *)convertedToLSDeviceInfo:(BleDevice *)bleDevice;

+(NSString *)doubleValueWithOneDecimalFormat:(double)weightValue;

+(NSString *)doubleValueWithTwoDecimalFormat:(double)weightValue;

+(UIImage *)getDeviceImageViewWithType:(LSDeviceType)deviceType;

+(NSString *)getDeviceNameForNormalBroadcasting:(NSString *)deviceName;

+(BOOL)isNotRequiredPairDevice:(NSString *)protocol;

+(NSDictionary *)parseObjectDetailInDictionary:(id)obj;

+(NSString *)parseObjectDetailInStringValue:(id)obj;

+(NSAttributedString *)parseObjectDetailInAttributedString:(id)obj recordNumber:(NSUInteger)number;

+(int)getAlarmClockDayCount:(DeviceAlarmClock *)deviceAlarmClock;

+(LSPedometerAlarmClock *)getPedometerAlarmClock:(DeviceAlarmClock *)deviceAlarmClock;

+(LSPedometerUserInfo *)getPedometerUserInfo:(DeviceUser *)deviceUser;

+(LSProductUserInfo *)getProductUserInfo:(DeviceUser *)deviceUser;

@end
