//
//  LSWeightData.h
//  LifesenseBle
//
//  Created by lifesense on 14-8-1.
//  Copyright (c) 2014年 lifesense. All rights reserved.
//

/*the struct value  used when you want translate the kg value to ST value*/
typedef struct
{
    int int_st;  //the integer part with unit LB
    int mod_st;  //the mod part with unit ST
}STValue;

#import <Foundation/Foundation.h>



@interface LSWeightData : NSObject
@property(nonatomic,strong)NSString *date;
@property(nonatomic,strong)NSString *deviceId;
@property(nonatomic)NSInteger userNo;
@property(nonatomic)double weight; /* this value in kg unit*/
@property(nonatomic)double pbf;
@property(nonatomic)double resistance_1;
@property(nonatomic)double resistance_2;
@property(nonatomic)int hasAppendMeasurement;
@property(nonatomic,strong)NSString *deviceSelectedUnit;
@property(nonatomic, assign) double voltageValue;
@property(nonatomic, assign) int batteryValue;
//new change for version2.0.0
@property(nonatomic)double lbWeightValue;
@property(nonatomic)double stWeightValue;
@property(nonatomic)NSUInteger stSectionValue;

@property(nonatomic,strong)NSString *broadcastId;//new change for version2.0.1

@end
