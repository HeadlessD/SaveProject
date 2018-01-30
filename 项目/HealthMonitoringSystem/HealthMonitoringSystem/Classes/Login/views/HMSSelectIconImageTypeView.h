//
//  HMSSelectIconImageTypeView.h
//  HealthMonitoringSystem
//
//  Created by gw on 2017/7/3.
//  Copyright © 2017年 mirahome. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum{
    HMSSelectIconImageTypeOne,
    HMSSelectIconImageTypeTwo
} HMSSelectIconImageType;

typedef void (^HMSSelectIconImageTypeAction)(HMSSelectIconImageType);



@interface HMSSelectIconImageTypeView : UIView
@property (nonatomic,strong)UIView *sliderBGView;

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title oneImage:(UIImage *)oneImage oneText:(NSString *)oneText oneTextColor:(UIColor *)oneTextColor twoImage:(UIImage *)twoImage twoText:(NSString *)twoText twoTextColor:(UIColor *)twoTextColor;

-(void)show;

@property (nonatomic,copy)HMSSelectIconImageTypeAction selectType;

@property (nonatomic,copy)HMSSelectIconImageTypeAction selectTypeNoneAction;

@end
