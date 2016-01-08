//
//  ScanFilter+Handler.h
//  LSBluetooth-Demo
//
//  Created by lifesense on 15/8/26.
//  Copyright (c) 2015年 Lifesense. All rights reserved.
//

#import "ScanFilter.h"

#define KEY_SCAN_FILTER_ID              @"scanFilterId"
#define KEY_SCAN_FILTER_BROADCAST       @"broadcastType"
#define KEY_SCAN_FILTER_FAT_SCALE       @"enableFatScale"
#define KEY_SCAN_FILTER_WEIGHT_SCALE    @"enableWeightScale"
#define KEY_SCAN_FILTER_PEDOMETER       @"enablePeodmeter"
#define KEY_SCAN_FILTER_HEIGHT          @"enableHeight"
#define KEY_SCAN_FILTER_BLOOD_PRESSURE  @"enableBloodPressure"
#define KEY_SCAN_FILTER_KITCHEN         @"enableKitchenScale"

@interface ScanFilter (Handler)

+(ScanFilter *)createScanFilterWithInfo:(NSDictionary *)scanFilterInfo
                       inManagedObjectContext:(NSManagedObjectContext *)context;

@end
