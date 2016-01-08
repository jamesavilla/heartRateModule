//
//  LSPedometerAlarmClock.h
//  LsBluetooth-Test
//
//  Created by lifesense on 14-8-15.
//  Copyright (c) 2014年 com.lifesense.ble. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum{
    SUNDAY=0X40,
    MONDAY=0X01,
    TUESDAY=0X02,
    WEANSDAY=0X04,
    THURSDAY=0X08,
    FRIDAY=0X10,
    SATADAY=0X20,
}CLOCK_DAY;

@interface LSPedometerAlarmClock : NSObject

@property(nonatomic,strong)NSString *deviceId;
@property(nonatomic,strong)NSString *memberId;
@property(nonatomic,assign)int8_t command;
@property(nonatomic,assign)int8_t flag;
@property(nonatomic,assign)int8_t switch1;
@property(nonatomic,assign)int8_t day1;
@property(nonatomic,assign)int8_t hour1;
@property(nonatomic,assign)int8_t minute1;
@property(nonatomic,assign)int8_t switch2;
@property(nonatomic,assign)int8_t day2;
@property(nonatomic,assign)int8_t hour2;
@property(nonatomic,assign)int8_t minute2;
@property(nonatomic,assign)int8_t switch3;
@property(nonatomic,assign)int8_t day3;
@property(nonatomic,assign)int8_t hour3;
@property(nonatomic,assign)int8_t minute3;
@property(nonatomic,assign)int8_t switch4;
@property(nonatomic,assign)int8_t day4;
@property(nonatomic,assign)int8_t hour4;
@property(nonatomic,assign)int8_t minute4;
-(NSData*)getData;
@end
