//
//  BleDevice.h
//  LSBluetooth-Demo
//
//  Created by lifesense on 15/8/26.
//  Copyright (c) 2015年 Lifesense. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class DeviceUser;

@interface BleDevice : NSManagedObject

@property (nonatomic, retain) NSString * broadcastID;
@property (nonatomic, retain) NSString * deviceID;
@property (nonatomic, retain) NSString * deviceName;
@property (nonatomic, retain) NSString * deviceSN;
@property (nonatomic, retain) NSString * deviceType;
@property (nonatomic, retain) NSNumber * deviceUserNumber;
@property (nonatomic, retain) NSString * firmwareVersion;
@property (nonatomic, retain) NSString * hardwareVersion;
@property (nonatomic, retain) NSString * identifier;
@property (nonatomic, retain) NSString * modelNumber;
@property (nonatomic, retain) NSString * password;
@property (nonatomic, retain) NSString * protocolType;
@property (nonatomic, retain) NSString * softwareVersion;
@property (nonatomic, retain) NSString * userId;
@property (nonatomic, retain) DeviceUser *whoBind;

@end
