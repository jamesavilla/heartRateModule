//
//  DeviceUserProfiles+Handler.m
//  LSBluetooth-Demo
//
//  Created by lifesense on 15/8/20.
//  Copyright (c) 2015年 Lifesense. All rights reserved.
//

#import "DeviceUserProfiles+Handler.h"
#import "DeviceUser+Handler.h"
#import "DeviceAlarmClock+Handler.h"

@implementation DeviceUserProfiles (Handler)

+(DeviceUserProfiles *)createUserProfilesWithInfo:(NSDictionary *)profilesInfo
                           inManagedObjectContext:(NSManagedObjectContext *)context
{
    if(profilesInfo && context)
    {
        DeviceUserProfiles *userProfiles = nil;
    
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"DeviceUserProfiles"];
        NSPredicate *predicate=nil;
        
        NSString *key=[profilesInfo valueForKeyPath:KEY_USER_PROFILES_ID];
        
        predicate=[NSPredicate predicateWithFormat:@"userId = %@",key];
        request.predicate = predicate;
        
        NSError *error = nil;
        NSArray *matches = [context executeFetchRequest:request error:&error];
        
        if (!matches || ([matches count] > 1))
        {
            // handle error
        }
        else if ([matches count] == 0)
        {
            NSLog(@"save the user profiles to database %@",key);
           userProfiles=[self insertNewDeviceUserProfiles:profilesInfo inManagedObjectContext:context];
        }
        else
        {
            userProfiles=[self updateDeviceUserProfilesValue:profilesInfo
                                 userProfiles:[matches lastObject]
                                   context:context];
        }
        return userProfiles;
    }
    else
    {
        NSLog(@"failed to insert new object....");
        return nil;
    }
}

+(DeviceUserProfiles *)bindUserProfilesWithAlarmClockID:(NSString *)alarmClockId
                                 inManagedObjectContext:(NSManagedObjectContext *)context
{
    if(alarmClockId.length && context)
    {
        DeviceUserProfiles *userProfiles = nil;
        
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"DeviceUserProfiles"];
        NSPredicate *predicate=nil;
        
        predicate=[NSPredicate predicateWithFormat:@"alarmClockId = %@",alarmClockId];
        request.predicate = predicate;
        
        NSError *error = nil;
        NSArray *matches = [context executeFetchRequest:request error:&error];
        
        if (!matches || ([matches count] > 1))
        {
            // handle error
        }
        else if ([matches count] == 0)
        {
            NSLog(@"failed to bind alarm clock with id :%@",alarmClockId);
        }
        else
        {
            userProfiles = [matches lastObject];
        }
        
        return userProfiles;
    }
    else
    {
        NSLog(@"failed to bind device user....");
        return nil;
    }
    
    
}

+(DeviceUserProfiles *)bindUserProfilesWithScanFilterId:(NSString *)scanFilterId
                                 inManagedObjectContext:(NSManagedObjectContext *)context
{
    if(scanFilterId.length && context)
    {
        DeviceUserProfiles *userProfiles = nil;
        
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"DeviceUserProfiles"];
        NSPredicate *predicate=nil;
        
        predicate=[NSPredicate predicateWithFormat:@"scanFilterId = %@",scanFilterId];
        request.predicate = predicate;
        
        NSError *error = nil;
        NSArray *matches = [context executeFetchRequest:request error:&error];
        
        if (!matches || ([matches count] > 1))
        {
            // handle error
        }
        else if ([matches count] == 0)
        {
            NSLog(@"failed to bind scan filter with id :%@",scanFilterId);
        }
        else
        {
            userProfiles = [matches lastObject];
        }
        
        return userProfiles;
    }
    else
    {
        NSLog(@"failed to bind device user....");
        return nil;
    }
    

}


#pragma mark - 

+(DeviceUserProfiles *)updateDeviceUserProfilesValue:(NSDictionary *)userProfilesInfo
                      userProfiles:(DeviceUserProfiles *)oldUserProfiles
                        context:(NSManagedObjectContext *)context
{
    NSLog(@"update device user profiles  info %@",oldUserProfiles);
    oldUserProfiles.weightUnit=[userProfilesInfo valueForKeyPath:KEY_USER_PROFILES_WEIGHT_UNIT];
    
    id weighTarget=[userProfilesInfo valueForKeyPath:KEY_USER_PROFILES_WEIGHT_TARGET];
    
    oldUserProfiles.weightTarget=[NSNumber numberWithDouble:[weighTarget doubleValue]];
    
    
    oldUserProfiles.weekStart=[userProfilesInfo valueForKeyPath:KEY_USER_PROFILES_WEEK_START];
    
    oldUserProfiles.hourFormat=[userProfilesInfo valueForKeyPath:KEY_USER_PROFILES_HOUR_FORMAT];
    
    oldUserProfiles.distanceUnit=[userProfilesInfo valueForKeyPath:KEY_USER_PROFILES_DISTANCE_UNIT];
    
    id weekTargetSteps=[userProfilesInfo valueForKeyPath:KEY_USER_PROFILES_WEEK_TARGET_STEPS];
    
    oldUserProfiles.weekTargetSteps=[NSNumber numberWithInt:[weekTargetSteps integerValue]];
    
    oldUserProfiles.alarmClockId=[userProfilesInfo valueForKeyPath:KEY_USER_PROFILES_ALARM_CLOCK_ID];
    oldUserProfiles.scanFilterId=[userProfilesInfo valueForKeyPath:KEY_USER_PROFILES_SCAN_FILTER_ID];
    

    return oldUserProfiles;
}

+(DeviceUserProfiles *)insertNewDeviceUserProfiles:(NSDictionary *)userProfilesInfo
       inManagedObjectContext:(NSManagedObjectContext *)context
{
    NSLog(@"insert new device user profiles  info %@",userProfilesInfo);
    
    DeviceUserProfiles *newUserProfiles = nil;
    newUserProfiles = [NSEntityDescription insertNewObjectForEntityForName:@"DeviceUserProfiles"
                                           inManagedObjectContext:context];
    
    newUserProfiles.weightUnit=[userProfilesInfo valueForKeyPath:KEY_USER_PROFILES_WEIGHT_UNIT];
    
    id weighTarget=[userProfilesInfo valueForKeyPath:KEY_USER_PROFILES_WEIGHT_TARGET];
    
    newUserProfiles.weightTarget=[NSNumber numberWithDouble:[weighTarget doubleValue]];
  
    
    newUserProfiles.weekStart=[userProfilesInfo valueForKeyPath:KEY_USER_PROFILES_WEEK_START];
    
    newUserProfiles.hourFormat=[userProfilesInfo valueForKeyPath:KEY_USER_PROFILES_HOUR_FORMAT];
    
    newUserProfiles.distanceUnit=[userProfilesInfo valueForKeyPath:KEY_USER_PROFILES_DISTANCE_UNIT];
    
    id weekTargetSteps=[userProfilesInfo valueForKeyPath:KEY_USER_PROFILES_WEEK_TARGET_STEPS];
    
    newUserProfiles.weekTargetSteps=[NSNumber numberWithInt:[weekTargetSteps integerValue]];

    newUserProfiles.alarmClockId=[userProfilesInfo valueForKeyPath:KEY_USER_PROFILES_ALARM_CLOCK_ID];

    newUserProfiles.scanFilterId=[userProfilesInfo valueForKeyPath:KEY_USER_PROFILES_SCAN_FILTER_ID];
    
    newUserProfiles.userId=[userProfilesInfo valueForKeyPath:KEY_USER_PROFILES_ID];
    
    newUserProfiles.whoSet=[DeviceUser bindDeviceUserWithUserID:newUserProfiles.userId
                                 inManagedObjectContext:context];

    //    NSError *savingError = nil;
    //    if([context save: & savingError])
    //    {
    //        NSLog(@"done of save ble device........");
    //    }
    //    else NSLog(@"failed to save ble device........");
    
    return newUserProfiles;

}
@end
