//
//  LSBlePairingDelegate.h
//  LsBluetooth-Test
//
//  Created by sky on 14-8-13.
//  Copyright (c) 2014年 com.lifesense.ble. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LSWeightData.h"

@protocol LSBlePairingDelegate <NSObject>

@required
-(void)bleManagerDidPairedResults:(LSDeviceInfo *)lsDevice pairStatus:(int)pairStatus;

@optional
-(void)bleManagerDidDiscoverUserList:(NSDictionary *)userlist;

-(void)bleManagerDidReceiveWeightDataWithOperatingMode2:(LSWeightData *)weightData;

@end
