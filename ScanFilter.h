//
//  ScanFilter.h
//  LSBluetooth-Demo
//
//  Created by lifesense on 15/8/26.
//  Copyright (c) 2015年 Lifesense. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class DeviceUserProfiles;

@interface ScanFilter : NSManagedObject

@property (nonatomic, retain) NSString * filterId;
@property (nonatomic, retain) NSString * broadcastType;
@property (nonatomic, retain) NSNumber * enableFatScale;
@property (nonatomic, retain) NSNumber * enablePedometer;
@property (nonatomic, retain) NSNumber * enableWeightScale;
@property (nonatomic, retain) NSNumber * enableHeightMeter;
@property (nonatomic, retain) NSNumber * enableKitchenScale;
@property (nonatomic, retain) NSNumber * enableBloodPressure;
@property (nonatomic, retain) DeviceUserProfiles *deviceUser;

@end
