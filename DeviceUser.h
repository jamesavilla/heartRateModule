//
//  DeviceUser.h
//  LSBluetooth-Demo
//
//  Created by lifesense on 15/8/26.
//  Copyright (c) 2015年 Lifesense. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class BleDevice, DeviceUserProfiles;

@interface DeviceUser : NSManagedObject

@property (nonatomic, retain) NSNumber * athleteLevel;
@property (nonatomic, retain) NSDate * birthday;
@property (nonatomic, retain) NSString * gender;
@property (nonatomic, retain) NSNumber * height;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * userID;
@property (nonatomic, retain) NSNumber * weight;
@property (nonatomic, retain) NSSet *devices;
@property (nonatomic, retain) DeviceUserProfiles *userprofiles;
@end

@interface DeviceUser (CoreDataGeneratedAccessors)

- (void)addDevicesObject:(BleDevice *)value;
- (void)removeDevicesObject:(BleDevice *)value;
- (void)addDevices:(NSSet *)values;
- (void)removeDevices:(NSSet *)values;

@end
