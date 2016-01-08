//
//  BleDevice+Handler.h
//  LSBluetooth-Demo
//
//  Created by lifesense on 15/8/20.
//  Copyright (c) 2015年 Lifesense. All rights reserved.
//

#import "BleDevice.h"
#import <LifesenseBluetooth/LSDeviceInfo.h>


@interface BleDevice (Handler)

+(BleDevice *)bindDeviceWithUserId:(NSString *)userId
                        deviceInfo:(LSDeviceInfo *)lsDeviceInfo
            inManagedObjectContext:(NSManagedObjectContext *)context;

+(void)deleteBleDevice:(BleDevice *)delDevice inManagedObjectContext:(NSManagedObjectContext *)context;
@end
