//
//  LSDeviceProfiles.h
//  LifesenseBle
//
//  Created by lifesense on 14-8-1.
//  Copyright (c) 2014年 lifesense. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * 设备类型：01 体重秤、02 脂肪秤、03 身高、04 计步器、
 * 05  腰围尺、06 血糖仪、07 体温计、08 血压计
 */

typedef enum
{
    TYPE_UNKONW=0,
    LS_WEIGHT_SCALE=1,
    LS_FAT_SCALE = 2,
    LS_HEIGHT_MIRIAM = 3,
    LS_PEDOMETER =4,
    LS_WAISTLINE_MIRIAM=5,
    LS_GLUCOSE_METER=6,
    LS_THERMOMETER=7,
    LS_SPHYGMOMETER =8,
    LS_KITCHEN_SCALE = 9,
}LSDeviceType;


@interface LSDeviceInfo : NSObject

@property(nonatomic,strong)NSString *deviceId;      //设备ID
@property(nonatomic,strong)NSString *deviceSn;      //设备SN
@property(nonatomic,strong)NSString *deviceName;    //设备名称
@property(nonatomic,strong)NSString *modelNumber;   //设备型号
@property(nonatomic,strong)NSString *password;      //密码
@property(nonatomic,strong)NSString *broadcastId;   //广播ID
@property(nonatomic,strong)NSString *protocolType;      //协议类型
@property(nonatomic)BOOL preparePair;                 //是否处于配对状态，不用保存在数据库，只是临时变量
@property(nonatomic)LSDeviceType deviceType;          //设备类型
@property(nonatomic)NSUInteger supportDownloadInfoFeature;//支持下载用户信息的类型
@property(nonatomic)NSInteger maxUserQuantity;          //最大用户数
@property(nonatomic,strong)NSString *softwareVersion;   //软件版本
@property(nonatomic,strong)NSString *hardwareVersion;   //硬件版本
@property(nonatomic,strong)NSString *firmwareVersion;   //固件版本
@property(nonatomic,strong)NSString *manufactureName;   //制造商名称
@property(nonatomic,strong)NSString *systemId;          //系统ID,暂时无值


//new change for version 1.1.1
@property(nonatomic,strong)NSString *peripheralIdentifier;//系统蓝牙设备的id,可以唯一表示一个设备
@property(nonatomic)NSUInteger deviceUserNumber;
@end




