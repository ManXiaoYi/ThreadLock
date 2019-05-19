//
//  SynchronizedDemo.m
//  ThreadLock
//
//  Created by 满孝意 on 2019/5/15.
//  Copyright © 2019 ManXiaoYi. All rights reserved.
//

#import "SynchronizedDemo.h"

/**
 @synchronized是对mutex递归锁的封装
 @synchronized(obj)内部会生成obj对应的递归锁，然后进行加锁、解锁操作
 */

@implementation SynchronizedDemo

#pragma mark - 重写父类方法
- (void)__saveMoney
{
    @synchronized ([self class]) {
        [super __saveMoney];
    }
}

- (void)__drawMoney
{
    @synchronized ([self class]) {
        [super __drawMoney];
    }
}

- (void)__saleTickets
{
    static NSObject *lock;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        lock = [[NSObject alloc] init];
    });

    @synchronized (lock) {
        [super __saleTickets];
    }
}

- (void)otherTest
{
    @synchronized ([self class]) {
        NSLog(@"递归锁");
        [self otherTest];
    }
}

@end
