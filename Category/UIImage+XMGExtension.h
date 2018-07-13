//
//  UIImage+XMGExtension.h
//  Avantech
//
//  Created by avantech on 17/8/3.
//  Copyright (c) 2017年 豆凯强. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (XMGExtension)
/**
 * 圆形图片
 */
- (UIImage *)circleImage;

+ (UIImage *)imageWithName:(NSString *)name;


+ (UIImage*)createImageWithColor:(UIColor*)color;


@end
