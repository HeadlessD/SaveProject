//
//  UIView+lineView.h
//  CircleLove
//
//  Created by 张灿 on 14-9-22.
//  Copyright (c) 2014年 xiaomiaos. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Extension)
//获取UIView的frame
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGSize size;
@property (assign, nonatomic) CGPoint origin;
//给UIView画灰色的线
- (void)topLineforViewWithColor:(UIColor*)color;
- (void)topLinepaddingLeft:(CGFloat)left;
- (void)topLineforView;
- (void)bottomLineforViewWithColor:(UIColor*)color;
- (void)bottomWideLineforView:(CGFloat)height;
- (void)bottomLineforViewWithColor:(UIColor*)color Left:(CGFloat)left;
- (void)verticalLinepaddingLeft:(CGFloat)left;
-(void)bottomWithShadow;

/**
 * 判断一个控件是否真正显示在主窗口
 */
- (BOOL)isShowingOnKeyWindow;

//- (CGFloat)x;
//- (void)setX:(CGFloat)x;
/** 在分类中声明@property, 只会生成方法的声明, 不会生成方法的实现和带有_下划线的成员变量*/

+ (instancetype)viewFromXib;


@end


