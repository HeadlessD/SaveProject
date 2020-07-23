//
//  UIImage+ATGetImgWithColor.m
//  AvanTSampleManeger
//
//  Created by 豆凯强 on 2017/12/25.
//  Copyright © 2017年 豆凯强. All rights reserved.
//

#import "UIImage+ATGetImgWithColor.h"

@implementation UIImage (ATGetImgWithColor)
+ (UIImage*)createImageWithColor:(UIColor*)color{
    
    CGRect rect=CGRectMake(0.0f,0.0f,1.0f,1.0f);
    UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef context=UIGraphicsGetCurrentContext();CGContextSetFillColorWithColor(context, [color CGColor]);
    
    CGContextFillRect(context, rect);
    
    UIImage*theImage=UIGraphicsGetImageFromCurrentImageContext();UIGraphicsEndImageContext();
    return theImage;
    
}
@end
