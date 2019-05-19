//
//  SerialQueueDemo.m
//  ThreadLock
//
//  Created by 满孝意 on 2019/5/14.
//  Copyright © 2019 ManXiaoYi. All rights reserved.
//

#import "SerialQueueDemo.h"

// GCD的串行队列 实现线程同步
@interface SerialQueueDemo ()

@property (nonatomic, strong) dispatch_queue_t moneyQueue;
@property (nonatomic, strong) dispatch_queue_t ticketQueue;

@end

@implementation SerialQueueDemo

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.ticketQueue = dispatch_queue_create("ticketQueue", DISPATCH_QUEUE_SERIAL);
        self.moneyQueue = dispatch_queue_create("ticketQueue", DISPATCH_QUEUE_SERIAL);
    }
    return self;
}

#pragma mark -
#pragma mark - 重写父类方法
- (void)__saveMoney
{
    dispatch_sync(self.moneyQueue, ^{
        [super __saveMoney];
    });
}

- (void)__drawMoney
{
    dispatch_sync(self.moneyQueue, ^{
        [super __drawMoney];
    });
}

- (void)__saleTickets
{
    dispatch_sync(self.ticketQueue, ^{
        [super __saleTickets];
    });
}

@end
