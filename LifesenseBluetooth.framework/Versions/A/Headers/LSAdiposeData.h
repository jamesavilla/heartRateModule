//
//  LSAdiposeData.h
//  LsBluetooth-Test
//
//  Created by lifesense on 14-9-19.
//  Copyright (c) 2014年 com.lifesense.ble. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LSAdiposeData : NSObject
@property(nonatomic, assign) double basalMetabolism;
@property(nonatomic, assign) double bodyFatRatio;
@property(nonatomic, assign) double bodywaterRatio;
@property(nonatomic, assign) double visceralFatLevel;
@property(nonatomic, assign) double muscleMassRatio;
@property(nonatomic, assign) double boneDensity;

-(NSString *)description;
@end
