/**
 * Your Copyright Here
 *
 * Appcelerator Titanium is Copyright (c) 2009-2010 by Appcelerator, Inc.
 * and licensed under the Apache Public License (version 2)
 */
#import "TiModule.h"
#import <UIKit/UIKit.h>
#import <LifesenseBluetooth/LSBLEDeviceManager.h>

#define DEFAULT_USER_ID @"10000"

@interface ComIcsciencesHeartRateModuleModule : TiModule <LSBlePairingDelegate>
{
    KrollCallback *successCallback;
    KrollCallback *cancelCallback;
    KrollCallback *pairedCallback;
    
    float heightVar;
    float weightVar;
    
}

@end
