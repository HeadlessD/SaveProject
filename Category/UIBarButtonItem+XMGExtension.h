//
//  UIBarButtonItem+XMGExtension.h
//  Avantech
//
//  Created by avantech on 17/7/22.
//  Copyright (c) 2017年 豆凯强. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (XMGExtension)
+ (instancetype)itemWithImage:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action;
+ (instancetype)itemWithImage:(NSString *)image title:(NSString *)title target:(id)target action:(SEL)action;
@end
