//
//  HMSHomePageReplyInputView.h
//  HealthMonitoringSystem
//
//  Created by gw on 2017/7/20.
//  Copyright © 2017年 mirahome. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HMSWeiboModel,HMSHomePageReplyInputView;

@protocol HMSHomePageReplyInputViewDelegate <NSObject>

@optional
- (void)inputPanelView:(HMSHomePageReplyInputView *)inputView attributedText:(NSString *)attributedText;

@end

@interface HMSHomePageReplyInputView : UIView
/**  */
@property (nonatomic , strong) HMSWeiboModel *weiboM;

@property (nonatomic , strong) NSIndexPath *indexPath;
/** 代理 */
@property (nonatomic , weak) id <HMSHomePageReplyInputViewDelegate> delegate;

+ (instancetype)replyInputView;

/** 显示 */
- (void) show;

/** 是否人为dismiss */
- (void) dismissByUser:(BOOL)state;
@end
