//
//  LSHardwareConnector.h
//  Collector_A2_Demo
//
//  Created by apple on 12-11-29.
//  Copyright (c) 2012年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LSSensorDefine.h"
#import "PedometerUserInfo.h"
#import <CoreBluetooth/CoreBluetooth.h>

@protocol LSHardwareConnectorDelegate;

@interface LSHardwareConnector : NSObject
/**
 *  is iOS Device Support BLE
 */
@property(nonatomic,readonly)BOOL isBLEEnable;

/**
 *  is App Connected Sensor
 */
@property(nonatomic,readonly)BOOL hasConnectedSensor;

/**
 *  is Scanning device
 */
@property(nonatomic, readonly)BOOL isScanning;

/**
 *  Connector Delegate
 */
@property(nonatomic,assign)id<LSHardwareConnectorDelegate> delegate;

/**
 *  Singleton
 *
 *  @return Singleton
 */
+(LSHardwareConnector*)shareConnector;

/**
 *  Start Scanning
 *
 *  @param delegate Connector Delegate
 *  @param types    Set Can Scan SensorType Array，A NSArray containing information about <i>NSNumber</i> that was preserved by LS_SENSOR_TYPE
 *
 *  @see also LS_SENSOR_TYPE
 *  @see also LSHardwareConnectorDelegate
 *  @see also hardwareConnectorDiscoveredPairingSensor:
 *  @return NO:Fail   YES:Success
 */
-(BOOL)startScanningWithDelegate:(id <LSHardwareConnectorDelegate>)delegate withEnalbeSensorTypes:(NSArray *)types;

/**
 *  Cancel BLE Scann
 */
-(void)cancelScanning;

/**
 *  To Pair Deivce
 *
 *  @param sensor LSHardwareSensor Object
 *
 *  @see also PairConnectorDiscoveredPairingSensor:
 *  @see also PairConnectorPairedSensor:(LSHardwareSensor*)sensor withState:
 *  @return NO:Fail   YES:Sucess
 */
-(BOOL)pairWithHardwareSensor:(LSHardwareSensor*)sensor;

/**
 *  Get Paired Device Array
 *
 *  @return NSArray of LSHardwareSensor
 */
-(NSArray*)pairedSensors;

/**
 *  Insert Paired Sensor
 *
 *  @param sensor LSHardwareSensor Object get From Cloud
 *
 *  @return NO:Fail YES:Sucess
 */
-(BOOL)insertPairedSensorWithSensor:(LSHardwareSensor *)sensor;


/**
 *  Forget Paired Sensor
 *
 *  @param sensor LSHardwareSensor Object get From pairedSensors Method
 *
 *  @return NO:Fail YES:Sucess
 */
-(BOOL)forgetPairedSensorWithSensor:(LSHardwareSensor *)sensor;

@end


@protocol LSHardwareConnectorDelegate <NSObject>

@required

#pragma mark - Pair Mode Callback

/**
 *  Discover Pairing Sensor Callback
 *  @Notice Only discover Pairing Sensor(Long Press real device button to enter pairing mode.)
 *
 *  @param sensor Pairing Sensor,You should call pairWithHardwareSensor: method to Pair
 *  @see also startScanningWithDelegate:withEnalbeSensorTypes:
 *  @see also pairWithHardwareSensor:
 
 */
-(void)pairConnectorDiscoveredPairingSensor:(LSHardwareSensor*)sensor;

/**
 *  Paired Callback
 *
 *  @param sensor Paired Device
 *  @param state Paired state NO:fail YES:success
 */
-(void)pairConnectorPairedSensor:(LSHardwareSensor*)sensor withState:(BOOL)state;

@optional

#pragma mark - DownLoad Information Callback
/**
 *  Pedometer Info Request Callback
 *
 *  @param sensor device
 *
 *  @seealso PedometerUserDownLoadInfo
 *  @return PedometerUserDownLoadInfo Object
 */
- (PedometerUserDownLoadInfo *)hardwareConnectorGetPedometerDownloadInfoForSensor:(LSHardwareSensor *)sensor;

#pragma mark - Received Device Data Callback

/**
 *  Receive Weight Measurement Data
 *
 *  @param data Weight Measurement Data
 */
-(void)hardwareConnectorReceiveWeightMeasurementData:(WeightData*)data;

/**
 *  Receive Pedometer Measurement Data
 *
 *  @param data Pedometer Measurement Data
 */-(void)hardwareConnectorReceivePedometerMeasurementData:(PedometerData *)data;

/**
 *  Receive Blood Pressure Measurement Data
 *
 *  @param data Blood Pressure Measurement Data
 */
-(void)hardwareConnectorReceiveBloodPressureMeasurementData:(BloodPressureData *)data;

/**
 *  Receive Kitchen Scale Measurement Data
 *
 *  @param data Kitchen Scale Measurement Data
 */
-(void)hardwareConnectorReceiveKitchenScaleMeasurementData:(KitchenScaleData*)data;

/**
 *  Receive Height Measurement Data
 *
 *  @param data Height Measurement Data
 */
-(void)hardwareConnectorReceiveHeightMeasurementData:(HeightData*)data;

/**
 *  Receive General Weight Measurement Data
 *
 *  @param data General Weight Measurement Data
 */
-(void)hardwareConnectorReceiveGeneralWeightMeasurementData:(WeightData*)data;


@end
