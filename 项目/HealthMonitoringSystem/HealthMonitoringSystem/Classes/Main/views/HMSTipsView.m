//
//  HMSTipsView.m
//  HealthMonitoringSystem
//
//  Created by gw on 2017/7/12.
//  Copyright © 2017年 mirahome. All rights reserved.
//

#import "HMSTipsView.h"

@implementation HMSTipsView

-(instancetype)initWithTitle:(NSString *)title icon:(UIImage *)icon{
    self = [super init];
    if (self) {
        self.frame =CGRectMake(0, 0, KScreenWidth, KScreenHeight);
        
        
        UIImageView* imageview = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth * 0.5, KScreenWidth * 0.5)];
        imageview.center = CGPointMake(self.width*0.5, self.height*0.5-50);
        imageview.image = icon;
        
        UILabel* titleL = [UILabel labelWithTitle:title Color:[UIColor whiteColor] Font:HMSFOND(20) textAlignment:NSTextAlignmentCenter];
        titleL.frame = CGRectMake(0, CGRectGetMaxY(imageview.frame)+30, self.width, 20);
        
        if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
            UIBlurEffect* blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
            UIVisualEffectView*  blur = [[UIVisualEffectView alloc]initWithEffect:blurEffect];
            blur.frame = self.frame;
            [self addSubview:blur];
        }else {
            self.backgroundColor = HMSCustomARGBColor(0, 0, 0, 0.7);
        }
        
        [self addSubview:titleL];
        [self addSubview:imageview];
        
    }
    return self;
}


- (void)showInView:(UIView*)view{
    [view addSubview:self];
}

@end
