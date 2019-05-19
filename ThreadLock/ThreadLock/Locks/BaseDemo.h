//
//  BaseDemo.h
//  ThreadLock
//
//  Created by 满孝意 on 2019/5/6.
//  Copyright © 2019 ManXiaoYi. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseDemo : NSObject

- (void)ticketTest;
- (void)moneyTest;
- (void)otherTest;

/** ---- 暴露给子类使用 ---- */
- (void)__saveMoney;
- (void)__drawMoney;
- (void)__saleTickets;

@end

NS_ASSUME_NONNULL_END
