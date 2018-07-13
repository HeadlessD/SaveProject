//
//  Utilities.h
//  
//
//  Created by avantech on 2018/1/30.
//  Copyright © 2018年 豆凯强. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface WGUIKitTool : NSObject

@end


@interface NSDictionary (Helper)

- (id)kObjectForKey:(id)aKey;
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;


+ (NSString*)dictionaryToJson:(NSDictionary *)dic;



@end

@interface NSMutableDictionary (Helper)

- (void)kSetObject:(id)obj forKey:(id)key;

@end

@interface NSArray (Helper)

+ (NSArray *)arrWithJsonString:(NSString *)jsonString;

+ (NSString*)arrToJson:(NSArray *)dic;

@end

@interface NSString (Helper)
/**
 *  动态计算文字的宽高（单行）
 *
 *  @param font 文字的字体
 *
 *  @return 计算的宽高
 */
- (CGSize)WG_sizeWithFont:(UIFont *)font;


/**
 *  动态计算文字的宽高（多行）
 *
 *  @param font 文字的字体
 *  @param limitSize 限制的范围
 *
 *  @return 计算的宽高
 */
- (CGSize) WG_sizeWithFont:(UIFont *)font limitSize:(CGSize)limitSize;

/**
 *  动态计算文字的宽高（多行）
 *
 *  @param font 文字的字体
 *  @param width 限制宽度 ，高度不限制
 *
 *  @return 计算的宽高
 */
- (CGSize)WG_sizeWithFont:(UIFont *)font limitWidth:(CGFloat)limitWidth;


+ (CGFloat )widthWithString:(NSString *)string andStrFont:(UIFont *)font andMaxSize:(CGSize)size;
+ ( NSMutableAttributedString * )HTMLFromString:(NSString *)string;
+ (CGSize )sizeWithString:(NSString *)string andStrFont:(UIFont *)font andMaxSize:(CGSize)size;

@end

@interface UILabel (Helper)
+(UILabel *)labelWithTitle:(NSString *)title Color:(UIColor *)color Font:(UIFont *)font textAlignment:(NSTextAlignment)alignment;
+(UILabel *)labelWithPoint:(CGPoint)point maxWidth:(CGFloat)maxWidth text:(NSString *)text textColor:(UIColor *)color fontSize:(CGFloat)fontSize spaceLine:(BOOL)spaceLine;

+ (CGFloat)getHeightByWidth:(CGFloat)width title:(NSString *)title font:(UIFont*)font;

+ (UILabel *)labelWithRect:(CGRect)rect
                      text:(NSString *)text
                 textColor:(UIColor *)textColor
                  fontSize:(CGFloat)fontSize
             textAlignment:(NSTextAlignment)textAlignment;

+ (CGSize)sizeWithText:(NSString *)text
                  font:(UIFont *)font
               maxSize:(CGSize)maxSize;

- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize;

- (CGSize)boundingRectWithSize:(CGSize)size;
+ (CGFloat)getStingWidth:(NSString *)string;

@end

@interface UIView (Helper)

- (void)addLabelWithRect:(CGRect)rect
                    text:(NSString *)text
               textColor:(UIColor *)textColor
                fontSize:(CGFloat)fontSize
                     tag:(NSInteger)tag
           textAlignment:(NSTextAlignment)textAlignment;

- (void)addEdgingViewWithRect:(CGRect)rect
                  borderColor:(UIColor *)borderColor
                  borderWidth:(CGFloat)width
                    viewColor:(UIColor *)viewColor
                      viewTag:(int)tag;

-(UIView *)addHospitalViewWithRect:(CGRect)rect Dic:(NSDictionary *)dic andTag:(int )tag;

+ (void)cornerView:(UIView *)view andUpLeft:(UIRectCorner )upleft andUpRight:(UIRectCorner )upright andBottomLeft:(UIRectCorner )bottomleft  andBottomRight:(UIRectCorner )bottomright andSizeMake:(int) cornerlayerSize;


+ (UIView *)getNewButtonWithImage:(UIImage *)img title:(NSString *)title clickAction:(SEL)clickAction ViewController:(id)viewController;

@end

@interface UITextField (Helper)
/**
 *   placeholder :       提示文字
 *   font :            字体
 *   textColor  :           文字颜色
 *   horderColor :       提示文字颜色
 *   lineColor :      底部分割线颜色
 *   tfType:    输入框样式
 */
+(UITextField *)textFieldWithPlaceholder:(NSString *)placeholder
                                    Font:(UIFont *)font
                               TextColor:(UIColor *)textColor
                             HorderColor:(UIColor *)horderColor
                         BottomLineColor:(UIColor *)lineColor
                                  TfType:(UITextAutocorrectionType)tfType;

+ (UITextField *)textFieldWithRect:(CGRect)rect
                              text:(NSString *)text
                       placeholder:(NSString *)placeholder
                         textColor:(UIColor *)textColor
                          fontSize:(CGFloat)fontSize
                     textAlignment:(NSTextAlignment)textAlignment;

- (NSRange) selectedRange;
- (void) setSelectedRange:(NSRange) range;

@end

@interface UIButton (Helper)

+(UIButton *)buttonWithImage:(UIImage *)image
                highLightImg:(UIImage *)highLightImg
                     BGColor:(UIColor *)bgColor
                 clickAction:(SEL)clickAction
              viewController:(id)viewController
                cornerRadius:(CGFloat)radius;
/**
 *   title :             文字
 *   font :            字体
 *   titleColor  :           文字颜色
 *   bgColor :       背景颜色
 *   clickAction :      响应事件
 *   viewController:    控制器
 *   radius   :          圆角
 */
+(UIButton *)buttonWithTitle:(NSString *)title
                        font:(UIFont *)font
                  TitleColor:(UIColor *)titleColor
                     BGColor:(UIColor *)bgColor
                 clickAction:(SEL)clickAction
              viewController:(id)viewController
                cornerRadius:(CGFloat)radius;
/**
 *   rect :             按钮尺寸位置
 *   title :            文字
 *   color  :           文字颜色
 *   imageColor :       图片颜色
 *   clickAction :      响应事件
 *   viewController:    控制器
 *   font   :           字体大小
 *   contentEdgeInsets :内容内边距
 *   radius   :         圆角
 */
+ (UIButton *)ButtonWithRect:(CGRect)rect
                       title:(NSString *)title
                  titleColor:(UIColor *)color
    BackgroundImageWithColor:(UIColor *)imageColor
                 clickAction:(SEL)clickAction
              viewController:(id)viewController
                   titleFont:(CGFloat)font contentEdgeInsets:(UIEdgeInsets )contentEdgeInsets;
/**
 *    rect              按钮尺寸位置
 *    title             文字
 *    color             文字颜色
 *    imageColor        图片颜色
 *    clickAction       响应事件
 *    viewController    控制器
 *    font              字体大小
 *    contentEdgeInsets 内容内边距
 */
+ (UIButton *)ButtonWithRect:(CGRect)rect
                       title:(NSString *)title
                  titleColor:(UIColor *)color
    BackgroundImageWithColor:(UIColor *)imageColor
                 clickAction:(SEL)clickAction
              viewController:(id)viewController
                   titleFont:(CGFloat)font contentEdgeInsets:(UIEdgeInsets )contentEdgeInsets cornerRadius:(float)radius;

/**
 *    rect            按钮尺寸位置
 *    title           文字
 *    color           文字颜色
 *    clickAction     响应事件
 *    image           按钮图片
 *    viewController  控制器
 *    font            字体大小
 *    titleEdgeInsets 文字内边距
 */
+ (UIButton *)ButtonWithRect:(CGRect)rect
                       title:(NSString *)title
                  titleColor:(UIColor *)color
                 clickAction:(SEL)clickAction
                       image:(NSString *)image
              viewController:(id)viewController
                   titleFont:(CGFloat)font
             titleEdgeInsets:(UIEdgeInsets )titleEdgeInsets;
@end

@interface UIImageView (Helper)
+ (UIImageView *)ImageViewWithRect:(CGRect)rect imageName:(NSString *)name tag:(int )tag parentId:(id)body;

- (void)fillImage;
- (void)changeCircleCornerRadius:(CGFloat )cornerRadius andborderWidth:(CGFloat)width;
- (UIImage *)imageWithColor:(UIColor *)color image:(NSString *)image;
- (UIImage *)imageWithColor:(UIColor *)color UIImage:(UIImage *)image;

@end





@interface UIImage (Helper)
//根据给定宽度 按比例缩放图片
+ (UIImage *)IMGCompressed:(UIImage *)o_image targetWidth:(CGFloat)width;
/**
 纯色UIImage
 */
+ (UIImage *)imageWithColor:(UIColor *)color;
/**
 剪切图片，从图片中心向边缘最大区域
 */
+ (UIImage *)getCutImageSize:(CGSize)size
               originalImage:(UIImage *)originalImage;

+(UIImage *)setNewImage:(NSString *)name;

/**
 修改图片处理后旋转的问题
 */
+ (UIImage *)fixOrientation:(UIImage *)aImage;

@end

@interface NSDate (Helper)

+ (NSDate *)FromString:(NSString *)string;


+ (NSDate*) convertDateFromString:(NSString*)uiDate;
@end



@interface UITableView (Helper)

- (void)UIEdgeInsetsZero;

@end


@interface UITableViewCell(Helper)

- (void)setEdgeInsetsZero;

@end
