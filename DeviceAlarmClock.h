//
//  DeviceAlarmClock.h
//  LSBluetooth-Demo
//
//  Created by lifesense on 15/8/26.
//  Copyright (c) 2015年 Lifesense. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class DeviceUserProfiles;

@interface DeviceAlarmClock : NSManagedObject

@property (nonatomic, retain) NSNumber * alarmClockDay;
@property (nonatomic, retain) NSString * alarmClockId;
@property (nonatomic, retain) NSDate * alarmClockTime;
@property (nonatomic, retain) NSNumber * friday;
@property (nonatomic, retain) NSNumber * monday;
@property (nonatomic, retain) NSNumber * saturday;
@property (nonatomic, retain) NSNumber * sunday;
@property (nonatomic, retain) NSNumber * thursday;
@property (nonatomic, retain) NSNumber * tuesday;
@property (nonatomic, retain) NSNumber * wednesday;
@property (nonatomic, retain) DeviceUserProfiles *deviceUser;

@end
