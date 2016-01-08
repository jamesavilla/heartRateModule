//
//  DeviceAlarmClock+Handler.h
//  LSBluetooth-Demo
//
//  Created by lifesense on 15/8/25.
//  Copyright (c) 2015年 Lifesense. All rights reserved.
//

#import "DeviceAlarmClock.h"

#define KEY_ALARM_CLOCK_ID          @"alarmClockId"
#define KEY_ALARM_CLOCK_MONDAY      @"monday"
#define KEY_ALARM_CLOCK_TUESDAY     @"tuesday"
#define KEY_ALARM_CLOCK_WEDNESDAY   @"wednesday"
#define KEY_ALARM_CLOCK_THURSDAY    @"thursday"
#define KEY_ALARM_CLOCK_FRIDAY      @"friday"
#define KEY_ALARM_CLOCK_SATURDAY    @"saturday"
#define KEY_ALARM_CLOCK_SUNDAY      @"sunday"
#define KEY_ALARM_CLOCK_TIME        @"alarmClockTime"
#define KEY_ALARM_CLOCK_DAY         @"alarmClockDay"

@interface DeviceAlarmClock (Handler)

+(DeviceAlarmClock *)createAlarmClockWithInfo:(NSDictionary *)alarmClockInfo
                           inManagedObjectContext:(NSManagedObjectContext *)context;
@end
