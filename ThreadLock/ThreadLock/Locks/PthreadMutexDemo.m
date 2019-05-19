//
//  PthreadMutexDemo.m
//  ThreadLock
//
//  Created by 满孝意 on 2019/5/6.
//  Copyright © 2019 ManXiaoYi. All rights reserved.
//

#import "PthreadMutexDemo.h"
#import "pthread.h"

@interface PthreadMutexDemo ()

@property (nonatomic, assign) pthread_mutex_t moneyLock;
@property (nonatomic, assign) pthread_mutex_t ticketLock;

@end

@implementation PthreadMutexDemo

- (void)__initMutex:(pthread_mutex_t *)mutex
{
    /**
     self.moneyLock = PTHREAD_MUTEX_INITIALIZER;

     以上方法报错，因为
     PTHREAD_MUTEX_INITIALIZER 内部实现为一下宏定义
     #define PTHREAD_MUTEX_INITIALIZER {_PTHREAD_MUTEX_SIG_init, {0}}

     即以下代码
     self.moneyLock = PTHREAD_MUTEX_INITIALIZER;
     可转为：
     self.moneyLock = {_PTHREAD_MUTEX_SIG_init, {0}};

     而结构体不支持以上方式初始化，所以报错，支持以下静态初始化方式：
     pthread_mutex_t mutex = PTHREAD_RWLOCK_INITIALIZER;
     */


    /**
    // 初始化属性
    pthread_mutexattr_t attr;
    pthread_mutexattr_init(&attr);
    // PTHREAD_MUTEX_DEFAULT = PTHREAD_MUTEX_NORMAL
    pthread_mutexattr_settype(&attr, PTHREAD_MUTEX_DEFAULT);

    // 初始化锁
    pthread_mutex_init(mutex, &attr);

    // 销毁属性
    pthread_mutexattr_destroy(&attr);
     */

    // 上面方法可简化：
    pthread_mutex_init(mutex, NULL);
}


- (instancetype)init
{
    self = [super init];
    if (self) {
        [self __initMutex:&_moneyLock];
        [self __initMutex:&_ticketLock];
    }
    return self;
}

#pragma mark -
#pragma mark - 重写父类方法
- (void)__saveMoney
{
    pthread_mutex_lock(&_moneyLock);

    [super __saveMoney];

    pthread_mutex_unlock(&_moneyLock);
}

- (void)__drawMoney
{
    pthread_mutex_lock(&_ticketLock);

    [super __drawMoney];

    pthread_mutex_unlock(&_ticketLock);
}

- (void)__saleTickets
{
    pthread_mutex_lock(&_ticketLock);

    [super __saleTickets];

    pthread_mutex_unlock(&_ticketLock);
}

#pragma mark -
#pragma mark - 销毁锁
- (void)dealloc
{
    pthread_mutex_destroy(&_moneyLock);
    pthread_mutex_destroy(&_ticketLock);
}

@end
