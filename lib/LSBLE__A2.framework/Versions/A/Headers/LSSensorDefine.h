//
//  LSSensorDefine.h
//  Collector_A2_Demo
//
//  Created by apple on 12-11-29.
//  Copyright (c) 2012年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum
{ 
    LS_SENSOR_TYPE_UNKONW=0x00,
    LS_SENSOR_TYPE_WEIGHT_SCALE=0x01,
    LS_SENSOR_TYPE_PEDOMETER = 0x04,
    LS_SENSOR_TYPE_BLOODPRESSURE =0x05,
    LS_SENSOR_TYPE_KITCHEN_SCALE = 0x06,
    LS_SENSOR_TYPE_HEIGHT = 0x07,
    LS_SENSOR_TYPE_GENERAL_WEIGHT_SCALE = 0x08
           }LS_SENSOR_TYPE;


typedef enum
{
    LS_DOWNLOAD_TYPE_UNKONW = 0x00,
    LS_DOWNLOAD_TYPE_SENSORINFO = 0x01,
    LS_DOWNLOAD_TYPE_EXERCISE_DAY_TARGET = 0x02,
    LS_DOWNLOAD_TYPE_EXERCISE_WEEK_TARGET = 0x04,
    LS_DOWNLOAD_TYPE_CURRENT_STATE = 0x08,
    LS_DOWNLOAD_TYPE_TARGET_STATE = 0x10,
    LS_DOWNLOAD_TYPE_USER_MESSAGE = 0x20
    
}LS_DOWNLOAD_INFO_TYPE;

typedef enum
{
    EXERCISE_DAY_TARGET = 0x01,
    EXERCISE_WEEK_TARGET,
    
}EXERCISE_TARGET_TYPE;


/*the struct value  used when you want translate the kg value to ST value*/
typedef struct
{
    int int_st;  //the integer part with unit LB
    int mod_st;  //the mod part with unit ST
}STValue;


@interface SensorDownloadInfo : NSObject


@property(nonatomic,retain)NSString *sensorName;
@end

@interface ExerciseTargetDownloadInfo : NSObject


@property(nonatomic,assign)NSInteger userNo;
@property(nonatomic,assign)EXERCISE_TARGET_TYPE targetType;
@property(nonatomic,assign)NSInteger targetStep;
@property(nonatomic,assign)double targetCalories;
@property(nonatomic,assign)double targetDistance;
@property(nonatomic,assign)double targetExerciseAmount;
@end

@interface CurrentStateDownloadInfo : NSObject


@property(nonatomic,assign)NSInteger userNo;
@property(nonatomic,assign)double weight;
@property(nonatomic,assign)double fatRatio;
@property(nonatomic,assign)double height;
@property(nonatomic,assign)double waistline;
@property(nonatomic,assign)double stride;
@property(nonatomic,assign)NSInteger age;
@end

@interface TargetStateDownloadInfo : NSObject

@property(nonatomic,assign)NSInteger userNo;
@property(nonatomic,assign)double targetWeight;
@property(nonatomic,assign)double targetHeight;
@property(nonatomic,retain)NSString *targetDate;
@end

@interface UserMessageDownloadInfo : NSObject

@property(nonatomic,assign)NSInteger userNo;
@property(nonatomic,assign)NSInteger userId;
@property(nonatomic,retain)NSString *userName;
@property(nonatomic,assign)NSInteger sex;
@property(nonatomic,assign)NSInteger activityLevel;
@property(nonatomic,assign)NSInteger birthdayYear;
@property(nonatomic,assign)NSInteger birthdayMonth;
@property(nonatomic,assign)NSInteger birthdayDay;
@property(nonatomic,assign)NSInteger weekStart;
@end

@interface LSHardwareSensor : NSObject




@property(nonatomic,retain)NSString *deviceId;
@property(nonatomic,retain)NSString *deviceSn;
@property(nonatomic,assign)BOOL preparePair;
@property(nonatomic,assign)LS_SENSOR_TYPE sensorType;
@property(nonatomic,retain)NSString *modelNumber;
@property(nonatomic,retain)NSString *sensorName;
@property(nonatomic,assign)NSUInteger pairSignature;
@property(nonatomic,assign)NSUInteger password;
@property(nonatomic,assign)NSUInteger supportDownloadInfoFeature;
@property(nonatomic,assign)NSInteger maxUserQuantity;
@property(nonatomic,retain)NSString *softwareVersion;
@property(nonatomic,retain)NSString *hardwareVersion;
@property(nonatomic,retain)NSString *firmwareVersion;
@property(nonatomic,retain)NSString *manufactureName;
@property(nonatomic,retain)NSString *systemId;
@property(nonatomic, retain)NSString *iphoneRandomNum;

@end

@interface WeightData : NSObject {
    
}

@property(nonatomic,retain)NSString *date;
@property(nonatomic,retain)NSString *deviceId;
@property(nonatomic)NSInteger userNo;
@property(nonatomic)double weight; /* this value in kg unit*/
@property(nonatomic)double pbf;
@property(nonatomic)double resistance_1;
@property(nonatomic)double resistance_2;
@property(nonatomic,retain)NSString *deviceSelectedUnit;/*this is the device selected unit when
                                                        measure */
/*method can be used to translate the value from an value to another value in deferent unit*/
+(NSInteger)calculateLBValueWithKGValue:(double)kg;
+(STValue)calculateSTValueWithKGValue:(double)kg;
@end


@interface BloodPressureData : NSObject {
    
}
@property(nonatomic,retain)NSString *date;
@property(nonatomic,retain)NSString *deviceId;
@property(nonatomic)NSInteger userNo;
@property(nonatomic,assign)double systolic;
@property(nonatomic,assign)double diastolic;
@property(nonatomic,assign)double pluseRate;
@property(nonatomic,assign)BOOL isIrregularPulse;
@property(nonatomic,retain)NSString *deviceSelectedUnit;/*this is the device selected unit when
                                                         measure */
@property(nonatomic,assign)NSInteger battery;

/*method can be used to translate the value from an value to another value in deferent unit*/
+(NSInteger)calculateKPAVauleWithMMHGValue:(double)mmHg;
@end

@interface HeightData : NSObject {
    
}
@property(nonatomic,retain)NSString *date;
@property(nonatomic,retain)NSString *deviceId;
@property(nonatomic,retain)NSString *memberId;
@property(nonatomic,assign)NSInteger userNo;
@property(nonatomic)double height;
@property(nonatomic,retain)NSString *unit;
@property(nonatomic, assign)NSInteger battery;
@end

@interface PedometerData : NSObject {
    
}

@property(nonatomic,retain)NSString *date;
@property(nonatomic,retain)NSString *deviceId;
@property(nonatomic,assign)NSInteger userNo;
@property(nonatomic,assign)NSInteger walkSteps;
@property(nonatomic,assign)NSInteger runSteps;
@property(nonatomic)double examount;
@property(nonatomic)double calories;                /*the unit is kilogram calories*/
@property(nonatomic,assign)NSInteger exerciseTime;   /*the unit is minute */
@property(nonatomic,assign)NSInteger distance;       /*the unit is meter*/
@property(nonatomic,assign)NSInteger battery;
@property(nonatomic,assign)NSInteger sleepStatus;
@property(nonatomic,assign)NSInteger intensityLevel;
@end

@interface KitchenScaleData : NSObject

@property(nonatomic, assign)double weight;
@property(nonatomic, assign)NSInteger sectionWeight;
@property(nonatomic, assign)NSInteger time;
@property(nonatomic, retain)NSString *unit;
@property(nonatomic, assign)NSInteger battery;
@end
