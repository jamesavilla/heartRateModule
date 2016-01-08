//
//  LSPedometerUserInfo.h
//  LifesenseBle
//
//  Created by lifesense on 14-8-1.
//  Copyright (c) 2014年 lifesense. All rights reserved.
//

typedef enum
{
    EXERCISE_DAY_TARGET = 0x01,
    EXERCISE_WEEK_TARGET =0x02,
    
}EXERCISE_TARGET_TYPE;

//A2手环显示时间的小时制
typedef enum {
    HOUR_12=1,
    HOUR_24=2,
}HOUR_SYSTEM;

//A2手环运动距离长度的计算单位
typedef enum {
    LENGTH_UNIT_KILOMETER=1,
    LENGTH_UNIT_MILE=2,
}LENGTH_UNIT;



#import <Foundation/Foundation.h>
#import "LSProductUserInfo.h"

@interface LSPedometerUserInfo : NSObject

@property(nonatomic,strong)NSString *deviceId;
@property(nonatomic,strong)NSString *memberId; //用户ID；

@property(nonatomic)NSInteger userNo; //productUserNumber
@property(nonatomic)double weight;
@property(nonatomic)double height;
@property(nonatomic)double stride;
@property(nonatomic)EXERCISE_TARGET_TYPE targetType;
@property(nonatomic)NSInteger targetStep;
@property(nonatomic)double targetCalories;
@property(nonatomic)double targetDistance;
@property(nonatomic)double targetExerciseAmount;
@property(nonatomic,strong)NSString *weightUnit;
@property(nonatomic)HOUR_SYSTEM hourSystem;
@property(nonatomic)LENGTH_UNIT lengthUnit;

/*
 * Version1.1.0 new change, add age userGender athleteActivityLevel isAthlete
 */
@property(nonatomic,assign)NSInteger age;
@property(nonatomic)UserSexType userGender;
@property(nonatomic,assign)NSInteger athleteActivityLevel;
@property(nonatomic)BOOL isAthlete;
@property(nonatomic,assign)NSInteger weekStart;//1 for Sunday,2 for Monday


-(NSData *)currentStateCommandData;

//new change for version1.1.0

-(NSData*)userMessageCommandData;

-(NSData*)weekTargetCommandData;

-(BOOL)isUserMessageSetting;

-(BOOL)isWeekStartSetting;

-(BOOL)isCurrentStateSetting;

-(NSData*)unitConversionCommandData;

-(BOOL)isUnitConversionSetting;

@end
