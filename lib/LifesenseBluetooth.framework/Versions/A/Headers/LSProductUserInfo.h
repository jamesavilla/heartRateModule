//
//  LSProductUserInfo.h
//  LsBluetooth-Test
//
//  Created by lifesense on 14-8-12.
//  Copyright (c) 2014年 com.lifesense.ble. All rights reserved.
//

//性别类型，1表示男，2表示女
typedef enum {
    SEX_MALE=1,
    SEX_FEMALE=2,
}UserSexType;

//测量单位
typedef enum {
    UNIT_KG=0,
    UNIT_LB=1,
    UNIT_ST=2,
}MeasurementUnitType;

#import <Foundation/Foundation.h>

@interface LSProductUserInfo : NSObject

@property(nonatomic, strong)NSString *deviceId;       //设备ID
@property(nonatomic,strong)NSString *memberId; //用户ID；
@property(nonatomic)NSUInteger userNumber;    //用户编号
@property(nonatomic)MeasurementUnitType unit;        //测量单位
@property(nonatomic)UserSexType sex;                  //用户性别
@property(nonatomic)NSUInteger age;           //用户年龄
@property(nonatomic)NSUInteger athleteLevel;  //运动员级别，0表示非运动员，1-5表示运动员
@property(nonatomic)float height;             //身高
@property(nonatomic)float goalWeight;          //目标体重
@property(nonatomic)float waistline;           //腰围


-(NSData *)userInfoCommandData;



@end
