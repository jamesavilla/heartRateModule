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
	[super startup];
	
	NSLog(@"[INFO] %@ loaded",self);
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


/**
 *  接收体重秤数据回调
 *
 *  @param data 体重秤数据
 */
-(void)hardwareConnectorReceiveWeightMeasurementData:(WeightData*)data {
    [self logText:@"\n收到体重秤数据"];
    [self logText:[NSString stringWithFormat:@"weight %f",(float)data.weight]];
    [self logText:[NSString stringWithFormat:@"pbf%f",data.pbf]];
    NSLog(@"hardwareConnectorPairedSensor");
    
    NSString *weightString = [NSString stringWithFormat:@"%f",data.weight];
    NSDictionary *event = [NSDictionary dictionaryWithObjectsAndKeys:weightString,@"weight",nil];
    [self _fireEventToListener:@"success" withObject:event listener:successCallback thisObject:nil];
    
}

/**
 *  接收计步器数据回调
 *
 *  @param data 计步器数据
 */-(void)hardwareConnectorReceivePedometerMeasurementData:(PedometerData*)data {
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

/**
 *  接收血压计数据回调
 *
 *  @param data 血压计数据
 */
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

/**
 *  接收厨房称数据回调
 *
 *  @param data 厨房称数据
 */
-(void)hardwareConnectorReceiveKitchenScaleMeasurementData:(KitchenScaleData*)data{
    [self logText:@"\ntest1"];
    
}

/**
 *  接收身高数据回调
 *
 *  @param data 身高数据
 */
-(void)hardwareConnectorReceiveHeightMeasurementData:(HeightData*)data {
    [self logText:@"\ntest2"];
}

/**
 *  接收通用体重秤数据回调
 *
 *  @param data 体重秤数据
 */
-(void)hardwareConnectorReceiveGeneralWeightMeasurementData:(WeightData*)data {
    [self logText:@"\ntest3"];
    
    NSString *weightString = [NSString stringWithFormat:@"%f",(float)data.weight];
    NSDictionary *event = [NSDictionary dictionaryWithObjectsAndKeys:weightString,@"weight",nil];
    [self _fireEventToListener:@"success" withObject:event listener:successCallback thisObject:nil];
}

#pragma Public APIs

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
    
    NSString *result = [NSString stringWithFormat:@"Scanning for device!!!"];
	NSLog(@"[HEARTRATEMODULE] %@", result);
    
    [[LSHardwareConnector shareConnector] startScanningWithDelegate:self withEnalbeSensorTypes:@[[NSNumber numberWithInt:LS_SENSOR_TYPE_PEDOMETER],[NSNumber numberWithInt:LS_SENSOR_TYPE_WEIGHT_SCALE],[NSNumber numberWithInt:LS_SENSOR_TYPE_GENERAL_WEIGHT_SCALE],[NSNumber numberWithInt:LS_SENSOR_TYPE_BLOODPRESSURE]]];
}

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

-(void)setUserInfo:(id)args
{
    NSLog(@"TESTTTTTTTTTTTTTTTTTTTTT");

    enum Args {
        heightVarArg = 0,
        weightVarArg = 1
    };
    
    // Use the TiUtils methods to get the values from the arguments
    heightVar = [TiUtils floatValue:[args objectAtIndex:heightVarArg] def:0.0];
    weightVar = [TiUtils floatValue:[args objectAtIndex:weightVarArg] def:0.0];

    NSLog(@"[SETUSERINFO]", heightVar, weightVar);
}

@end
