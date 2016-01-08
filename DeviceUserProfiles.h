//
//  DeviceUserProfiles.h
//  LSBluetooth-Demo
//
//  Created by lifesense on 15/8/26.
//  Copyright (c) 2015年 Lifesense. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class DeviceAlarmClock, DeviceUser, ScanFilter;

@interface DeviceUserProfiles : NSManagedObject

@property (nonatomic, retain) NSString * alarmClockId;
@property (nonatomic, retain) NSString * distanceUnit;
@property (nonatomic, retain) NSString * hourFormat;
@property (nonatomic, retain) NSString * userId;
@property (nonatomic, retain) NSString * weekStart;
@property (nonatomic, retain) NSNumber * weekTargetSteps;
@property (nonatomic, retain) NSNumber * weightTarget;
@property (nonatomic, retain) NSString * weightUnit;
@property (nonatomic, retain) NSString * scanFilterId;
@property (nonatomic, retain) DeviceAlarmClock *deviceAlarmClock;
@property (nonatomic, retain) DeviceUser *whoSet;
@property (nonatomic, retain) ScanFilter *hasScanFilter;

@end
