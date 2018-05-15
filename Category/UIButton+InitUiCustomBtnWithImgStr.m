//
//  UIButton+InitUiCustomBtnWithImgStr.m
//  booktest
//
//  Created by avantech on 2018/1/30.
//  Copyright © 2018年 豆凯强. All rights reserved.
//

#import "UIButton+InitUiCustomBtnWithImgStr.h"

@implementation UIButton (InitUiCustomBtnWithImgStr)
+(instancetype)initUiCustomBtnWithImgStr:(NSString*)img andSelectImg:(NSString*)selectImg{
    UIButton *backBtn=[UIButton buttonWithType:1];
    [backBtn setImage:[UIImage imageNamed:img] forState:UIControlStateNormal];
    if (selectImg!=nil) {
        [backBtn setImage:[UIImage imageNamed:selectImg] forState:UIControlStateSelected];
    }    
    [backBtn sizeToFit];
    return backBtn;
}
@end
