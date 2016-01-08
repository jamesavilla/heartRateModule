//
//  LSHeightData.h
//  LifesenseBle
//
//  Created by lifesense on 14-8-1.
//  Copyright (c) 2014年 lifesense. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LSHeightData : NSObject
@property(nonatomic,strong)NSString *date;
@property(nonatomic,strong)NSString *deviceId;
@property(nonatomic,strong)NSString *memberId;
@property(nonatomic,strong)NSString *deviceSn;
@property(nonatomic)NSInteger userNo;
@property(nonatomic)double height;
@property(nonatomic,strong)NSString *unit;
@property(nonatomic)NSInteger battery;
@property(nonatomic,strong)NSString *broadcastId;//new change for version2.0.1
@end
