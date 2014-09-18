/**
 * Your Copyright Here
 *
 * Appcelerator Titanium is Copyright (c) 2009-2010 by Appcelerator, Inc.
 * and licensed under the Apache Public License (version 2)
 */
#import "TiModule.h"
#import <UIKit/UIKit.h>
#import <LSBLE__A2/LSBLE_A2.h>

@interface ComIcsciencesHeartRateModuleModule : TiModule <LSHardwareConnectorDelegate>
{
    KrollCallback *successCallback;
    KrollCallback *cancelCallback;
    KrollCallback *pairedCallback;
}

@end
