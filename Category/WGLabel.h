//
//  WGLabel.h
//  QiaoQiaoCardsDemo
//
//  Created by 豆凯强 on 15/12/4.
//  Copyright © 2015年 豆凯强. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum
{
    VerticalAlignmentTop = 0, // default
    VerticalAlignmentMiddle,
    VerticalAlignmentBottom,
} VerticalAlignment;

@interface WGLabel : UILabel
{
@private
    VerticalAlignment _verticalAlignment;
}

@property (nonatomic) VerticalAlignment verticalAlignment;

@end
