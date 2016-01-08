//
//  DeviceUserProfiles+Handler.h
//  LSBluetooth-Demo
//
//  Created by lifesense on 15/8/20.
//  Copyright (c) 2015年 Lifesense. All rights reserved.
//

#import "DeviceUserProfiles.h"


#define KEY_USER_PROFILES_ID                        @"userId"
#define KEY_USER_PROFILES_ALARM_CLOCK_ID            @"alarmClockId"
#define KEY_USER_PROFILES_SCAN_FILTER_ID            @"scanFilterId"
#define KEY_USER_PROFILES_DISTANCE_UNIT             @"distanceUnit"
#define KEY_USER_PROFILES_HOUR_FORMAT               @"hourFormat"
#define KEY_USER_PROFILES_WEEK_START                @"weekStart"
#define KEY_USER_PROFILES_WEEK_TARGET_STEPS         @"weekTargetSteps"
#define KEY_USER_PROFILES_WEIGHT_TARGET             @"weightTarget"
#define KEY_USER_PROFILES_WEIGHT_UNIT               @"weightUnit"



@interface DeviceUserProfiles (Handler)



+(DeviceUserProfiles *)createUserProfilesWithInfo:(NSDictionary *)profilesInfo
                          inManagedObjectContext:(NSManagedObjectContext *)context;

+(DeviceUserProfiles *)bindUserProfilesWithAlarmClockID:(NSString *)alarmClockId
                 inManagedObjectContext:(NSManagedObjectContext *)context;

+(DeviceUserProfiles *)bindUserProfilesWithScanFilterId:(NSString *)scanFilterId
                                 inManagedObjectContext:(NSManagedObjectContext *)context;
@end
