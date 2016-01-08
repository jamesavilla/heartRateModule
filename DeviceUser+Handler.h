//
//  DeviceUser+Handler.h
//  LSBluetooth-Demo
//
//  Created by lifesense on 15/8/20.
//  Copyright (c) 2015年 Lifesense. All rights reserved.
//

#import "DeviceUser.h"

#define DEVICE_USER_KEY_ID              @"userId"
#define DEVICE_USER_KEY_NAME            @"userName"
#define DEVICE_USER_KEY_GENDER          @"userGender"
#define DEVICE_USER_KEY_BIRTHDAY        @"birthday"
#define DEVICE_USER_KEY_HEIGHT          @"height"
#define DEVICE_USER_KEY_WEIGHT          @"weight"
#define DEVICE_USER_KEY_ATHLETELEVEL    @"athleteLevel"


@interface DeviceUser (Handler)

+(DeviceUser *)createDeviceUserWithUserInfo:(NSDictionary *)userInfo
             inManagedObjectContext:(NSManagedObjectContext *)context;


+(DeviceUser *)bindDeviceUserWithUserID:(NSString *)userId
                 inManagedObjectContext:(NSManagedObjectContext *)context;

@end
