//
//  NSConditionLockDemo.m
//  ThreadLock
//
//  Created by 满孝意 on 2019/5/14.
//  Copyright © 2019 ManXiaoYi. All rights reserved.
//

#import "NSConditionLockDemo.h"

// NSConditionLock是对NSCondition的进一步封装
// 可以设置具体的条件值
@interface NSConditionLockDemo ()

@property (nonatomic, strong) NSConditionLock *conditionLock;

@end

@implementation NSConditionLockDemo

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.conditionLock = [[NSConditionLock alloc] initWithCondition:1];
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
    // 直接加锁，不用等条件值
    //[self.conditionLock lock];
    [self.conditionLock lockWhenCondition:2];

    NSLog(@"数组删除了元素");
    sleep(1);

    [self.conditionLock unlock];
}

// 往数组中添加元素
- (void)__add
{
    [self.conditionLock lockWhenCondition:1];

    NSLog(@"数组添加了元素");
    sleep(1);

    [self.conditionLock unlockWithCondition:2];
}

@end

