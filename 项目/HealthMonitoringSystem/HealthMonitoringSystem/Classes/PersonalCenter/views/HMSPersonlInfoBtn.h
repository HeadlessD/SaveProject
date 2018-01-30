//
//  HMSPersonlInfoBtn.h
//  HealthMonitoringSystem
//
//  Created by gw on 2017/7/5.
//  Copyright © 2017年 mirahome. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum{
    HMSPersonlInfoBtnCornerNone,
    HMSPersonlInfoBtnCornerTop,
    HMSPersonlInfoBtnCornerBottom
} HMSPersonlInfoBtnCornerType;
@interface HMSPersonlInfoBtn : UIButton
@property(nonatomic,strong) UILabel *mainTitleLabel;
@property(nonatomic,strong) UITextField *textTitleTF;
@property(nonatomic,strong) UIImageView *iconImageView;

+(HMSPersonlInfoBtn *)buttonWithTitle:(NSString *)title text:(NSString *)text image:(UIImage *)image rect:(CGRect )rect icon:(NSString *)icon cornerType:(HMSPersonlInfoBtnCornerType)cornerType isLine:(BOOL)isline clickAction:(SEL)clickAction viewController:(id)viewController;
@end
