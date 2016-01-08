//
//  ScanFilter+Handler.m
//  LSBluetooth-Demo
//
//  Created by lifesense on 15/8/26.
//  Copyright (c) 2015年 Lifesense. All rights reserved.
//

#import "ScanFilter+Handler.h"
#import "DeviceUserProfiles+Handler.h"

@implementation ScanFilter (Handler)


+(ScanFilter *)createScanFilterWithInfo:(NSDictionary *)scanFilterInfo
                 inManagedObjectContext:(NSManagedObjectContext *)context
{
    if(scanFilterInfo && context)
    {
        ScanFilter *scanFilter = nil;
        
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"ScanFilter"];
        NSPredicate *predicate=nil;
        
        NSString *key=[scanFilterInfo  valueForKeyPath:KEY_SCAN_FILTER_ID];
        
        predicate=[NSPredicate predicateWithFormat:@"filterId = %@",key];
        request.predicate = predicate;
        
        NSError *error = nil;
        NSArray *matches = [context executeFetchRequest:request error:&error];
        
        if (!matches || ([matches count] > 1))
        {
            // handle error
        }
        else if ([matches count] == 0)
        {
            NSLog(@"save the scan filter to database %@",key);
            scanFilter=[self insertNewScanFilter:scanFilterInfo
                          inManagedObjectContext:context];
        }
        else
        {
            scanFilter=[self updateScanFilterValue:scanFilterInfo
                                        scanFilter:[matches lastObject]
                                           context:context];
        }
        return scanFilter;
    }
    else
    {
        NSLog(@"failed to insert new object....");
        return nil;
    }
    
}

+(ScanFilter *)updateScanFilterValue:(NSDictionary *)scanFilterClockInfo
                                scanFilter:(ScanFilter *)oldScanFilter
                                   context:(NSManagedObjectContext *)context
{
    NSLog(@"update scan filter info %@",oldScanFilter);
   
    BOOL enableFat=[[oldScanFilter valueForKeyPath:KEY_SCAN_FILTER_FAT_SCALE] boolValue];

    BOOL enableHeight=[[oldScanFilter valueForKeyPath:KEY_SCAN_FILTER_HEIGHT] boolValue];
    
    BOOL enableWeight=[[oldScanFilter valueForKeyPath:KEY_SCAN_FILTER_WEIGHT_SCALE] boolValue];
    
    BOOL enablePedometer=[[oldScanFilter valueForKeyPath:KEY_SCAN_FILTER_PEDOMETER] boolValue];
    
    BOOL enableBloodPressure=[[oldScanFilter valueForKeyPath:KEY_SCAN_FILTER_BLOOD_PRESSURE] boolValue];
    
    BOOL enableKitchen=[[oldScanFilter valueForKeyPath:KEY_SCAN_FILTER_KITCHEN] boolValue];
 
    
    oldScanFilter.enableFatScale=[NSNumber numberWithBool:enableFat];
    oldScanFilter.enableHeightMeter=[NSNumber numberWithBool:enableHeight];

    oldScanFilter.enableKitchenScale=[NSNumber numberWithBool:enableKitchen];

    oldScanFilter.enablePedometer=[NSNumber numberWithBool:enablePedometer];

    oldScanFilter.enableWeightScale=[NSNumber numberWithBool:enableWeight];

    oldScanFilter.enableBloodPressure=[NSNumber numberWithBool:enableBloodPressure];

    oldScanFilter.broadcastType=[oldScanFilter valueForKeyPath:KEY_SCAN_FILTER_BROADCAST];

    return oldScanFilter;
}

+(ScanFilter *)insertNewScanFilter:(NSDictionary *)scanFilterInfo
                  inManagedObjectContext:(NSManagedObjectContext *)context
{
    NSLog(@"insert new scan filter %@",scanFilterInfo);
    
    ScanFilter *newScanFilter = nil;
    newScanFilter = [NSEntityDescription insertNewObjectForEntityForName:@"ScanFilter"
                                                  inManagedObjectContext:context];
    
    
    BOOL enableFat=[[scanFilterInfo valueForKeyPath:KEY_SCAN_FILTER_FAT_SCALE] boolValue];
    
    BOOL enableHeight=[[scanFilterInfo valueForKeyPath:KEY_SCAN_FILTER_HEIGHT] boolValue];
    
    BOOL enableWeight=[[scanFilterInfo valueForKeyPath:KEY_SCAN_FILTER_WEIGHT_SCALE] boolValue];
    
    BOOL enablePedometer=[[scanFilterInfo valueForKeyPath:KEY_SCAN_FILTER_PEDOMETER] boolValue];
    
    BOOL enableBloodPressure=[[scanFilterInfo valueForKeyPath:KEY_SCAN_FILTER_BLOOD_PRESSURE] boolValue];
    
    BOOL enableKitchen=[[scanFilterInfo valueForKeyPath:KEY_SCAN_FILTER_KITCHEN] boolValue];
    
    newScanFilter.filterId=[scanFilterInfo valueForKeyPath:KEY_SCAN_FILTER_ID];
    newScanFilter.enableFatScale=[NSNumber numberWithBool:enableFat];
    newScanFilter.enableHeightMeter=[NSNumber numberWithBool:enableHeight];
    
    newScanFilter.enableKitchenScale=[NSNumber numberWithBool:enableKitchen];
    
    newScanFilter.enablePedometer=[NSNumber numberWithBool:enablePedometer];
    
    newScanFilter.enableWeightScale=[NSNumber numberWithBool:enableWeight];
    
    newScanFilter.enableBloodPressure=[NSNumber numberWithBool:enableBloodPressure];
    
    newScanFilter.broadcastType=[scanFilterInfo valueForKeyPath:KEY_SCAN_FILTER_BROADCAST];
    
    newScanFilter.deviceUser=[DeviceUserProfiles bindUserProfilesWithAlarmClockID:newScanFilter.filterId
                                                           inManagedObjectContext:context];
    return newScanFilter;
}


@end
