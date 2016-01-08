//
//  LSSphygmometerData.h
//  LifesenseBle
//
//  Created by lifesense on 14-8-1.
//  Copyright (c) 2014年 lifesense. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LSSphygmometerData : NSObject
@property(nonatomic,strong)NSString *date;
@property(nonatomic,strong)NSString *deviceId;
@property(nonatomic)NSInteger userNo;
@property(nonatomic)double systolic;
@property(nonatomic)double diastolic;
@property(nonatomic)double pluseRate;
@property(nonatomic)BOOL isIrregularPulse;
@property(nonatomic,strong)NSString *deviceSelectedUnit;/*this is the device selected unit when
                                                         measure */
@property(nonatomic)NSInteger battery;
@property(nonatomic,strong)NSString *broadcastId;//new change for version2.0.1

/*method can be used to translate the value from an value to another value in deferent unit*/
//+(NSInteger)calculateKPAVauleWithMMHGValue:(double)mmHg;
@end
