//
//  LSConnectDeviceDelegate.h
//  LSBluetooth-Library
//
//  Created by lifesense on 15/5/5.
//  Copyright (c) 2015年 Lifesense. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol LSDeviceConnectDelegate <NSObject>

-(void) bleManagerDidWaitingForStartMeasuring:(NSString *) deviceId;

-(void) bleManagerDidReceiveBloodPressureMeasuredData:(LSSphygmometerData *) bpData;

-(void) bleManagerDidConnectStateChange:(DeviceConnectState)connectState;
@end
