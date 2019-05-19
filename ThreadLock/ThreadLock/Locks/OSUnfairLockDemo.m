//
//  OSUnfairLockDemo.m
//  ThreadLock
//
//  Created by 满孝意 on 2019/5/6.
//  Copyright © 2019 ManXiaoYi. All rights reserved.
//

#import "OSUnfairLockDemo.h"
#import "os/lock.h"

@interface OSUnfairLockDemo ()

// Low-level lock 即 ll lock 即 lll
// 特点：等不到锁就休眠
@property (nonatomic, assign) os_unfair_lock moneyLock;
@property (nonatomic, assign) os_unfair_lock ticketLock;

@end

@implementation OSUnfairLockDemo

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.moneyLock = OS_UNFAIR_LOCK_INIT;
        self.ticketLock = OS_UNFAIR_LOCK_INIT;
    }
    return self;
}

#pragma mark -
#pragma mark - 重写父类方法
- (void)__saveMoney
{
    os_unfair_lock_lock(&_moneyLock);
    
    [super __saveMoney];
    
    os_unfair_lock_unlock(&_moneyLock);
}

- (void)__drawMoney
{
    os_unfair_lock_lock(&_moneyLock);
    
    [super __drawMoney];
    
    os_unfair_lock_unlock(&_moneyLock);
}

- (void)__saleTickets
{
    os_unfair_lock_lock(&_ticketLock);
    
    [super __saleTickets];
    
    os_unfair_lock_unlock(&_ticketLock);
}

@end
