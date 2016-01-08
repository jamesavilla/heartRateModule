//
//  LSWeightAppendData.h
//  LsBluetooth-Test
//
//  Created by lifesense on 14-8-9.
//  Copyright (c) 2014年 com.lifesense.ble. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LSWeightAppendData : NSObject
@property(nonatomic,strong)NSString *deviceId;
@property(nonatomic, assign) uint32_t utc;
@property(nonatomic, assign) uint8_t userId;
@property(nonatomic, assign) float basalMetabolism;
@property(nonatomic, assign) float bodyFatRatio;
@property(nonatomic, assign) float bodywaterRatio;
@property(nonatomic, assign) float visceralFatLevel;
@property(nonatomic, assign) float muscleMassRatio;
@property(nonatomic, assign) float boneDensity;
@property(nonatomic, assign) int battery;
@property(nonatomic, assign) double voltageData;
@property(nonatomic, strong)NSString *measuredTime;
@end
