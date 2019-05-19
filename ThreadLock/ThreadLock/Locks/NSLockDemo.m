//
//  NSLockDemo.m
//  ThreadLock
//
//  Created by 满孝意 on 2019/5/7.
//  Copyright © 2019 ManXiaoYi. All rights reserved.
//

#import "NSLockDemo.h"

// NSLock是对mutex普通锁的封装
// NSRecursiveLock也是对mutex递归锁的封装，API跟NSLock基本一致
@interface NSLockDemo ()

@property (nonatomic, strong) NSLock *moneyLock;
@property (nonatomic, strong) NSLock *ticketLock;

@end

@implementation NSLockDemo

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.moneyLock = [[NSLock alloc] init];
        self.ticketLock = [[NSLock alloc] init];
    }
    return self;
}

#pragma mark -
#pragma mark - 重写父类方法
- (void)__saveMoney
{
    [self.moneyLock lock];

    [super __saveMoney];

    [self.moneyLock unlock];
}

- (void)__drawMoney
{
    [self.moneyLock lock];

    [super __drawMoney];

    [self.moneyLock unlock];
}

- (void)__saleTickets
{
    [self.ticketLock lock];

    [super __saleTickets];

    [self.ticketLock unlock];
}

@end
