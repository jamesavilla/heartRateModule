//
//  DatabaseManagerDelegate.h
//  LSBluetooth-Demo
//
//  Created by lifesense on 15/8/20.
//  Copyright (c) 2015年 Lifesense. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@protocol DatabaseManagerDelegate <NSObject>


-(void)databaseManagerDidCreatedManagedObjectContext:(NSManagedObjectContext *)managedObjectContext;
@end
