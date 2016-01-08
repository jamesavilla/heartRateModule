//
//  LSDatabaseManager.m
//  CoreDataApp
//
//  Created by lifesense on 14-7-23.
//  Copyright (c) 2014年 lifesense. All rights reserved.
//

#import "LSDatabaseManager.h"
#import <UIKit/UIManagedDocument.h>

@interface LSDatabaseManager()

@property(nonatomic,strong) UIManagedDocument *managedDocument;
@property(nonatomic,readwrite)NSManagedObjectContext *managedContext;
@end

@implementation LSDatabaseManager


-(instancetype)init
{
    self=[super init];
    return self;
}

#pragma mark - public api

+(instancetype)defaultManager
{
    static LSDatabaseManager *shareManager=nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate,^{
        shareManager=[[LSDatabaseManager alloc] init];
    });
    return shareManager;
    
}

-(NSManagedObjectContext *)createManagedObjectContextWithDocumentName:(NSString *)documentName
{
    if(documentName.length)
    {
       return  [self getManagedDocumentContext:documentName];
    }
    else
    {
        //用默认值进行UIManagedDocument初始化
       return  [self getManagedDocumentContext:@"LifesenseAppDatabase"];
    }
}

-(void)manuallySave
{
    [self debugMessage:@"execute manually save action"];
    [self.managedContext save:nil];
}

-(NSManagedObject *)objectForEntityForName:(NSString *)entityName predicate:(NSPredicate *)predicate
{
    NSManagedObject *obj=nil;
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:entityName];
    request.predicate = predicate;
 
    NSError *error = nil;
    NSArray *matches = [self.managedContext executeFetchRequest:request error:&error];
    
    if (!matches || ([matches count] > 1))
    {
        // handle error
    }
    else if ([matches count] == 0)
    {
        NSLog(@"no device.....");
        
    }
    else
    {
        obj =[matches lastObject];
    }

    return obj;
}

//查询某一张表中的所有记录
-(NSArray *)allObjectForEntityForName:(NSString *)entityName
                            predicate:(NSPredicate *)predicate
{
    /* Create the fetch request first */
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:entityName];
    request.predicate=predicate;
     NSError *requestError = nil;
    return [self.managedContext executeFetchRequest:request error:&requestError];

}



//thread safe access to an NSManagedObjectContext
-(void)test
{
    [self.managedContext performBlock:^{
        //数据库操作
    }];
}

-(void)deleteAllObject
{
    /* Create the fetch request first */
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]
                                    initWithEntityName:@"LSBlePeripheral"];
    NSError *requestError = nil;
    /* And execute the fetch request on the context */
    NSArray *accounts =[self.managedContext executeFetchRequest:fetchRequest error:&requestError];
    /* Make sure we get the array */
    if ([accounts count] > 0)
    {
        /* Go through the account array one by one */
//        for (LSBlePeripheral *thisAccount in accounts)
//        {
//            //deleteObject
//            [self.managedContext deleteObject:thisAccount];
//            
//            NSError *savingError = nil;
//            if ([self.managedContext save:&savingError])
//            {
//                NSLog(@"Successfully deleted the account in the array.");
//            }
//            else
//            {
//                NSLog(@"Failed to delete the account in the array.");
//            }
//            
//        }
    }
    
}

-(void)removeAllPairedDevice
{
    for(id device in [self getAllPairedDevice])
    {
//        if([device isKindOfClass:[LSBlePeripheral class]])
//        {
//            LSBlePeripheral *del=(LSBlePeripheral *)device;
//            [self.managedContext delete:del];
//        }
        
    }
}



#pragma mark -private methods init NSManagedDocument

-(NSArray *)getAllPairedDevice
{
    /* Create the fetch request first */
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]
                                    initWithEntityName:@"LSBlePeripheral"];
    NSError *requestError = nil;
    /* And execute the fetch request on the context */
    NSArray *accounts =[self.managedContext executeFetchRequest:fetchRequest error:&requestError];
    /* Make sure we get the array */
    if ([accounts count] > 0)
    {
        return accounts;
    }
    else
    {
        NSLog(@"Could not find any Account entities in the context.");
        return nil;
    }
    
}



#pragma mark - initManagedDocument

-(void)debugMessage:(NSString *)msg
{
    NSLog(@"DB-message:%@",msg);
}

-(NSManagedObjectContext *)getManagedDocumentContext:(NSString *)documentName
{
    NSFileManager *fileManager=[NSFileManager defaultManager];
    NSURL *documentDirectory=[[fileManager URLsForDirectory:NSDocumentDirectory
                                                  inDomains:NSUserDomainMask] firstObject];
    NSURL *url=[documentDirectory URLByAppendingPathComponent:documentName];
     _managedContext=self.managedDocument.managedObjectContext;
    //UIManagedDocuments auto save themselves,auto close,asynchronous
    self.managedDocument=[[UIManagedDocument alloc] initWithFileURL:url];
    
    BOOL fileExists=[fileManager fileExistsAtPath:[url path]];
    __block NSString *message=nil;
    if (fileExists)
    {
        [self.managedDocument openWithCompletionHandler:^(BOOL success)
         {
             if (success)
             {
                 [self debugMessage:@"successfully open document...."];
                 [self documentIsReadly];
             }
             else
             {
                 message=[NSString stringWithFormat:@"couldn't open document with path %@",url];
                 [self debugMessage:message];
             }
         }];
    }
    else
    {
        [self.managedDocument saveToURL:url
                       forSaveOperation:UIDocumentSaveForCreating
                      completionHandler:^(BOOL success)
         {
             if (success)
             {
                 [self debugMessage:@"successfully create document...."];
                 [self documentIsReadly];
             }
             else
             {
                 message=[NSString stringWithFormat:@"couldn't create document with path %@",url];
                 [self debugMessage:message];
             }
         }];
    }
    
    return _managedContext;
}


-(void)documentIsReadly
{
    if (self.managedDocument.documentState==UIDocumentStateNormal)
    {
        [self debugMessage:@"set up managed document...."];
          _managedContext=self.managedDocument.managedObjectContext;
        
        if([self.databaseDelegate respondsToSelector:@selector(databaseManagerDidCreatedManagedObjectContext:)])
        {
            [self.databaseDelegate databaseManagerDidCreatedManagedObjectContext:self.managedContext];
        }
    }
}



@end
