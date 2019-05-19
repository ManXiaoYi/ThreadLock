//
//  PthreadMutexDemo2.m
//  ThreadLock
//
//  Created by 满孝意 on 2019/5/6.
//  Copyright © 2019 ManXiaoYi. All rights reserved.
//

#import "PthreadMutexDemo2.h"
#import "pthread.h"

@interface PthreadMutexDemo2 ()

@property (nonatomic, assign) pthread_mutex_t mutex;

@end

@implementation PthreadMutexDemo2

- (void)__initMutex:(pthread_mutex_t *)mutex
{
    /**
     #define PTHREAD_MUTEX_NORMAL        0             普通锁
     #define PTHREAD_MUTEX_ERRORCHECK    1
     #define PTHREAD_MUTEX_RECURSIVE        2         递归锁
     #define PTHREAD_MUTEX_DEFAULT        PTHREAD_MUTEX_NORMAL
     */
    // 初始化属性
    pthread_mutexattr_t attr;
    pthread_mutexattr_init(&attr);
    // TODO: -----------------  递归锁  -----------------
    // 递归锁：允许用 一个线程 对 一把锁 重复叠加
    pthread_mutexattr_settype(&attr, PTHREAD_MUTEX_RECURSIVE);

    // 初始化锁
    pthread_mutex_init(mutex, &attr);

    // 销毁属性
    pthread_mutexattr_destroy(&attr);
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self __initMutex:&_mutex];
    }
    return self;
}

#pragma mark -
#pragma mark - 重写父类方法 - 递归锁
- (void)otherTest
{
    pthread_mutex_lock(&_mutex);

    NSLog(@"%s", __func__);

    static int count = 0;
    if (count < 5) {
        count++;
        [self otherTest];
    }

    pthread_mutex_unlock(&_mutex);
}

#pragma mark -
#pragma mark - 销毁锁
- (void)dealloc
{
    pthread_mutex_destroy(&_mutex);
}

@end
