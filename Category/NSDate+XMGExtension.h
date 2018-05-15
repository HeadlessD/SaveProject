//
//  NSDate+XMGExtension.h
//  Avantech
//
//  Created by avantech on 17/7/27.
//  Copyright (c) 2017年 豆凯强. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (XMGExtension)
/**
 * 比较from和self的时间差值
 */
- (NSDateComponents *)deltaFrom:(NSDate *)from;

/**
 * 是否为今年
 */
- (BOOL)isThisYear;

/**
 * 是否为今天
 */
- (BOOL)isToday;

/**
 * 是否为昨天
 */
- (BOOL)isYesterday;
@end
