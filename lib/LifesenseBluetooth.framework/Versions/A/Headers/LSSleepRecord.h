//
//  SleepRecord.h
//  lifesensehealth1_1
//
//  Created by chris on 14/12/2.
//  Copyright (c) 2014年 lifesense. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface LSSleepRecord : NSObject


@property (nonatomic, retain) NSString * accountId;
@property (nonatomic, retain) NSString * memberId;
@property (nonatomic, retain) NSString * deviceId;
@property (nonatomic, retain) NSString * measurementDate;
@property (nonatomic, retain) NSNumber * utc;
@property (nonatomic, retain) NSNumber * sleepLevel;
@property (nonatomic, retain) NSString * remark;
@property(nonatomic,strong)NSString *broadcastId;//new change for version2.0.1


@end
