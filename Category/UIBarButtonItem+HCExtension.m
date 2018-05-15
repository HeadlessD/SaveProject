//
//  UIBarButtonItem+HCExtension.m
//  EquipmentDog
//
//  Created by chuang Hao on 2018/4/9.
//  Copyright © 2018年 pusikeji. All rights reserved.
//

#import "UIBarButtonItem+HCExtension.h"

@implementation UIBarButtonItem (HCExtension)

+ (UIBarButtonItem *)hc_systemItemWithTitle:(NSString *)title
                                 titleColor:(UIColor *)titleColor
                                      image:(UIImage *)image
                                     target:(id)target
                                   selector:(SEL)selector
                                   textType:(BOOL)textType {
    UIBarButtonItem *item = textType ?
    ({
        /// 设置普通状态的文字属性
        item = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStylePlain target:target action:selector];
        titleColor = titleColor?titleColor:[UIColor whiteColor];
        NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
        textAttrs[NSForegroundColorAttributeName] = titleColor;
        textAttrs[NSFontAttributeName] = [UIFont appFontSize:14 fontName:PINGFANG_REGULAR];
        NSShadow *shadow = [[NSShadow alloc] init];
        shadow.shadowOffset =  CGSizeZero;
        textAttrs[NSShadowAttributeName] = shadow;
        [item setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
        
        // 设置高亮状态的文字属性
        NSMutableDictionary *highTextAttrs = [NSMutableDictionary dictionaryWithDictionary:textAttrs];
        highTextAttrs[NSForegroundColorAttributeName] = [titleColor colorWithAlphaComponent:.5f];
        [item setTitleTextAttributes:highTextAttrs forState:UIControlStateHighlighted];
        
        // 设置不可用状态(disable)的文字属性
        NSMutableDictionary *disableTextAttrs = [NSMutableDictionary dictionaryWithDictionary:textAttrs];
        disableTextAttrs[NSForegroundColorAttributeName] = [titleColor colorWithAlphaComponent:.5f];
        [item setTitleTextAttributes:disableTextAttrs forState:UIControlStateDisabled];
        
        item;
    }) : ({
        item = [[UIBarButtonItem alloc] initWithImage:[image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:target action:selector];
        item;
    });
    return item;
}

+ (UIBarButtonItem *)hc_customItemWithTitle:(NSString *)title
                                 titleColor:(UIColor *)titleColor
                                      image:(UIImage *)image
                                     target:(id)target
                                   selector:(SEL)selector
                 contentHorizontalAlignment:(UIControlContentHorizontalAlignment)contentHorizontalAlignment {
    UIButton *item = [[UIButton alloc] init];
    titleColor = titleColor?titleColor:[UIColor whiteColor];
    [item setTitle:title forState:UIControlStateNormal];
    [item setImage:image forState:UIControlStateNormal];
    [item.titleLabel setFont:[UIFont appFontSize:14 fontName:PINGFANG_REGULAR]];
    [item setTitleColor:titleColor forState:UIControlStateNormal];
    [item setTitleColor:[titleColor colorWithAlphaComponent:.5f] forState:UIControlStateHighlighted];
    [item setTitleColor:[titleColor colorWithAlphaComponent:.5f] forState:UIControlStateDisabled];
    [item sizeToFit];
    item.contentHorizontalAlignment = contentHorizontalAlignment;
    [item addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:item];
}

// 返回按钮，带箭头的
+ (UIBarButtonItem *)hc_backItemWithTitle:(NSString *)title
                                    image:(UIImage *)image
                                   target:(id)target
                                   action:(SEL)action
{
    return [self hc_customItemWithTitle:title titleColor:nil image:image target:target selector:action contentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
}

@end
