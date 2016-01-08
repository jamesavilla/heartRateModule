//
//  LSPersonalUserInfo.h
//  LsBluetooth-Test
//
//  Created by lifesense on 14-9-18.
//  Copyright (c) 2014年 com.lifesense.ble. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BleCommonProperties.h"

@interface LSPersonalInfo : NSObject

@property(nonatomic,assign)double height_m;
@property(nonatomic,assign)double weight_kg;
@property(nonatomic,assign)int  age;
@property(nonatomic)UserSex sex;


@end
