//
//  NSMutableArray+QueueAdditions.h
//  LSBluetooth-Library
//
//  Created by lifesense on 15/7/9.
//  Copyright (c) 2015年 Lifesense. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (QueueAdditions)

//从队列中获取第一个元素，且执行删除操作
-(id)dequeue;

//从队列中获取第一个元素，但不删除
-(id) peekqueue;

//向队列中插入一个元素
-(void) enqueue:(id)obj;

@end
