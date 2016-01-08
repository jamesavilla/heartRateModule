//
//  LSVibrationVoice.h
//  LSBluetooth-Library
//
//  Created by chixiang.cai on 14-11-17.
//  Copyright (c) 2014年 Lifesense. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LSVibrationVoice : NSObject

@property(strong,nonatomic)NSString* deviceId;  //设备ID
@property(nonatomic)int productUserNumber;      //产品用户编号
@property(nonatomic)int vibrationIntensity;     //振动强度等级
@property(nonatomic)int vibrationTimes;         //振动次数
@property(nonatomic)float continuousVibrationTime;//连续振动时间
@property(nonatomic)float pauseVibrationTime;     //暂停振动时间
@property(nonatomic)int soundSelect;            //声音选择
@property(nonatomic)int soundTimes;             //响声次数
@property(nonatomic)int volumeSetting;          //音量设置
@property(nonatomic)float continuousSoundTime;    //连续的响声时间
@property(nonatomic)float pauseSoundTime;         //暂停响声时间
@property(nonatomic)BOOL isEnableVibration;     //是否振动
@property(nonatomic)BOOL isEnableSound;         //是否发出声音，响

-(NSData*)getCommandDataBytes;                  //获取振动声音对象的bytes,用于写到设备

@end
