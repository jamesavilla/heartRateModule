//
//  LSBLEConnectorDelegate.h
//  LifesenseBle
//
//  Created by lifesense on 14-8-1.
//  Copyright (c) 2014年 lifesense. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <CoreBluetooth/CBPeripheral.h>
#import <CoreBluetooth/CBService.h>

@protocol LSBleConnectorDelegate <NSObject>

@optional

//扫描结果
-(void)bleConnectorDidScanResults:(CBPeripheral *)peripheral broadcastName:(NSString *)broadcastName serviceLists:(NSArray *)services manufacturerData:(NSString *)manufacturerData;

//连接失败
-(void)bleconnectorDidFailtoConnectPeripheralGatt;

//连接成功
-(void)bleConnectorDidConnectedPeripheralGatt;

//断开连接
-(void)bleConnectorDidDisConnectedPeripheralGatt;

//发现服务号
-(void)bleConnectorDidDiscoveredGattServices:(NSArray *)gattServices;

//发现特征号
-(void)bleConnectorDidDiscoveredCharacteristicForService:(CBService *)service;

//特征改变，有数据上传
-(void)bleConnectorDidUpdateValueForCharacteristic:(CBCharacteristic *)characteristic;

//写数据后回调
-(void)bleConnectorDidWrittenValueForCharacteristic:(CBCharacteristic *)characteristic;

-(void)bleConnectorDidUpdateNotificationStateForCharacteristic:(CBCharacteristic *)characteristic;

@end
