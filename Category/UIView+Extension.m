//
//  UIView+lineView.m
//  CircleLove
//
//  Created by 张灿 on 14-9-22.
//  Copyright (c) 2014年 xiaomiaos. All rights reserved.
//

#import "UIView+Extension.h"

@implementation UIView (Extension)
- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)size
{
    return self.frame.size;
}

- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)x
{
    return self.frame.origin.x;
}

- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (void)setCenterX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)centerX
{
    return self.center.x;
}

- (void)setCenterY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)centerY
{
    return self.center.y;
}
- (void)setOrigin:(CGPoint)origin
{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGPoint)origin
{
    return self.frame.origin;
}

- (void)topLineforViewWithColor:(UIColor*)color{
    UIView* line = [[UIView alloc]init];
    line.frame = CGRectMake(0, 0, self.frame.size.width, 1);
    line.backgroundColor = color;
    [self addSubview:line];
}
- (void)topLineforView{
    UIView* line = [[UIView alloc]init];
    line.frame = CGRectMake(0, 0, self.frame.size.width, 0.5);
    line.backgroundColor = UIColorFromRGB(0xe6e6e6);
    [self addSubview:line];
}
- (void)topLinepaddingLeft:(CGFloat)left{
    UIView* line = [[UIView alloc]init];
    line.frame = CGRectMake(left, 0, self.frame.size.width, 0.5);
    line.backgroundColor = UIColorFromRGB(0xe6e6e6);
    [self addSubview:line];
}
- (void)bottomLineforViewWithColor:(UIColor*)color{
    UIView* line = [[UIView alloc]init];
    //line.frame = CGRectMake(0, self.frame.size.height-0.5, self.frame.size.width, 0.5);
    line.backgroundColor = color;
    [self addSubview:line];
    WS(ws);
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@0.5);
        make.left.equalTo(ws);
        make.right.equalTo(ws);
        make.top.equalTo(ws.mas_bottom).with.offset(-0.5);
    }];
}
- (void)bottomLineforViewWithColor:(UIColor*)color Left:(CGFloat)left{
    UIView* line = [[UIView alloc]init];
    line.frame = CGRectMake(left, self.frame.size.height-0.5, self.frame.size.width-2*left, 0.5);
    line.backgroundColor = color;
    [self addSubview:line];
}
- (void)bottomWideLineforView:(CGFloat)height{
    UIView* line = [[UIView alloc]init];
    line.frame = CGRectMake(0, self.frame.size.height-height, self.frame.size.width, height);
    line.backgroundColor = UIColorFromRGB(0xe6e6e6);
    [self addSubview:line];
}
- (void)verticalLinepaddingLeft:(CGFloat)left{
    UIView* line = [[UIView alloc]init];
    line.frame = CGRectMake(left, 0, 1, self.frame.size.height);
    line.backgroundColor = UIColorFromRGB(0xe6e6e6);
    [self addSubview:line];
}


-(void)bottomWithShadow
{
    self.layer.shadowColor =HMSCustomColor(230, 230, 230).CGColor; //shadowColor阴影颜色
    self.layer.shadowOffset = CGSizeMake(0 , 2); //shadowOffset阴影偏移x，y向(上/下)偏移(-/+)2
    self.layer.shadowOpacity = 0.5;//阴影透明度，默认0
    self.layer.shadowRadius = 1.0f;//阴影半径
    UIBezierPath *path =[UIBezierPath bezierPathWithRect:CGRectMake(0, self.height*0.5, self.width, self.height*0.5)];
    self.layer.shadowPath =path.CGPath;
    
//    self.layer.shadowColor = [UIColor grayColor].CGColor; //shadowColor阴影颜色
//    self.layer.shadowOffset = CGSizeMake(0 , 0.5f); //shadowOffset阴影偏移x，y向(上/下)偏移(-/+)2
//    self.layer.shadowOpacity = 0.3f;//阴影透明度，默认0
//    self.layer.shadowRadius = 1.0f;//阴影半径
}


@end
