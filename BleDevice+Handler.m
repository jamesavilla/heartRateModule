//
//  BleDevice+Handler.m
//  LSBluetooth-Demo
//
//  Created by lifesense on 15/8/20.
//  Copyright (c) 2015年 Lifesense. All rights reserved.
//

#import "BleDevice+Handler.h"
#import "DeviceUser+Handler.h"

@implementation BleDevice (Handler)

+(void)deleteBleDevice:(BleDevice *)delDevice
inManagedObjectContext:(NSManagedObjectContext *)context
{
    if(delDevice)
    {
        [context deleteObject:delDevice];
    }
}

+(BleDevice *)bindDeviceWithUserId:(NSString *)userId
                        deviceInfo:(LSDeviceInfo *)lsDeviceInfo
            inManagedObjectContext:(NSManagedObjectContext *)context
{
    if(lsDeviceInfo && context)
    {
        BleDevice *device = nil;
        NSString *protocol=lsDeviceInfo.protocolType;
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"BleDevice"];
        NSPredicate *predicate=nil;
        if([protocol isEqualToString:@"A3"])
        {
            predicate=[NSPredicate predicateWithFormat:@"(deviceID = %@) AND (deviceUserNumber = %@)",lsDeviceInfo.deviceId,[NSNumber numberWithInt:lsDeviceInfo.deviceUserNumber]];
            request.predicate = predicate;
        }
        else if([protocol isEqualToString:@"KITCHEN_SCALE"]
                ||[protocol isEqualToString:@"A4"]
                ||[protocol isEqualToString:@"GENERIC_FAT"])
        {
            predicate=[NSPredicate predicateWithFormat:@"deviceName = %@",lsDeviceInfo.deviceName];
            request.predicate = predicate;
        }
        else
        {
            predicate=[NSPredicate predicateWithFormat:@"deviceID = %@",lsDeviceInfo.deviceId];
            request.predicate = predicate;
           
        }
        
        
        NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"deviceName" ascending:YES];
        request.sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
        
        NSError *error = nil;
        NSArray *matches = [context executeFetchRequest:request error:&error];
        
        if (!matches || ([matches count] > 1))
        {
            // handle error
        }
        else if ([matches count] == 0)
        {
            NSLog(@"save the deivce to database %@",lsDeviceInfo.deviceId);
            device=[self insertNewBleDevice:lsDeviceInfo inManagedObjectContext:context toUser:userId];
        }
        else
        {
            NSLog(@"repeat the pairing with device.....");
            device=[self updateBleDeviceValue:lsDeviceInfo
                                 bleDevice:[matches lastObject]
                                   context:context];
        }
        return device;
    }
    else
    {
        NSLog(@"failed to insert new object....");
        return nil;
    }
}

+(BleDevice *)updateBleDeviceValue:(LSDeviceInfo *)lsDeviceInfo
                      bleDevice:(BleDevice *)oldDevice
                        context:(NSManagedObjectContext *)context
{
    NSLog(@"update device  info %@",lsDeviceInfo.deviceName);
    oldDevice.deviceName=lsDeviceInfo.deviceName;
    oldDevice.deviceID=lsDeviceInfo.deviceId;
    oldDevice.deviceSN=lsDeviceInfo.deviceSn;
    oldDevice.deviceType=[NSString stringWithFormat:@"%d",lsDeviceInfo.deviceType];
    oldDevice.password=lsDeviceInfo.password;
    oldDevice.broadcastID=lsDeviceInfo.broadcastId;
    oldDevice.hardwareVersion=lsDeviceInfo.hardwareVersion;
    oldDevice.firmwareVersion=lsDeviceInfo.firmwareVersion;
    oldDevice.softwareVersion=lsDeviceInfo.softwareVersion;
    oldDevice.protocolType=lsDeviceInfo.protocolType;
    oldDevice.identifier=lsDeviceInfo.peripheralIdentifier;
    oldDevice.modelNumber=lsDeviceInfo.modelNumber;
    oldDevice.deviceUserNumber=[NSNumber numberWithUnsignedLong:lsDeviceInfo.deviceUserNumber];
    
    return oldDevice;
}

+(BleDevice *)insertNewBleDevice:(LSDeviceInfo *)lsDeviceInfo
          inManagedObjectContext:(NSManagedObjectContext *)context
                          toUser:(NSString *)userId
{
    BleDevice *device = nil;
    device = [NSEntityDescription insertNewObjectForEntityForName:@"BleDevice"
                                           inManagedObjectContext:context];
    device.deviceName=lsDeviceInfo.deviceName;
    device.deviceID=lsDeviceInfo.deviceId;
    device.deviceSN=lsDeviceInfo.deviceSn;
    device.deviceType=[NSString stringWithFormat:@"%d",lsDeviceInfo.deviceType];
    device.password=lsDeviceInfo.password;
    device.broadcastID=lsDeviceInfo.broadcastId;
    device.hardwareVersion=lsDeviceInfo.hardwareVersion;
    device.firmwareVersion=lsDeviceInfo.firmwareVersion;
    device.softwareVersion=lsDeviceInfo.softwareVersion;
    device.protocolType=lsDeviceInfo.protocolType;
    device.identifier=lsDeviceInfo.peripheralIdentifier;
    device.modelNumber=lsDeviceInfo.modelNumber;
    device.deviceUserNumber=[NSNumber numberWithUnsignedLong:lsDeviceInfo.deviceUserNumber];
    
    device.userId=userId;
    
    device.whoBind=[DeviceUser bindDeviceUserWithUserID:device.userId
                                 inManagedObjectContext:context];
  
//    NSError *savingError = nil;
//    if([context save: & savingError])
//    {
//        NSLog(@"done of save ble device........");
//    }
//    else NSLog(@"failed to save ble device........");
    return device;
}
@end
