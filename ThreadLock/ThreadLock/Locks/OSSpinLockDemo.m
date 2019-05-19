//
//  OSSpinLockDemo.m
//  ThreadLock
//
//  Created by 满孝意 on 2019/5/6.
//  Copyright © 2019 ManXiaoYi. All rights reserved.
//

#import "OSSpinLockDemo.h"
#import "Libkern/OSAtomic.h"

@interface OSSpinLockDemo ()

// High-level lock
@property (nonatomic, assign) OSSpinLock moneyLock;
@property (nonatomic, assign) OSSpinLock ticketLock;

@end

@implementation OSSpinLockDemo

- (instancetype)init
{
    self = [super init];
    if (self) {
        // 初始化
        self.moneyLock = OS_SPINLOCK_INIT;
        self.ticketLock = OS_SPINLOCK_INIT;
    }
    return self;
}

#pragma mark -
#pragma mark - 重写父类方法
- (void)__saveMoney
{
    // 加锁
    OSSpinLockLock(&_moneyLock);

    [super __saveMoney];

    // 解锁
    OSSpinLockUnlock(&_moneyLock);
}

- (void)__drawMoney
{
    // 加锁
    OSSpinLockLock(&_moneyLock);

    [super __drawMoney];

    // 解锁
    OSSpinLockUnlock(&_moneyLock);
}

- (void)__saleTickets
{
    // 方法一：
    // 加锁
    OSSpinLockLock(&_ticketLock);

    [super __saleTickets];

    // 解锁
    OSSpinLockUnlock(&_ticketLock);

    // 方法二：尝试加锁
    // 如果需要等待就不加锁，返回false
    // 如果不需要等待就加锁，返回true
    //    if (OSSpinLockTry(&_ticketLock)) {
    //        [super __saleTickets];
    //
    //        OSSpinLockUnlock(&_ticketLock);
    //    }
}

@end
