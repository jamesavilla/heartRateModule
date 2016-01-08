//
//  BleManagerProfiles.h
//  LsBluetooth-Test
//
//  Created by lifesense on 14-8-5.
//  Copyright (c) 2014年 com.lifesense.ble. All rights reserved.
//


#import "LSWeightData.h"
#import "LSHeightData.h"
#import "LSKitchenScaleData.h"
#import "LSSphygmometerData.h"
#import "LSPedometerData.h"
#import "LSWeightAppendData.h"
#import "LSProductUserInfo.h"
#import "LSDeviceInfo.h"
#import "LSBlePairingDelegate.h"
#import "LSBleDataReceiveDelegate.h"
#import "LSPedometerUserInfo.h"
#import "LSPedometerAlarmClock.h"
#import "LSVibrationVoice.h"
#import "LSDeviceConnectDelegate.h"
#import "LSSleepRecord.h"


#ifndef LsBluetooth_Test_BleManagerProfiles_h
#define LsBluetooth_Test_BleManagerProfiles_h


typedef enum{
    MANAGER_WORK_STATUS_IBLE=0,
    MANAGER_WORK_STATUS_SCAN=1,
    MANAGER_WORK_STATUS_PAIR=2,
    MANAGER_WORK_STATUS_UPLOAD=3,
    MANAGER_WORK_STATUS_CONNECT=4,
}ManagerWorkStatus;


typedef enum
{
    BROADCAST_TYPE_NORMAL=1,
    BROADCAST_TYPE_PAIR=2,
    BROADCAST_TYPE_ALL=3,
}BroadcastType;

typedef enum {
    PAIRED_SUCCESS=1,
    PAIRED_FAILED=2,
}PairedResults;

typedef enum{
    DATA_UPLOAD_SUCCESS=1,
    DATA_UPLOAD_FAILED=2,
} DataUploadResults;

#endif