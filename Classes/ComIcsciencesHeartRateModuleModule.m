/**
 * Your Copyright Here
 *
 * Appcelerator Titanium is Copyright (c) 2009-2010 by Appcelerator, Inc.
 * and licensed under the Apache Public License (version 2)
 */
#import "ComIcsciencesHeartRateModuleModule.h"
#import "TiBase.h"
#import "TiHost.h"
#import "TiUtils.h"
#import <LifesenseBluetooth/LSBLEDeviceManager.h>
#import "DataFormatConverter.h"
#import "LSDatabaseManager.h"
#import "DatabaseManagerDelegate.h"
#import "DeviceUser+Handler.h"
#import "DeviceUser.h"
#import "ScanFilter.h"
#import "DeviceUserProfiles.h"
#import <objc/runtime.h>
#import "BleDevice+Handler.h"

#import "DeviceUserProfiles+Handler.h"
#import "DeviceAlarmClock+Handler.h"
#import <QuartzCore/QuartzCore.h>
#import <QuartzCore/CALayer.h>
#import "ScanFilter+Handler.h"
#import <LifesenseBluetooth/LSSleepRecord.h>

typedef enum {
    WorkingStatusFree,
    WorkingStatusSearchDevice,
    WorkingStatusPairDevice,
    WorkingStatusSaveDevice,
}WorkingStatus;

@interface ComIcsciencesHeartRateModuleModule ()<DatabaseManagerDelegate,LSBlePairingDelegate,LSBleDataReceiveDelegate>

@property(nonatomic,strong)LSBLEDeviceManager *lsBleManager;
@property(nonatomic,strong)NSMutableArray *scanResultsArray;
@property(nonatomic)WorkingStatus currentWorkingStatus;
@property(nonatomic,strong)DeviceUser *currentUser;
@property(nonatomic,strong)NSMutableDictionary *dataMap;
@property(nonatomic,strong)NSMutableDictionary *weightDataMap;

@property(nonatomic,strong)NSMutableArray *weightDataList;
@property(nonatomic,strong)NSMutableArray *bloodPressureDataList;

@property(nonatomic,strong)NSArray *deviceDataInfo;

@property(nonatomic,strong)NSMutableDictionary *indexPathMap;
@property(nonatomic,strong)NSMutableArray *pairedDeviceArray;
@property(nonatomic)BOOL isSearching;
@property(nonatomic,strong)UIActivityIndicatorView  *activityIndicator;
@property(nonatomic,strong)UIView *processingView;
@property (nonatomic,strong)UITableViewCell *currentSelectCell;
@property(nonatomic,strong)ScanFilter *currentScanFilter;
@property(nonatomic,strong)NSTimer *updateTextValueTimer;
@property(nonatomic,strong)UITextView *msgTextView;
@property(nonatomic,strong)UILabel *msgLabel;
@property(nonatomic)NSUInteger searchTimeCount;
@property(nonatomic,strong)NSMutableString *deviceDetailsMsg;
@property(nonatomic,strong)LSDatabaseManager *databaseManager;
@property(nonatomic,strong)DeviceUser *currentDeviceUser;
@property(nonatomic,strong)NSMutableArray *deviceUserArray;
@property(nonatomic,strong)UILabel *searchingTipsTitle;
@property(nonatomic,strong)UIActivityIndicatorView  *searchingIndicatorView;
@property(nonatomic)BOOL isPairedSuccess;

@end

@implementation ComIcsciencesHeartRateModuleModule

#pragma mark Internal

// this is generated for your module, please do not change it
-(id)moduleGUID
{
	return @"c6799711-2104-4bde-bdc5-8eecf4ad93d7";
}

// this is generated for your module, please do not change it
-(NSString*)moduleId
{
	return @"com.icsciences.heartRateModule";
}

#pragma mark Lifecycle

-(void)startup
{
	// this method is called when the module is first loaded
	// you *must* call the superclass
    
    self.lsBleManager=[LSBLEDeviceManager defaultLsBleManager];
    self.scanResultsArray=[[NSMutableArray alloc] init];
    
    self.indexPathMap=[[NSMutableDictionary alloc] init];
    self.pairedDeviceArray=[[NSMutableArray alloc] init];
    self.databaseManager=[LSDatabaseManager defaultManager];
    [self.databaseManager createManagedObjectContextWithDocumentName:@"LifesenseBleDatabase"];
    self.databaseManager.databaseDelegate=self;
    
    self.weightDataList=[[NSMutableArray alloc] init];
    self.bloodPressureDataList=[[NSMutableArray alloc] init];
    self.dataMap=[[NSMutableDictionary alloc] init];
    self.weightDataMap=[[NSMutableDictionary alloc] init];
    
    //[self loadDataFromDatabase];
    
	[super startup];
	
	//NSLog(@"[INFO] %@ loaded",self);
}

-(void)shutdown:(id)sender
{
	// this method is called when the module is being unloaded
	// typically this is during shutdown. make sure you don't do too
	// much processing here or the app will be quit forceably
	
	// you *must* call the superclass
	[super shutdown:sender];
}

#pragma mark Cleanup 

-(void)dealloc
{
	// release any resources that have been retained by the module
	[super dealloc];
}

#pragma mark Internal Memory Management

-(void)didReceiveMemoryWarning:(NSNotification*)notification
{
	// optionally release any resources that can be dynamically
	// reloaded once memory is available - such as caches
	[super didReceiveMemoryWarning:notification];
}

#pragma mark Listener Notifications

-(void)_listenerAdded:(NSString *)type count:(int)count
{
	if (count == 1 && [type isEqualToString:@"my_event"])
	{
		// the first (of potentially many) listener is being added 
		// for event named 'my_event'
	}
}

-(void)_listenerRemoved:(NSString *)type count:(int)count
{
	if (count == 0 && [type isEqualToString:@"my_event"])
	{
		// the last listener called for event named 'my_event' has
		// been removed, we can optionally clean up any resources
		// since no body is listening at this point for that event
	}
}

#pragma mark - Private

- (void)logText:(NSString *)text {
    NSLog(text);
}

#pragma mark - LSHardwareConnectorDelegate

/*
- (PedometerUserDownLoadInfo *)hardwareConnectorGetPedometerDownloadInfoForSensor:(LSHardwareSensor *)sensor {
    PedometerUserDownLoadInfo *info = [PedometerUserDownLoadInfo new];
    info.height = heightVar; //METERS I THINK!
    info.stride = 0.78;
    info.weekStart = 1;
    info.weekTargetCalories = 0;
    info.weekTargetDistance = 0;
    info.weekTargetExerciseAmount = 2;
    info.weekTargetSteps = 14000;
    info.weight = weightVar; //KILOGRAMS I THINK!
    
    [self logText:@"USERRRRRRRRRRRRRRRRRRR INFOOOOOOOOOOOOOOOOO"];
    [self logText:[NSString stringWithFormat:@"height %f",heightVar]];
    [self logText:[NSString stringWithFormat:@"weight %f",weightVar]];
    
    //dispatch_async(dispatch_get_main_queue(), ^{
        //[self logText:@"配置计步器下载信息"];
    //});
    
    return info;
}


-(void)pairConnectorDiscoveredPairingSensor:(LSHardwareSensor*)sensor {
    NSLog(@"hardwareConnectorDiscoveredPairingSensor");
    [self logText:@"Found that pairing mode devices, automatic pairing"];
    
    [self logText:[NSString stringWithFormat:@"SENSOR NAME %@",sensor.sensorName]];
    
    NSString *result = [NSString stringWithFormat:@"UNKNOWN"];
    
    if ([sensor.sensorName isEqualToString:@"405A0"]) {
        result = [NSString stringWithFormat:@"TRACKER"];
    }
    else if ([sensor.sensorName isEqualToString:@"12690"]) {
        result = [NSString stringWithFormat:@"SCALE"];
    }
    else if ([sensor.sensorName isEqualToString:@"1018B"]) {
        result = [NSString stringWithFormat:@"ARMCUFF"];
    }
    else if ([sensor.sensorName isEqualToString:@"810A0"]) {
        result = [NSString stringWithFormat:@"WRISTCUFF"];
    }
    //sensor.sensorName = result;
    //result = sensor.sensorName;
    
    NSDictionary *event = [NSDictionary dictionaryWithObjectsAndKeys:result,@"result",nil];
    [self _fireEventToListener:@"sensorPaired" withObject:event listener:pairedCallback thisObject:nil];
    
    //auto Pair
    [[LSHardwareConnector shareConnector] pairWithHardwareSensor:sensor];
    
}

-(void)pairConnectorPairedSensor:(LSHardwareSensor*)sensor withState:(BOOL)state {
    [self logText:@"The pairing is successful"];
    NSLog(@"hardwareConnectorPairedSensor");
    
    NSString *result = sensor.sensorName;
    
    NSDictionary *event = [NSDictionary dictionaryWithObjectsAndKeys:result,@"result",nil];
    [self _fireEventToListener:@"devicePaired" withObject:event listener:pairedCallback thisObject:nil];
}
*/

/**
 *  接收体重秤数据回调
 *
 *  @param data 体重秤数据
 */
/*
-(void)hardwareConnectorReceiveWeightMeasurementData:(WeightData*)data {
    [self logText:@"\n收到体重秤数据"];
    [self logText:[NSString stringWithFormat:@"weight %f",(float)data.weight]];
    [self logText:[NSString stringWithFormat:@"pbf%f",data.pbf]];
    NSLog(@"hardwareConnectorPairedSensor");
    
    NSString *weightString = [NSString stringWithFormat:@"%f",data.weight];
    NSDictionary *event = [NSDictionary dictionaryWithObjectsAndKeys:weightString,@"weight",nil];
    [self _fireEventToListener:@"success" withObject:event listener:successCallback thisObject:nil];
    
}
*/

/**
 *  接收计步器数据回调
 *
 *  @param data 计步器数据
 */
/*
-(void)hardwareConnectorReceivePedometerMeasurementData:(PedometerData*)data {
     [self logText:@"\n收到计步器数据"];
     [self logText:[NSString stringWithFormat:@"walkSteps %ld",(long)data.walkSteps]];
     [self logText:[NSString stringWithFormat:@"runSteps %ld",(long)data.runSteps]];
     [self logText:[NSString stringWithFormat:@"distance %ld",(long)data.distance]];
     [self logText:[NSString stringWithFormat:@"dategoeshere %@",data.date]];
     
     NSString *walkSteps = [NSString stringWithFormat:@"%ld",(long)data.walkSteps];
     NSString *runSteps = [NSString stringWithFormat:@"%ld",(long)data.runSteps];
     NSString *distanceVar = [NSString stringWithFormat:@"%ld",(long)data.distance];
     NSString *caloriesVar = [NSString stringWithFormat:@"%ld",(long)data.calories];
     NSString *date = [NSString stringWithFormat:@"%@",data.date];
     NSString *battery = [NSString stringWithFormat:@"%ld",(long)data.battery];
     NSString *sleepStatus = [NSString stringWithFormat:@"%ld",(long)data.sleepStatus];
     NSString *intensityLevel = [NSString stringWithFormat:@"%ld",(long)data.intensityLevel];
     
     NSDictionary *event = [NSDictionary dictionaryWithObjectsAndKeys:walkSteps,@"walking",runSteps,@"running",date,@"date",distanceVar,@"distance",caloriesVar,@"calories",battery,@"battery",intensityLevel,@"intensityLevel",intensityLevel,@"intensityLevel",sleepStatus,@"sleepStatus",nil];
     [self _fireEventToListener:@"success" withObject:event listener:successCallback thisObject:nil];
 }
*/

/**
 *  接收血压计数据回调
 *
 *  @param data 血压计数据
 */
/*
-(void)hardwareConnectorReceiveBloodPressureMeasurementData:(BloodPressureData *)data {
    [self logText:@"\nData received"];
    [self logText:[NSString stringWithFormat:@"systolic %ld",(long)data.systolic]];
    [self logText:[NSString stringWithFormat:@"diastolic %ld",(long)data.diastolic]];
    [self logText:[NSString stringWithFormat:@"pluseRate %ld",(long)data.pluseRate]];
    
    NSString *systolic = [NSString stringWithFormat:@"%ld",(long)data.systolic];
    NSString *diastolic = [NSString stringWithFormat:@"%ld",(long)data.diastolic];
    NSString *pluseRate = [NSString stringWithFormat:@"%ld",(long)data.pluseRate];
    
    //NSArray *event = [NSArray arrayWithObjects:(long)data.systolic,(long)data.diastolic, (long)data.pluseRate, nil];
    //float number = [[arrayOfNumbers objectAtIndex:0] floatValue];
    
    NSDictionary *event = [NSDictionary dictionaryWithObjectsAndKeys:systolic,@"systolic",diastolic,@"diastolic",pluseRate,@"pluseRate",nil];
    [self _fireEventToListener:@"success" withObject:event listener:successCallback thisObject:nil];
}
*/

/**
 *  接收厨房称数据回调
 *
 *  @param data 厨房称数据
 */
/*
-(void)hardwareConnectorReceiveKitchenScaleMeasurementData:(KitchenScaleData*)data{
    [self logText:@"\ntest1"];
    
}
*/

/**
 *  接收身高数据回调
 *
 *  @param data 身高数据
 */
/*
-(void)hardwareConnectorReceiveHeightMeasurementData:(HeightData*)data {
    [self logText:@"\ntest2"];
}
*/

/**
 *  接收通用体重秤数据回调
 *
 *  @param data 体重秤数据
 */
/*
-(void)hardwareConnectorReceiveGeneralWeightMeasurementData:(WeightData*)data {
    [self logText:@"\ntest3"];
    
    NSString *weightString = [NSString stringWithFormat:@"%f",(float)data.weight];
    NSDictionary *event = [NSDictionary dictionaryWithObjectsAndKeys:weightString,@"weight",nil];
    [self _fireEventToListener:@"success" withObject:event listener:successCallback thisObject:nil];
}
*/

#pragma mark - DatabaseManagerDelegate

-(void)databaseManagerDidCreatedManagedObjectContext:(NSManagedObjectContext *)managedObjectContext
{
    NSPredicate *queryPredicate=[NSPredicate predicateWithFormat:@"userID = %@",DEFAULT_USER_ID];
    NSArray *deviceUser=[self.databaseManager allObjectForEntityForName:@"DeviceUser"
                                                              predicate:queryPredicate];
    
    if([deviceUser count])
    {
        self.currentUser=[deviceUser lastObject];
        //NSLog(@"my user info %@",[self.currentUser description]);
        //for test
        /*
         LSDeviceInfo *lsDevice=[[LSDeviceInfo alloc] init];
         lsDevice.deviceName=@"405A0";
         lsDevice.broadcastId=@"898989ab";
         lsDevice.deviceType=LS_PEDOMETER;
         lsDevice.password=@"ioioio";
         lsDevice.deviceId=@"90909099";
         
         BleDevice *device=[BleDevice bindDeviceWithUserId:DEFAULT_USER_ID deviceInfo:lsDevice inManagedObjectContext:managedObjectContext];
         */
    }
    else
    {
        //NSLog(@"no device user and user profiles,create.......");
        NSMutableDictionary *userInfo=[[NSMutableDictionary alloc] init];
        [userInfo setValue:DEFAULT_USER_ID forKeyPath:DEVICE_USER_KEY_ID];
        [userInfo setValue:@"sky" forKeyPath:DEVICE_USER_KEY_NAME];
        //1 for male,2 for female
        [userInfo setValue:@"Male" forKeyPath:DEVICE_USER_KEY_GENDER];
        [userInfo setValue:@"1.75" forKeyPath:DEVICE_USER_KEY_HEIGHT];
        [userInfo setValue:@"62" forKeyPath:DEVICE_USER_KEY_WEIGHT];
        [userInfo setValue:@"2" forKeyPath:DEVICE_USER_KEY_ATHLETELEVEL];
        [userInfo setValue:@"1989-09-01" forKeyPath:DEVICE_USER_KEY_BIRTHDAY];
        
        self.currentUser=[DeviceUser createDeviceUserWithUserInfo:userInfo
                                           inManagedObjectContext:managedObjectContext];
        
        NSMutableDictionary *userProfiles=[[NSMutableDictionary alloc] init];
        [userProfiles setValue:DEFAULT_USER_ID forKeyPath:KEY_USER_PROFILES_ID];
        [userProfiles setValue:@"Kg" forKeyPath:KEY_USER_PROFILES_WEIGHT_UNIT];
        //1 for male,2 for female
        [userProfiles setValue:@"65" forKeyPath:KEY_USER_PROFILES_WEIGHT_TARGET];
        [userProfiles setValue:@"Sunday" forKeyPath:KEY_USER_PROFILES_WEEK_START];
        [userProfiles setValue:@"24" forKeyPath:KEY_USER_PROFILES_HOUR_FORMAT];
        [userProfiles setValue:@"Kilometer" forKeyPath:KEY_USER_PROFILES_DISTANCE_UNIT];
        [userProfiles setValue:@"10000" forKeyPath:KEY_USER_PROFILES_WEEK_TARGET_STEPS];
        
        [userProfiles setValue:@"1" forKeyPath:KEY_USER_PROFILES_ALARM_CLOCK_ID];
        [userProfiles setValue:@"1" forKeyPath:KEY_USER_PROFILES_SCAN_FILTER_ID];
        
        [DeviceUserProfiles createUserProfilesWithInfo:userProfiles inManagedObjectContext:managedObjectContext];
        
        NSMutableDictionary *alarmClock=[[NSMutableDictionary alloc] init];
        [alarmClock setValue:@"1" forKeyPath:KEY_ALARM_CLOCK_ID];
        [alarmClock setValue:[NSDate date] forKeyPath:KEY_ALARM_CLOCK_TIME];
        [alarmClock setValue:@"127" forKeyPath:KEY_ALARM_CLOCK_DAY];//for all day
        
        NSNumber *defaultValue=[NSNumber numberWithBool:YES];
        [alarmClock setValue:defaultValue forKeyPath:KEY_ALARM_CLOCK_MONDAY];
        [alarmClock setValue:defaultValue forKeyPath:KEY_ALARM_CLOCK_TUESDAY];
        [alarmClock setValue:defaultValue forKeyPath:KEY_ALARM_CLOCK_WEDNESDAY];
        [alarmClock setValue:defaultValue forKeyPath:KEY_ALARM_CLOCK_THURSDAY];
        [alarmClock setValue:defaultValue forKeyPath:KEY_ALARM_CLOCK_FRIDAY];
        [alarmClock setValue:defaultValue forKeyPath:KEY_ALARM_CLOCK_SATURDAY];
        [alarmClock setValue:defaultValue forKeyPath:KEY_ALARM_CLOCK_SUNDAY];
        
        [DeviceAlarmClock createAlarmClockWithInfo:alarmClock inManagedObjectContext:managedObjectContext];
        
        NSMutableDictionary *scanFilterInfo=[[NSMutableDictionary alloc] init];
        [scanFilterInfo setValue:@"1" forKeyPath:KEY_SCAN_FILTER_ID];
        [scanFilterInfo setValue:@"All" forKeyPath:KEY_SCAN_FILTER_BROADCAST];
        
        NSNumber *enable=[NSNumber numberWithBool:YES];
        [scanFilterInfo setValue:enable forKeyPath:KEY_SCAN_FILTER_FAT_SCALE];
        [scanFilterInfo setValue:enable forKeyPath:KEY_SCAN_FILTER_HEIGHT];
        [scanFilterInfo setValue:enable forKeyPath:KEY_SCAN_FILTER_KITCHEN];
        [scanFilterInfo setValue:enable forKeyPath:KEY_SCAN_FILTER_WEIGHT_SCALE];
        [scanFilterInfo setValue:enable forKeyPath:KEY_SCAN_FILTER_PEDOMETER];
        [scanFilterInfo setValue:enable forKeyPath:KEY_SCAN_FILTER_BLOOD_PRESSURE];
        
        [ScanFilter createScanFilterWithInfo:scanFilterInfo inManagedObjectContext:managedObjectContext];
        
    }
    
    [self loadDataFromDatabase];
}

#pragma Public APIs

-(void)loadDataFromDatabase
{
    [self.pairedDeviceArray removeAllObjects];
    
    NSArray *deviceArray=[self.databaseManager allObjectForEntityForName:@"BleDevice" predicate:nil];
    
    //NSLog(@"count of deivce is %ld",(unsigned long)[deviceArray count]);
    
    NSArray *enableScanDeviceTypes=[self enableScanAllDevice];
    BroadcastType enableScanBroadcast=[self getEnableScanBroadcastType];
    
    if([deviceArray count])
    {
        for (BleDevice *device in deviceArray)
        {
            //NSLog(@"get device info from database %@",[device description]);
            [self.pairedDeviceArray addObject:device];
            [self.lsBleManager addMeasureDevice:[DataFormatConverter convertedToLSDeviceInfo:device]];
            LSDeviceType deviceType=[DataFormatConverter stringToDeviceType:device.deviceType];
        }
        
        //[self.tableView reloadData];
        [self.lsBleManager startDataReceiveService:self];
    }
    else{
        self.currentWorkingStatus=WorkingStatusSearchDevice;
        [self.lsBleManager searchLsBleDevice:enableScanDeviceTypes ofBroadcastType:enableScanBroadcast searchCompletion:^(LSDeviceInfo *lsDevice)
         {
             NSLog(@"SEARCHING");
             if(lsDevice)
             {
                 //NSLog(@"IS DEVICE");
                 if(![self.scanResultsArray containsObject:lsDevice])
                 {
                     //NSLog(@"ADDED");
                     [self.scanResultsArray addObject:lsDevice];
                     
                     if(lsDevice.preparePair)
                     {
                         //NSLog(@"PREPARE PAIR");
                         self.currentWorkingStatus=WorkingStatusPairDevice;
                         [self.lsBleManager stopSearch];
                         [self.lsBleManager pairWithLsDeviceInfo:lsDevice pairedDelegate:self];
                     }
                 }
             }
         }];
    }
    
}

-(DeviceUser *)currentDeviceUser
{
    if(!_currentDeviceUser)
    {
        _currentDeviceUser=[[self.databaseManager allObjectForEntityForName:@"DeviceUser" predicate:nil] lastObject];
    }
    return _currentDeviceUser;
}

-(LSDatabaseManager *)databaseManager
{
    if(!_databaseManager)
    {
        _databaseManager=[LSDatabaseManager defaultManager];
    }
    return _databaseManager;
}

-(NSArray *)getEnableScanDeviceTypes
{
    NSMutableArray *enableTypes=[[NSMutableArray alloc] init];
    
    [enableTypes addObject:@(LS_SPHYGMOMETER)];
    [enableTypes addObject:@(LS_FAT_SCALE)];
    [enableTypes addObject:@(LS_HEIGHT_MIRIAM)];
    [enableTypes addObject:@(LS_KITCHEN_SCALE)];
    [enableTypes addObject:@(LS_PEDOMETER)];
    [enableTypes addObject:@(LS_WEIGHT_SCALE)];
    
    //NSLog(@"enable scan device type %@",enableTypes);
    return enableTypes;
}

-(BroadcastType)getEnableScanBroadcastType
{
    return BROADCAST_TYPE_ALL;
    //return BROADCAST_TYPE_PAIR;
}

-(NSArray *)enableScanAllDevice
{
    return  @[@(LS_KITCHEN_SCALE),@(LS_PEDOMETER),@(LS_FAT_SCALE),@(LS_WEIGHT_SCALE),@(LS_SPHYGMOMETER),@(LS_HEIGHT_MIRIAM)];
}



-(void)startScanning:(id)args
{
    ENSURE_UI_THREAD_1_ARG(args);
    ENSURE_SINGLE_ARG(args,NSDictionary);
    id success = [args objectForKey:@"success"];
    id cancel = [args objectForKey:@"cancel"];
    id devicePaired = [args objectForKey:@"devicePaired"];
    RELEASE_TO_NIL(successCallback);
    RELEASE_TO_NIL(cancelCallback);
    RELEASE_TO_NIL(pairedCallback);
    successCallback = [success retain];
    cancelCallback = [cancel retain];
    pairedCallback = [devicePaired retain];
    
    //self.currentWorkingStatus=WorkingStatusFree;
    //NSArray *enableScanDeviceTypes=[self getEnableScanDeviceTypes];
    //NSArray *enableScanDeviceTypes=[self enableScanAllDevice];
    //BroadcastType enableScanBroadcast=[self getEnableScanBroadcastType];
    
    /*[[LSHardwareConnector shareConnector] startScanningWithDelegate:self withEnalbeSensorTypes:@[[NSNumber numberWithInt:LS_SENSOR_TYPE_PEDOMETER],[NSNumber numberWithInt:LS_SENSOR_TYPE_WEIGHT_SCALE],[NSNumber numberWithInt:LS_SENSOR_TYPE_GENERAL_WEIGHT_SCALE],[NSNumber numberWithInt:LS_SENSOR_TYPE_BLOODPRESSURE]]];*/
    
    /*if(self.pairedDeviceArray.count) {
        NSLog(@"start auto sync data JIM");
        [self.lsBleManager startDataReceiveService:self];
    }
    else{
        self.currentWorkingStatus=WorkingStatusSearchDevice;
        [self.lsBleManager searchLsBleDevice:enableScanDeviceTypes ofBroadcastType:enableScanBroadcast searchCompletion:^(LSDeviceInfo *lsDevice)
         {
             NSLog(@"SEARCHING");
             if(lsDevice)
             {
                 NSLog(@"IS DEVICE");
                 if(![self.scanResultsArray containsObject:lsDevice])
                 {
                     NSLog(@"ADDED");
                     [self.scanResultsArray addObject:lsDevice];
                     
                     if(lsDevice.preparePair)
                     {
                         NSLog(@"PREPARE PAIR");
                         self.currentWorkingStatus=WorkingStatusPairDevice;
                         [self.lsBleManager stopSearch];
                         [self.lsBleManager pairWithLsDeviceInfo:lsDevice pairedDelegate:self];
                     }
                 }
             }
        }];
    }*/
}

/*
-(void)startScanningForScale:(id)args
{
    ENSURE_UI_THREAD_1_ARG(args);
    ENSURE_SINGLE_ARG(args,NSDictionary);
    id success = [args objectForKey:@"success"];
    id cancel = [args objectForKey:@"cancel"];
    id devicePaired = [args objectForKey:@"devicePaired"];
    RELEASE_TO_NIL(successCallback);
    RELEASE_TO_NIL(cancelCallback);
    RELEASE_TO_NIL(pairedCallback);
    successCallback = [success retain];
    cancelCallback = [cancel retain];
    pairedCallback = [devicePaired retain];
    
    NSString *result = [NSString stringWithFormat:@"Scanning for device!!!"];
	NSLog(@"[HEARTRATEMODULE] %@", result);
    [[LSHardwareConnector shareConnector] startScanningWithDelegate:self withEnalbeSensorTypes:@[[NSNumber numberWithInt:LS_SENSOR_TYPE_WEIGHT_SCALE],[NSNumber numberWithInt:LS_SENSOR_TYPE_GENERAL_WEIGHT_SCALE]]];
}


-(void)startScanningForFitnessTracker:(id)args
{
    ENSURE_UI_THREAD_1_ARG(args);
    ENSURE_SINGLE_ARG(args,NSDictionary);
    id success = [args objectForKey:@"success"];
    id cancel = [args objectForKey:@"cancel"];
    id devicePaired = [args objectForKey:@"devicePaired"];
    RELEASE_TO_NIL(successCallback);
    RELEASE_TO_NIL(cancelCallback);
    RELEASE_TO_NIL(pairedCallback);
    successCallback = [success retain];
    cancelCallback = [cancel retain];
    pairedCallback = [devicePaired retain];
    
    NSString *result = [NSString stringWithFormat:@"Scanning for device!!!"];
    NSLog(@"[FITNESSTRACKER] %@", result);
    [[LSHardwareConnector shareConnector] startScanningWithDelegate:self withEnalbeSensorTypes:@[[NSNumber numberWithInt:LS_SENSOR_TYPE_PEDOMETER]]];
}

-(NSNumber*)checkForPairedDevices:(id)args
{

    NSInteger i = 0;
    NSArray *pairedDevices = [[LSHardwareConnector shareConnector] pairedSensors];
    [self logText:[NSString stringWithFormat:@"Paired Count %lu",(unsigned long)pairedDevices.count]];
    for (LSHardwareSensor *sensor in pairedDevices) {
        [self logText:[NSString stringWithFormat:@"Paired DeviceName %@",sensor.sensorName]];
        i = 1;
    }
    
    return NUMINT(i);
}

-(void)removeDevicePairing:(id)args
{
    NSArray *pairedDevices = [[LSHardwareConnector shareConnector] pairedSensors];
    for (LSHardwareSensor *sensor in pairedDevices) {
        [self logText:[NSString stringWithFormat:@"Paired DeviceName %@",sensor.sensorName]];
        [[LSHardwareConnector shareConnector] forgetPairedSensorWithSensor:sensor];
    }
}
*/

-(void)removeDevicePairing:(id)args
{
    BleDevice *deleteItem=(BleDevice *)self.pairedDeviceArray[0];
    [self.lsBleManager deleteMeasureDevice:deleteItem.broadcastID];
    [self.lsBleManager stopDataReceiveService];
    [self.pairedDeviceArray removeObject:deleteItem];
    [self.databaseManager.managedContext deleteObject:deleteItem];
    [self loadDataFromDatabase];
}

-(void)setUserInfo:(id)args
{
    //NSLog(@"TESTTTTTTTTTTTTTTTTTTTTT");

    enum Args {
        heightVarArg = 0,
        weightVarArg = 1
    };
    
    // Use the TiUtils methods to get the values from the arguments
    heightVar = [TiUtils floatValue:[args objectAtIndex:heightVarArg] def:0.0];
    weightVar = [TiUtils floatValue:[args objectAtIndex:weightVarArg] def:0.0];

    NSLog(@"[SETUSERINFO]", heightVar, weightVar);
}

-(void)bleManagerDidPairedResults:(LSDeviceInfo *)lsDevice pairStatus:(int)pairStatus
{
    UIAlertView *pairAlertView=nil;
    if(lsDevice && pairStatus==1)
    {
        //NSLog(@"PAIRED");
        
        NSString *result = [NSString stringWithFormat:@"UNKNOWN"];
        
        if ([lsDevice.deviceName isEqualToString:@"405A0"]) {
            result = [NSString stringWithFormat:@"TRACKER"];
        }
        else if ([lsDevice.deviceName isEqualToString:@"12690"]) {
            result = [NSString stringWithFormat:@"SCALE"];
        }
        else if ([lsDevice.deviceName isEqualToString:@"1018B"]) {
            result = [NSString stringWithFormat:@"ARMCUFF"];
        }
        else if ([lsDevice.deviceName isEqualToString:@"810A0"]) {
            result = [NSString stringWithFormat:@"WRISTCUFF"];
        }
        
        NSString *userId=self.currentDeviceUser.userID;
        
        [BleDevice bindDeviceWithUserId:userId
                             deviceInfo:lsDevice
                 inManagedObjectContext:self.databaseManager.managedContext];
        
        //self.currentWorkingStatus=WorkingStatusFree;
        
        NSDictionary *event = [NSDictionary dictionaryWithObjectsAndKeys:result,@"result",nil];
        [self _fireEventToListener:@"devicePaired" withObject:event listener:pairedCallback thisObject:nil];
        
        [self loadDataFromDatabase];
    }
    else
    {
        //NSLog(@"NOT PAIRED");
        
        //self.currentWorkingStatus=WorkingStatusFree;
        
        self.isPairedSuccess=false;
        /*[self hideProcessingView];
        pairAlertView=[[UIAlertView alloc] initWithTitle:@"Paired Results" message:@"Failed to paired device,please try again" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil  , nil];
        */
        
    }
}

-(void)bleManagerDidReceiveSphygmometerMeasuredData:(LSSphygmometerData *)data
{
    //NSLog(@"DID RECEIVE DATA");
    if (data)
    {
        [self.bloodPressureDataList addObject:data];
        
        NSMutableArray *tempBpDatas=[self findMeasuredDataArrayWithBroadcastID:data.broadcastId];
        [tempBpDatas addObject:data];
        [self.dataMap setValue:tempBpDatas forKey:data.broadcastId];
        
        //[self updateRecordNumber:data.broadcastId count:tempBpDatas.count text:nil unit:nil];
        self.deviceDataInfo=[self getCurrentMeasuredData:data.broadcastId];
        
        LSSphygmometerData *bpData=self.deviceDataInfo.lastObject;
        NSString *systolicStr=[self doubleValueWithTwoDecimalFormat:bpData.systolic];
        NSString *diastolicStr=[self doubleValueWithTwoDecimalFormat:bpData.diastolic];
        NSString *pluseRateStr=[self doubleValueWithTwoDecimalFormat:bpData.pluseRate];
        
        //NSArray *event = [NSArray arrayWithObjects:(long)data.systolic,(long)data.diastolic, (long)data.pluseRate, nil];
        //float number = [[arrayOfNumbers objectAtIndex:0] floatValue];
        
        NSDictionary *event = [NSDictionary dictionaryWithObjectsAndKeys:systolicStr,@"systolic",diastolicStr,@"diastolic",pluseRateStr,@"pluseRate",nil];
        [self _fireEventToListener:@"success" withObject:event listener:successCallback thisObject:nil];
    }
}

-(NSMutableArray *)findMeasuredDataArrayWithBroadcastID:(NSString *)broadcastId
{
    if(broadcastId.length)
    {
        id map=[self.dataMap valueForKey:broadcastId];
        if(map==nil)
        {
            NSMutableArray *tempDataMap=[[NSMutableArray alloc] init];
            [self.dataMap setValue:tempDataMap forKey:broadcastId];
            return tempDataMap;
        }
        else return map;
    }
    else return nil;
}

-(NSArray *)getCurrentMeasuredData:(NSString *)broadcastId
{
    if(broadcastId.length)
    {
        return [self.dataMap valueForKey:broadcastId];
    }
    else return nil;
}

-(NSString *)doubleValueWithTwoDecimalFormat:(double)weightValue
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
