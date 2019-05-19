//
//  ViewController.m
//  ThreadLock
//
//  Created by 满孝意 on 2019/5/5.
//  Copyright © 2019 ManXiaoYi. All rights reserved.
//

#import "ViewController.h"
#import "BaseDemo.h"
#import "OSSpinLockDemo.h"
#import "OSUnfairLockDemo.h"
#import "PthreadMutexDemo.h"
#import "PthreadMutexDemo2.h"
#import "PthreadMutexDemo3.h"
#import "NSLockDemo.h"
#import "NSConditionDemo.h"
#import "NSConditionLockDemo.h"
#import "SerialQueueDemo.h"
#import "SemaphoreDemo.h"
#import "SynchronizedDemo.h"

#import <libkern/OSAtomic.h>
#import <os/lock.h>
#import <pthread.h>

@interface ViewController ()

@property (nonatomic, strong) NSThread *thread;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    BaseDemo *demo = [[OSSpinLockDemo alloc] init];
        [demo ticketTest];
        [demo moneyTest];
//    [demo otherTest];
    
}

@end
