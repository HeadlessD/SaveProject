//
//  UIImageView+GenQCode.h
//  NextDoor
//
//  Created by 豆凯强 on 2017/4/15.
//  Copyright © 2017年 豆凯强. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (GenQCode)
-(void)initErCodeWithString:(NSString *)dataString withSize:(CGFloat)size;
@end
