//
//  DataFormatConverter.m
//  LSBluetooth-Demo
//
//  Created by lifesense on 15/8/20.
//  Copyright (c) 2015年 Lifesense. All rights reserved.
//

#import "DataFormatConverter.h"
#import <objc/runtime.h>

static NSString *kProtocolKitchen=@"KITCHEN_SCALE";
static NSString *kProtocolA4=@"A4";
static NSString *kProtocolGenericFat=@"GENERIC_FAT";



@implementation DataFormatConverter


+(LSDeviceType)stringToDeviceType:(id)type
{
    int tempType=[type intValue];
    LSDeviceType tempDeviceType;
    switch (tempType)
    {
        case LS_WEIGHT_SCALE: tempDeviceType=LS_WEIGHT_SCALE;  break;
        case LS_FAT_SCALE:tempDeviceType=LS_FAT_SCALE; break;
        case LS_PEDOMETER:tempDeviceType=LS_PEDOMETER;break;
        case LS_SPHYGMOMETER:tempDeviceType=LS_SPHYGMOMETER;break;
        case LS_HEIGHT_MIRIAM:tempDeviceType=LS_HEIGHT_MIRIAM;break;
        case LS_KITCHEN_SCALE:tempDeviceType=LS_KITCHEN_SCALE;break;
        default:
            break;
    }
    return tempDeviceType;
}

+(LSDeviceInfo *)convertedToLSDeviceInfo:(BleDevice *)bleDevice
{
    if (bleDevice)
    {
        LSDeviceInfo *lsDevice=[[LSDeviceInfo alloc] init];
        lsDevice.deviceId=bleDevice.deviceID;
        lsDevice.broadcastId=bleDevice.broadcastID;
        lsDevice.password=bleDevice.password;
        lsDevice.protocolType=bleDevice.protocolType;
        lsDevice.deviceType=[self stringToDeviceType:bleDevice.deviceType];
        lsDevice.deviceUserNumber=[bleDevice.deviceUserNumber integerValue];
        lsDevice.peripheralIdentifier=bleDevice.identifier;
        lsDevice.deviceName=bleDevice.deviceName;
        return lsDevice;
    }
    else return nil;
}

+(UIImage *)getDeviceImageViewWithType:(LSDeviceType)deviceType
{
    UIImage *image=nil;
    if(deviceType==LS_FAT_SCALE)
    {
        image=[UIImage imageNamed:@"fat_scale.png"];
    }
    else if(deviceType==LS_SPHYGMOMETER)
    {
        image=[UIImage imageNamed:@"blood_pressure.png"];
    }
    else if(deviceType==LS_PEDOMETER)
    {
        image=[UIImage imageNamed:@"pedometer.png"];
    }
    else if (deviceType==LS_KITCHEN_SCALE)
    {
        image=[UIImage imageNamed:@"kitchen_scale.png"];
    }
    else if (deviceType==LS_HEIGHT_MIRIAM)
    {
        image=[UIImage imageNamed:@"height.png"];
    }
    else
    {
        image=[UIImage imageNamed:@"weight_scale.png"];
    }
    return image;
    
}

+(NSString *)getDeviceNameForNormalBroadcasting:(NSString *)deviceName
{
    if(deviceName.length)
    {
        if(deviceName.length<=5)
        {
            return deviceName;
        }
        else return deviceName=[deviceName substringToIndex:5];
        
        
    }
    else return nil;
    
}

+(BOOL)isNotRequiredPairDevice:(NSString *)protocol
{
    if(protocol.length)
    {
        if([protocol isEqualToString:kProtocolA4]
           ||[protocol isEqualToString:kProtocolKitchen]
           ||[protocol isEqualToString:kProtocolGenericFat])
        {
            return YES;
        }
        else return NO;
        
    }
    else return NO;
}

+(NSAttributedString *)parseObjectDetailInAttributedString:(id)obj recordNumber:(NSUInteger)number
{
    if(!obj)
    {
        return nil;
    }
    else
    {
        NSMutableString * deviceDetailsMsg=[[NSMutableString alloc] init];
        
        NSMutableDictionary *propertyDictionary = [[NSMutableDictionary alloc] init];
        unsigned int numberOfProperties=0;
        
        objc_property_t *properties=class_copyPropertyList([obj class], &numberOfProperties);
    
        if(number>0)
        {
            NSString *titleHtmlStr=[NSString stringWithFormat:@"</br><h3><font color='#dc143c' size='5'>Record Number : %ld</font></h3>",(unsigned long)number];
            [deviceDetailsMsg appendString:titleHtmlStr];
        }
        else
        {
            NSString *titleHtmlStr=[NSString stringWithFormat:@"<h5><font color='#800080' size='4'>...............Weight Append Data...........</font></h5>"];
            [deviceDetailsMsg appendString:titleHtmlStr];
        }
        
        for(int i=0;i<numberOfProperties; i++)
        {
            objc_property_t property = properties[i];
            NSString *propertyName=[NSString stringWithUTF8String:property_getName(property)];
            id propValue=[obj valueForKey:propertyName];
            if(propValue)
            {
                [propertyDictionary setObject:propValue forKey:propertyName];
                NSString *msg=[NSString stringWithFormat:@"<font size='5'>%@ : %@</font></br>",propertyName,propValue];
                [deviceDetailsMsg appendString:msg];
            }
            else [propertyDictionary setObject:@"null" forKey:propertyName];
        }
        
        
        NSAttributedString *attributedString=[[NSAttributedString alloc] initWithData:[deviceDetailsMsg dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType} documentAttributes:nil error:nil];
        
        return attributedString;
    }

}


+(LSProductUserInfo *)getProductUserInfo:(DeviceUser *)deviceUser
{
    NSLog(@"device user info %@",[DataFormatConverter parseObjectDetailInDictionary:deviceUser]);
    
    if(!deviceUser.birthday)
    {
        NSLog(@"birthday is nil .......");
    }
    
    NSCalendar *calender=[NSCalendar currentCalendar];
    NSDateComponents *dateComponents=[calender components:(NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitYear) fromDate:deviceUser.birthday];
    
    NSInteger year=[dateComponents year];
    
    dateComponents=[calender components:(NSCalendarUnitHour|NSCalendarUnitMinute| NSCalendarUnitYear) fromDate:[NSDate date]];
    NSInteger currentYear=[dateComponents year];
    
    LSProductUserInfo *userInfo=[[LSProductUserInfo alloc] init];
    userInfo.height=[deviceUser.height doubleValue];
    userInfo.goalWeight=[deviceUser.userprofiles.weightTarget integerValue];
    userInfo.age=currentYear-year;
    
    if([deviceUser.gender isEqualToString:@"Male"])
    {
        userInfo.sex=SEX_MALE;
    }
    else userInfo.sex=SEX_FEMALE;
    
    if([deviceUser.userprofiles.weightUnit isEqualToString:@"Lb"])
    {
        userInfo.unit=UNIT_LB;
    }
    else if([deviceUser.userprofiles.weightUnit isEqualToString:@"St"])
    {
        userInfo.unit=UNIT_ST;
    }
    else userInfo.unit=UNIT_KG;
    
    userInfo.athleteLevel=[deviceUser.athleteLevel integerValue];
    
    return userInfo;
}

+(LSPedometerAlarmClock *)getPedometerAlarmClock:(DeviceAlarmClock *)deviceAlarmClock
{
    NSCalendar *calender=[NSCalendar currentCalendar];
    NSDateComponents *dateComponents=[calender components:(NSCalendarUnitHour|NSCalendarUnitMinute) fromDate:deviceAlarmClock.alarmClockTime];
    
    NSInteger hour=[dateComponents hour];
    NSInteger minute=[dateComponents minute];
    
    LSPedometerAlarmClock *alarmClock=[[LSPedometerAlarmClock alloc] init];
    alarmClock.switch1=1;
    alarmClock.day1=[self getAlarmClockDayCount:deviceAlarmClock];
    alarmClock.hour1=hour;
    alarmClock.minute1=minute;
    
    return alarmClock;
}

+(LSPedometerUserInfo *)getPedometerUserInfo:(DeviceUser *)deviceUser
{
    NSCalendar *calender=[NSCalendar currentCalendar];
    NSDateComponents *dateComponents=[calender components:(NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitYear) fromDate:deviceUser.birthday];
    
    NSInteger year=[dateComponents year];
    
    NSLog(@"user birthday %ld",year);
    
    dateComponents=[calender components:(NSCalendarUnitHour|NSCalendarUnitMinute| NSCalendarUnitYear) fromDate:[NSDate date]];
    NSInteger currentYear=[dateComponents year];
    
    
    LSPedometerUserInfo *puserInfo=[[LSPedometerUserInfo alloc] init];
    puserInfo.height=[deviceUser.height doubleValue];
    puserInfo.weight=[deviceUser.weight doubleValue];
    puserInfo.age=currentYear-year;
    
    NSLog(@"currentYear= %ld",currentYear);
    
    if([deviceUser.userprofiles.weekStart isEqualToString:@"Sunday"])
    {
        puserInfo.weekStart=1;
    }
    else puserInfo.weekStart=2;
    
    if([deviceUser.userprofiles.hourFormat isEqualToString:@"12"])
    {
        puserInfo.hourSystem=HOUR_12;
    }
    else puserInfo.hourSystem=HOUR_24;
    
    if ([deviceUser.userprofiles.distanceUnit isEqualToString:@"Mile"])
    {
        puserInfo.lengthUnit=LENGTH_UNIT_MILE;
    }
    else puserInfo.lengthUnit=LENGTH_UNIT_KILOMETER;
    
    puserInfo.targetStep=[deviceUser.userprofiles.weekTargetSteps integerValue];
    
    return puserInfo;
}

+(int)getAlarmClockDayCount:(DeviceAlarmClock *)deviceAlarmClock
{
    int dayCount=0;
    if(deviceAlarmClock)
    {
        if([deviceAlarmClock.monday boolValue])
        {
            dayCount +=MONDAY;
        }
        if([deviceAlarmClock.tuesday boolValue])
        {
            dayCount +=TUESDAY;
        }
        if([deviceAlarmClock.wednesday boolValue])
        {
            dayCount +=WEANSDAY;
        }
        if([deviceAlarmClock.thursday boolValue])
        {
            dayCount +=THURSDAY;
        }
        
        if([deviceAlarmClock.friday boolValue])
        {
            dayCount +=FRIDAY;
        }
        if([deviceAlarmClock.saturday boolValue])
        {
            dayCount +=SATADAY;
        }
        if([deviceAlarmClock.sunday boolValue])
        {
            dayCount +=SUNDAY;
        }
    }
    return dayCount;
}

+(NSString *)parseObjectDetailInStringValue:(id)obj
{
    if(!obj)
    {
        return nil;
    }
    else
    {
        NSMutableString * deviceDetailsMsg=[[NSMutableString alloc] init];
        
        NSMutableDictionary *propertyDictionary = [[NSMutableDictionary alloc] init];
        unsigned int numberOfProperties=0;
        
        objc_property_t *properties=class_copyPropertyList([obj class], &numberOfProperties);
        
        for(int i=0;i<numberOfProperties; i++)
        {
            objc_property_t property = properties[i];
            NSString *propertyName=[NSString stringWithUTF8String:property_getName(property)];
            id propValue=[obj valueForKey:propertyName];
            if(propValue)
            {
                [propertyDictionary setObject:propValue forKey:propertyName];
                NSString *msg=[NSString stringWithFormat:@"\n%@ : %@",propertyName,propValue];
                [deviceDetailsMsg appendString:msg];
            }
            else [propertyDictionary setObject:@"null" forKey:propertyName];
        }
        return deviceDetailsMsg;
    }
}


+(NSDictionary *)parseObjectDetailInDictionary:(id)obj
{
    if(!obj)
    {
        return nil;
    }
    else
    {
        NSMutableString * deviceDetailsMsg=[[NSMutableString alloc] init];
        
        NSMutableDictionary *propertyDictionary = [[NSMutableDictionary alloc] init];
        unsigned int numberOfProperties=0;
        
        objc_property_t *properties=class_copyPropertyList([obj class], &numberOfProperties);
        
        for(int i=0;i<numberOfProperties; i++)
        {
            objc_property_t property = properties[i];
            NSString *propertyName=[NSString stringWithUTF8String:property_getName(property)];
            id propValue=[obj valueForKey:propertyName];
            if(propValue)
            {
                [propertyDictionary setObject:propValue forKey:propertyName];
                NSString *msg=[NSString stringWithFormat:@"\n%@ : %@",propertyName,propValue];
                [deviceDetailsMsg appendString:msg];
            }
            else [propertyDictionary setObject:@"null" forKey:propertyName];
        }
        return propertyDictionary;
    }
}

#pragma mark - private methods
//保留一位小数
+(NSString *)doubleValueWithOneDecimalFormat:(double)weightValue
{
    
    NSNumberFormatter *doubleValueFormatter=[[NSNumberFormatter alloc] init];
    [doubleValueFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
    [doubleValueFormatter setPaddingPosition:NSNumberFormatterPadAfterSuffix];
    [doubleValueFormatter setFormatWidth:1];
    [doubleValueFormatter setMaximumFractionDigits:1];
    NSString *lbValueStr=[doubleValueFormatter stringFromNumber:[NSNumber numberWithDouble:weightValue]];
    return lbValueStr;
    
}

+(NSString *)doubleValueWithTwoDecimalFormat:(double)weightValue
{
    
    NSNumberFormatter *doubleValueFormatter=[[NSNumberFormatter alloc] init];
    [doubleValueFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
    [doubleValueFormatter setPaddingPosition:NSNumberFormatterPadAfterSuffix];
    [doubleValueFormatter setFormatWidth:2];
    [doubleValueFormatter setMaximumFractionDigits:2];
    NSString *lbValueStr=[doubleValueFormatter stringFromNumber:[NSNumber numberWithDouble:weightValue]];
    return lbValueStr;
    
}

@end
