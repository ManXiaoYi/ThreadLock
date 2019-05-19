
//
//  PthreadMutexDemo3.m
//  ThreadLock
//
//  Created by 满孝意 on 2019/5/7.
//  Copyright © 2019 ManXiaoYi. All rights reserved.
//

#import "PthreadMutexDemo3.h"
#import <pthread.h>

@interface PthreadMutexDemo3 ()

@property (nonatomic, assign) pthread_mutex_t mutex;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, assign) pthread_cond_t cond;

@end

@implementation PthreadMutexDemo3

- (instancetype)init
{
    self = [super init];
    if (self) {
        // 初始化属性
        pthread_mutexattr_t attr;
        pthread_mutexattr_init(&attr);
        pthread_mutexattr_settype(&attr, PTHREAD_MUTEX_RECURSIVE);
        // 初始化锁
        pthread_mutex_init(&_mutex, &attr);
        // 销毁属性
        pthread_mutexattr_destroy(&attr);

        // 初始化条件
        pthread_cond_init(&_cond, NULL);
    }
    return self;
}

#pragma mark -
#pragma mark - 重写父类方法 - 需求：数组有数据才能删除
- (void)otherTest
{
    [[[NSThread alloc] initWithTarget:self selector:@selector(__remove) object:nil] start];

    sleep(1);

    [[[NSThread alloc] initWithTarget:self selector:@selector(__add) object:nil] start];
}

// 删除数组中的元素
- (void)__remove
{
    pthread_mutex_lock(&_mutex);

    if (self.dataArray.count == 0) {
        // 等待条件 - 进入休眠，放开mutex锁；被唤醒后，会再次对mutex加锁
        pthread_cond_wait(&_cond, &_mutex);
    }

    [self.dataArray removeLastObject];
    NSLog(@"数组删除了元素");

    pthread_mutex_unlock(&_mutex);
}

// 往数组中添加元素
- (void)__add
{
    pthread_mutex_lock(&_mutex);

    [self.dataArray addObject:@"test"];
    NSLog(@"数组添加了元素");

    // 信号 - 激活一个等待该条件的线程
    pthread_cond_signal(&_cond);
    // 广播 - 激活所有等待该条件的线程
    //pthread_cond_broadcast(&_cond);

    pthread_mutex_unlock(&_mutex);
}

#pragma mark -
#pragma mark - 销毁锁、条件
- (void)dealloc
{
    pthread_mutex_destroy(&_mutex);
    pthread_cond_destroy(&_cond);
}

@end
