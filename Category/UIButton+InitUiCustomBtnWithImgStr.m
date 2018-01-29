//
//  UIButton+InitUiCustomBtnWithImgStr.m
//  booktest
//
//  Created by 罗艺 on 2016/12/12.
//  Copyright © 2016年 罗艺. All rights reserved.
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
