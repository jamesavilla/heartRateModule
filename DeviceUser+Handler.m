//
//  DeviceUser+Handler.m
//  LSBluetooth-Demo
//
//  Created by lifesense on 15/8/20.
//  Copyright (c) 2015年 Lifesense. All rights reserved.
//

#import "DeviceUser+Handler.h"

@implementation DeviceUser (Handler)

+(DeviceUser *)createDeviceUserWithUserInfo:(NSDictionary *)userInfo
                 inManagedObjectContext:(NSManagedObjectContext *)context
{
    if(userInfo && context)
    {
        DeviceUser *deviceUser = nil;
        
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"DeviceUser"];
        NSPredicate *predicate=nil;
        
        predicate=[NSPredicate predicateWithFormat:@"userID = %@",[userInfo valueForKeyPath:DEVICE_USER_KEY_ID]];
        request.predicate = predicate;
        
        NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
        request.sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
        
        NSError *error = nil;
        NSArray *matches = [context executeFetchRequest:request error:&error];
        
        if (!matches || ([matches count] > 1))
        {
            // handle error
        }
        else if ([matches count] == 0)
        {
            NSLog(@"save device user info with name=%@,user id=%@",[userInfo valueForKeyPath:DEVICE_USER_KEY_NAME],[userInfo valueForKeyPath:DEVICE_USER_KEY_ID]);
            [self insertNewDeviceUser:userInfo inManagedObjectContext:context];
        }
        else
        {
            deviceUser=[self updateDeviceUserWithInfo:userInfo
                                         inDeviceUser:[matches lastObject]];
            
        }
        
        return deviceUser;
    }
    else
    {
        NSLog(@"failed to insert new object....");
        return nil;
    }
}

+(DeviceUser *)bindDeviceUserWithUserID:(NSString *)userId
                 inManagedObjectContext:(NSManagedObjectContext *)context
{
    if(userId.length && context)
    {
        DeviceUser *deviceUser = nil;
        
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"DeviceUser"];
        NSPredicate *predicate=nil;
        
        predicate=[NSPredicate predicateWithFormat:@"userID = %@",userId];
        request.predicate = predicate;
        
        NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
        request.sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
        
        NSError *error = nil;
        NSArray *matches = [context executeFetchRequest:request error:&error];
        
        if (!matches || ([matches count] > 1))
        {
            // handle error
        }
        else if ([matches count] == 0)
        {
            NSLog(@"failed to bind device user with id :%@",userId);
        }
        else
        {
            deviceUser = [matches lastObject];
        }
        
        return deviceUser;
    }
    else
    {
        NSLog(@"failed to bind device user....");
        return nil;
    }
    
}



+(DeviceUser *)insertNewDeviceUser:(NSDictionary *)userInfo
        inManagedObjectContext:(NSManagedObjectContext *)context
{
    DeviceUser *newUser = nil;
    newUser = [NSEntityDescription insertNewObjectForEntityForName:@"DeviceUser"
                                            inManagedObjectContext:context];
    newUser.userID=[userInfo valueForKeyPath:DEVICE_USER_KEY_ID];
    newUser.name=[userInfo valueForKeyPath:DEVICE_USER_KEY_NAME];
    newUser.gender=[userInfo valueForKeyPath:DEVICE_USER_KEY_GENDER];
    
    NSString *dateString=[userInfo valueForKeyPath:DEVICE_USER_KEY_BIRTHDAY];
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd"];
    NSDate *birthday=[dateFormatter dateFromString:dateString];
    newUser.birthday=birthday;
    
    id  heightValue=[userInfo valueForKeyPath:DEVICE_USER_KEY_HEIGHT];
    newUser.height=[NSNumber numberWithDouble:[heightValue doubleValue]];
    
    id weightValue=[userInfo valueForKeyPath:DEVICE_USER_KEY_WEIGHT];
    newUser.weight=[NSNumber numberWithDouble:[weightValue doubleValue]];
    
    id athleteLevelValue=[userInfo valueForKeyPath:DEVICE_USER_KEY_ATHLETELEVEL];
    newUser.athleteLevel=[NSNumber numberWithInteger:[athleteLevelValue integerValue]];
    
    dateFormatter=nil;
    
    //    NSError *savingError = nil;
    //    if([context save: & savingError])
    //    {
    //        NSLog(@"done of save device user........");
    //    }
    //    else NSLog(@"failed to save device user........");
    
    return newUser;
}


+(DeviceUser *)updateDeviceUserWithInfo:(NSDictionary *)userInfo
                           inDeviceUser:(DeviceUser *)oldDeviceUser
{
    oldDeviceUser.userID=[userInfo valueForKeyPath:DEVICE_USER_KEY_ID];
    oldDeviceUser.name=[userInfo valueForKeyPath:DEVICE_USER_KEY_NAME];
    oldDeviceUser.gender=[userInfo valueForKeyPath:DEVICE_USER_KEY_GENDER];
    NSString *dateString=[userInfo valueForKeyPath:DEVICE_USER_KEY_BIRTHDAY];
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd"];
    NSDate *birthday=[dateFormatter dateFromString:dateString];
    oldDeviceUser.birthday=birthday;
    
    id  heightValue=[userInfo valueForKeyPath:DEVICE_USER_KEY_HEIGHT];
    oldDeviceUser.height=[NSNumber numberWithDouble:[heightValue doubleValue]];
    
    id weightValue=[userInfo valueForKeyPath:DEVICE_USER_KEY_WEIGHT];
    oldDeviceUser.weight=[NSNumber numberWithDouble:[weightValue doubleValue]];
    
    id athleteLevelValue=[userInfo valueForKeyPath:DEVICE_USER_KEY_ATHLETELEVEL];
    oldDeviceUser.athleteLevel=[NSNumber numberWithInteger:[athleteLevelValue integerValue]];
    
    return oldDeviceUser;
}
@end
