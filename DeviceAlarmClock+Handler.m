//
//  DeviceAlarmClock+Handler.m
//  LSBluetooth-Demo
//
//  Created by lifesense on 15/8/25.
//  Copyright (c) 2015年 Lifesense. All rights reserved.
//

#import "DeviceAlarmClock+Handler.h"
#import "DeviceUserProfiles+Handler.h"

@implementation DeviceAlarmClock (Handler)


+(DeviceAlarmClock *)createAlarmClockWithInfo:(NSDictionary *)alarmClockInfo
                       inManagedObjectContext:(NSManagedObjectContext *)context
{
    if(alarmClockInfo && context)
    {
        DeviceAlarmClock *alarmClock = nil;
        
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"DeviceAlarmClock"];
        NSPredicate *predicate=nil;
        
        NSString *key=[alarmClockInfo valueForKeyPath:KEY_ALARM_CLOCK_ID];
        
        predicate=[NSPredicate predicateWithFormat:@"alarmClockId = %@",key];
        request.predicate = predicate;
        
        NSError *error = nil;
        NSArray *matches = [context executeFetchRequest:request error:&error];
        
        if (!matches || ([matches count] > 1))
        {
            // handle error
        }
        else if ([matches count] == 0)
        {
            NSLog(@"save the alarm clock to database %@",key);
            alarmClock=[self insertNewAlarmClock:alarmClockInfo
                          inManagedObjectContext:context];
        }
        else
        {
            alarmClock=[self updateAlarmClockValue:alarmClockInfo
                                        alarmClock:[matches lastObject]
                                           context:context];
        }
        return alarmClock;
    }
    else
    {
        NSLog(@"failed to insert new object....");
        return nil;
    }

}

+(DeviceAlarmClock *)updateAlarmClockValue:(NSDictionary *)alarmClockInfo
                              alarmClock:(DeviceAlarmClock *)oldAlarmClock
                                   context:(NSManagedObjectContext *)context
{
    NSLog(@"update alarm clock info %@",oldAlarmClock);
    BOOL monday=[[alarmClockInfo valueForKeyPath:KEY_ALARM_CLOCK_MONDAY] boolValue];
    BOOL tuesday=[[alarmClockInfo valueForKeyPath:KEY_ALARM_CLOCK_TUESDAY] boolValue];
    BOOL wednesday=[[alarmClockInfo valueForKeyPath:KEY_ALARM_CLOCK_WEDNESDAY] boolValue];
    BOOL thursday=[[alarmClockInfo valueForKeyPath:KEY_ALARM_CLOCK_THURSDAY] boolValue];
    BOOL friday=[[alarmClockInfo valueForKeyPath:KEY_ALARM_CLOCK_FRIDAY] boolValue];
    BOOL saturday=[[alarmClockInfo valueForKeyPath:KEY_ALARM_CLOCK_SATURDAY] boolValue];
    BOOL sunday=[[alarmClockInfo valueForKeyPath:KEY_ALARM_CLOCK_SUNDAY] boolValue];
   

    
    oldAlarmClock.alarmClockTime=[alarmClockInfo valueForKeyPath:KEY_ALARM_CLOCK_TIME];
    
    id alarmClockDay=[alarmClockInfo valueForKeyPath:KEY_ALARM_CLOCK_DAY];
    oldAlarmClock.alarmClockDay=[NSNumber numberWithInt:[alarmClockDay integerValue]];

    
    oldAlarmClock.monday=[NSNumber numberWithBool:monday];
    oldAlarmClock.tuesday=[NSNumber numberWithBool:tuesday];
    oldAlarmClock.wednesday=[NSNumber numberWithBool:wednesday];
    oldAlarmClock.thursday=[NSNumber numberWithBool:thursday];
    oldAlarmClock.friday=[NSNumber numberWithBool:friday];
    oldAlarmClock.saturday=[NSNumber numberWithBool:saturday];
    oldAlarmClock.sunday=[NSNumber numberWithBool:sunday];
    return oldAlarmClock;
}

+(DeviceAlarmClock *)insertNewAlarmClock:(NSDictionary *)alarmClockInfo
                  inManagedObjectContext:(NSManagedObjectContext *)context
{
    NSLog(@"insert new alarm clock %@",alarmClockInfo);
    
    DeviceAlarmClock *newAlarmClock = nil;
    newAlarmClock = [NSEntityDescription insertNewObjectForEntityForName:@"DeviceAlarmClock"
                                                  inManagedObjectContext:context];
    

    BOOL monday=[[alarmClockInfo valueForKeyPath:KEY_ALARM_CLOCK_MONDAY] boolValue];
    BOOL tuesday=[[alarmClockInfo valueForKeyPath:KEY_ALARM_CLOCK_TUESDAY] boolValue];
    BOOL wednesday=[[alarmClockInfo valueForKeyPath:KEY_ALARM_CLOCK_WEDNESDAY] boolValue];
    BOOL thursday=[[alarmClockInfo valueForKeyPath:KEY_ALARM_CLOCK_THURSDAY] boolValue];
    BOOL friday=[[alarmClockInfo valueForKeyPath:KEY_ALARM_CLOCK_FRIDAY] boolValue];
    BOOL saturday=[[alarmClockInfo valueForKeyPath:KEY_ALARM_CLOCK_SATURDAY] boolValue];
    BOOL sunday=[[alarmClockInfo valueForKeyPath:KEY_ALARM_CLOCK_SUNDAY] boolValue];
   
    newAlarmClock.alarmClockId=[alarmClockInfo valueForKeyPath:KEY_ALARM_CLOCK_ID];
    newAlarmClock.monday=[NSNumber numberWithBool:monday];
    newAlarmClock.tuesday=[NSNumber numberWithBool:tuesday];
    newAlarmClock.wednesday=[NSNumber numberWithBool:wednesday];
    newAlarmClock.thursday=[NSNumber numberWithBool:thursday];
    newAlarmClock.friday=[NSNumber numberWithBool:friday];
    newAlarmClock.saturday=[NSNumber numberWithBool:saturday];
    newAlarmClock.sunday=[NSNumber numberWithBool:sunday];
    

    newAlarmClock.alarmClockTime=[alarmClockInfo valueForKeyPath:KEY_ALARM_CLOCK_TIME];
    
    id alarmClockDay=[alarmClockInfo valueForKeyPath:KEY_ALARM_CLOCK_DAY];
    newAlarmClock.alarmClockDay=[NSNumber numberWithInt:[alarmClockDay integerValue]];
    
    newAlarmClock.deviceUser=[DeviceUserProfiles bindUserProfilesWithAlarmClockID:newAlarmClock.alarmClockId
                                                           inManagedObjectContext:context];
    return newAlarmClock;
    
}

@end
