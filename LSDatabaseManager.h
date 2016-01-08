//
//  LSDatabaseManager.h
//  CoreDataApp
//
//  Created by lifesense on 14-7-23.
//  Copyright (c) 2014年 lifesense. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "DatabaseManagerDelegate.h"

@interface LSDatabaseManager : NSObject
@property(nonatomic,readonly) NSManagedObjectContext *managedContext;
@property(nonatomic,strong)id<DatabaseManagerDelegate> databaseDelegate;

//获取对象实例
+(instancetype)defaultManager;

//设置数据库名称,进行数据库初始化
-(NSManagedObjectContext *)createManagedObjectContextWithDocumentName:(NSString *)documentName;


//查询某一张表中的所有记录
-(NSArray *)allObjectForEntityForName:(NSString *)entityName
                            predicate:(NSPredicate *)predicate;

-(NSArray *)getAllPairedDevice;


-(NSManagedObject *)objectForEntityForName:(NSString *)entityName
                              predicate:(NSPredicate *)predicate;


-(void)manuallySave;

-(void)deleteAllObject;

@end
