//
//  LSPedometerData.h
//  LifesenseBle
//
//  Created by lifesense on 14-8-1.
//  Copyright (c) 2014年 lifesense. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LSPedometerData : NSObject
@property(nonatomic,strong)NSString *date;
@property(nonatomic,strong)NSString *deviceId;
@property(nonatomic)NSInteger userNo;
@property(nonatomic)NSInteger walkSteps;
@property(nonatomic)NSInteger runSteps;
@property(nonatomic)double examount;
@property(nonatomic)double calories;                /*the unit is kilogram calories*/
@property(nonatomic)NSInteger exerciseTime;   /*the unit is minute */
@property(nonatomic)NSInteger distance;       /*the unit is meter*/
@property(nonatomic)NSInteger battery;
@property(nonatomic)NSInteger sleepStatus;
@property(nonatomic)NSInteger intensityLevel;
@property(nonatomic)NSInteger voltage;
@property(nonatomic,strong)NSString *broadcastId;//new change for version2.0.1
@end
