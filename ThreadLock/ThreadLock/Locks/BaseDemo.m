//
//  BaseDemo.m
//  ThreadLock
//
//  Created by 满孝意 on 2019/5/6.
//  Copyright © 2019 ManXiaoYi. All rights reserved.
//

#import "BaseDemo.h"

@interface BaseDemo ()

@property (nonatomic, assign) int ticketsCount;
@property (nonatomic, assign) int money;

@end

@implementation BaseDemo

#pragma mark -
#pragma mark - otherTest
- (void)otherTest {}

#pragma mark -
#pragma mark - 存钱、取钱演示
- (void)moneyTest {
    self.money = 100;

    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);

    dispatch_async(queue, ^{
        for (int i = 0; i < 10; i++) {
            [self __saveMoney];
        }
    });

    dispatch_async(queue, ^{
        for (int i = 0; i < 10; i++) {
            [self __drawMoney];
        }
    });
}

/** ---- 存钱 ---- */
- (void)__saveMoney {
    int oldMoney = self.money;
    sleep(0.2);
    oldMoney += 50;
    self.money = oldMoney;

    NSLog(@"存50，还剩%d元 - %@", oldMoney, [NSThread currentThread]);
}

/** ---- 取钱 ---- */
- (void)__drawMoney {
    int oldMoney = self.money;
    sleep(0.2);
    oldMoney -= 20;
    self.money = oldMoney;

    NSLog(@"取20，还剩%d元 - %@", oldMoney, [NSThread currentThread]);
}

#pragma mark -
#pragma mark - 卖票演示
- (void)ticketTest {
    self.ticketsCount = 15;

    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);

    dispatch_async(queue, ^{
        for (int i = 0; i < 5; i++) {
            [self __saleTickets];
        }
    });

    dispatch_async(queue, ^{
        for (int i = 0; i < 5; i++) {
            [self __saleTickets];
        }
    });

    dispatch_async(queue, ^{
        for (int i = 0; i < 5; i++) {
            [self __saleTickets];
        }
    });
}

/** ---- 卖1张票 ---- */
- (void)__saleTickets {
    int oldTicketsCount = self.ticketsCount;
    sleep(0.2);
    oldTicketsCount--;
    self.ticketsCount = oldTicketsCount;

    NSLog(@"还剩%d张票 - %@", oldTicketsCount, [NSThread currentThread]);
}

@end
