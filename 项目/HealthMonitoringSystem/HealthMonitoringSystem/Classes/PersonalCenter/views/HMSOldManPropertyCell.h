//
//  HMSOldManPropertyCell.h
//  HealthMonitoringSystem
//
//  Created by gw on 2017/7/6.
//  Copyright © 2017年 mirahome. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum{
    HMSOldManPropertyCellCornerNone,
    HMSOldManPropertyCellCornerTop,
    HMSOldManPropertyCellCornerBottom
} HMSOldManPropertyCellCornerType;
@interface HMSOldManPropertyCell : UIView

@property (nonatomic,strong) UITextField *textTitleTF;

-(instancetype)initWithFrame:(CGRect)frame WithTitle:(NSString *)title text:(NSString *)text Placeholder:(NSString *)placeholder rightImg:(UIImage *)rightImg cornerType:(HMSOldManPropertyCellCornerType)cornerType isLine:(BOOL)isline;

@end
