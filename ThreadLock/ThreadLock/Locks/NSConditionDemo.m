//
//  NSConditionDemo.m
//  ThreadLock
//
//  Created by 满孝意 on 2019/5/14.
//  Copyright © 2019 ManXiaoYi. All rights reserved.
//

#import "NSConditionDemo.h"

// NSCondition是对mutex和cond的封装
@interface NSConditionDemo ()

@property (nonatomic, strong) NSCondition *condition;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation NSConditionDemo

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.condition = [[NSCondition alloc] init];
        self.dataArray = [[NSMutableArray alloc] init];
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
    [self.condition lock];

    if (self.dataArray.count == 0) {
        // 等待条件 - 进入休眠，放开mutex锁；被唤醒后，会再次对mutex加锁
        [self.condition wait];
    }

    [self.dataArray removeLastObject];
    NSLog(@"数组删除了元素");

    [self.condition unlock];
}

// 往数组中添加元素
- (void)__add
{
    [self.condition lock];

    [self.dataArray addObject:@"test"];
    NSLog(@"数组添加了元素");

    // 信号
    [self.condition signal];
    // 广播
    //[self.condition broadcast];

    [self.condition unlock];
}

@end
