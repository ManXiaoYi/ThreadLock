//
//  SemaphoreDemo.m
//  ThreadLock
//
//  Created by 满孝意 on 2019/5/15.
//  Copyright © 2019 ManXiaoYi. All rights reserved.
//

#import "SemaphoreDemo.h"

/**
 semaphore叫做”信号量”
 信号量的初始值，可以用来控制线程并发访问的最大数量
 信号量的初始值为1，代表同时只允许1条线程访问资源，保证线程同步
 */

#define SemaphoreBegin \
static dispatch_semaphore_t semaphore; \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
    semaphore = dispatch_semaphore_create(1); \
}); \
dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);

#define SemaphoreEnd \
dispatch_semaphore_signal(semaphore);

@interface SemaphoreDemo ()

@property (nonatomic, strong) dispatch_semaphore_t semaphore;

@end

@implementation SemaphoreDemo

- (instancetype)init
{
    self = [super init];
    if (self) {
        // 线程并发访问的最大数量设置为1，实现线程同步
        self.semaphore = dispatch_semaphore_create(1);
    }
    return self;
}

- (void)otherTest
{
    for (int i=0; i<5; i++) {
        [[[NSThread alloc] initWithTarget:self selector:@selector(test) object:nil] start];
    }
}

- (void)test
{
    // 如果信号量的值 >0，就让信号量的值 -1，然后继续往下执行代码
    // 如果信号量的值 <=0，就会休眠等待，直到信号量的值变成 >0，就让信号量的值 -1，然后继续往下执行代码
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);

    sleep(1);
    NSLog(@"%@", [NSThread currentThread]);

    // 让信号量的值 +1
    dispatch_semaphore_signal(self.semaphore);
}

#pragma mark -
#pragma mark - 重写父类方法 - 使用技巧：宏定义
- (void)__saveMoney
{
    SemaphoreBegin

    [super __saveMoney];

    SemaphoreEnd
}

- (void)__drawMoney
{
    SemaphoreBegin

    [super __drawMoney];
    
    SemaphoreEnd
}

- (void)__saleTickets
{
    SemaphoreBegin

    [super __saleTickets];

    SemaphoreEnd
}

@end
