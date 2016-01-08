//
//  LSKitchenScaleData.h
//  LifesenseBle
//
//  Created by lifesense on 14-8-1.
//  Copyright (c) 2014年 lifesense. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LSKitchenScaleData : NSObject
@property(nonatomic)double weight;
@property(nonatomic)NSInteger sectionWeight;
@property(nonatomic)NSInteger time;
@property(nonatomic, strong)NSString *unit;
@property(nonatomic)NSInteger battery;
@property(nonatomic,strong)NSString *deviceName;
@property(nonatomic,strong)NSString *deviceId;
@end
