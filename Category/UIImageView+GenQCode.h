//
//  UIImageView+GenQCode.h
//  NextDoor
//
//  Created by 罗艺 on 2017/4/15.
//  Copyright © 2017年 罗艺. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (GenQCode)
-(void)initErCodeWithString:(NSString *)dataString withSize:(CGFloat)size;
@end
