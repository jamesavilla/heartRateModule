//
//  PedometerUserInfo.h
//  BleTest
//
//  Created by panweichao on 13-7-5.
//  Copyright (c) 2013年 panweichao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PedometerUserInfo : NSObject

@end

@interface PedometerUserDownLoadInfo : NSObject<NSCoding>{
    
}
@property(nonatomic, assign)float stride;
@property(nonatomic, assign)float height;
@property(nonatomic, assign)float weight;
@property(nonatomic, assign)NSInteger weekStart;
@property(nonatomic, assign)NSInteger weekTargetSteps;
@property(nonatomic, assign)float weekTargetCalories;
@property(nonatomic, assign)NSInteger weekTargetDistance;
@property(nonatomic, assign)float weekTargetExerciseAmount;
@end

