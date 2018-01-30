//
//  HMSSleepPercentView.m
//  HealthMonitoringSystem
//
//  Created by gw on 2017/7/14.
//  Copyright © 2017年 mirahome. All rights reserved.
//

#import "HMSSleepPercentView.h"
#import "UICountingLabel.h"

#define LINE_WIDTH 4//环形宽度
#define DURATION 1.0//动画时间
#define TEXT_FONT 8.f
#define START_Angle -M_PI / 2.0
@interface HMSSleepPercentView ()

@property (nonatomic,assign) float      radius;
@property (nonatomic,assign) float      startAngle;

@property (nonatomic,assign) CGPoint    centerPoint;
@property (nonatomic,strong) UIColor    *cycleBgColor;


@property (nonatomic,strong) CAShapeLayer *lineLayer;
@property (nonatomic,strong) CATextLayer  *textLayer;
@property (nonatomic,strong) CAShapeLayer *pointLayer;

@property (nonatomic,strong) UICountingLabel *scoreLabel;
@end
@implementation HMSSleepPercentView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self initView];
    }
    return self;
}
-(void)awakeFromNib
{
    [super awakeFromNib];
    [self initView];
   
}

-(void)initView
{
    self.radius = CGRectGetWidth(self.frame) / 2.0 - LINE_WIDTH / 2.0;
    //    self.lineColor = HMSThemeColor;
    self.cycleBgColor =HMSThemeBackgroundColor;
    self.centerPoint = CGPointMake(CGRectGetWidth(self.frame) / 2.0, CGRectGetWidth(self.frame) / 2.0);
    self.startAngle =START_Angle;
    
    [self createBackLine];
    [self commonInit];
}

-(void)commonInit {
    [self createPercentLayer];
//    [self createPointLayer];
    //    [self setPercentTextLayer];
    [self setUpScoreTextLabel];
}

-(void)createBackLine {
    //绘制背景
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.lineWidth = LINE_WIDTH;
    shapeLayer.strokeColor = [self.cycleBgColor CGColor];
    //    shapeLayer.opacity = 0.2;
    shapeLayer.fillColor = [[UIColor clearColor] CGColor];
    UIBezierPath *path = [UIBezierPath new];
    [path addArcWithCenter:self.centerPoint radius:self.radius startAngle:-M_PI / 2.0 endAngle:M_PI / 2 * 3 clockwise:YES];
    shapeLayer.path = path.CGPath;
    [self.layer addSublayer:shapeLayer];
}

-(void)createPercentLayer {
    //绘制环形
    self.lineLayer = [CAShapeLayer layer];
    self.lineLayer.lineWidth = LINE_WIDTH;
    self.lineLayer.lineCap = kCALineCapRound;
    self.lineLayer.strokeColor = [self.lineColor CGColor];
    self.lineLayer.fillColor = [[UIColor clearColor] CGColor];
    UIBezierPath *path = [UIBezierPath new];
    [path addArcWithCenter:self.centerPoint radius:self.radius startAngle:self.startAngle endAngle:M_PI * 2 * self.percent + self.startAngle clockwise:YES];
    self.lineLayer.path = path.CGPath;
    CABasicAnimation *showAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    showAnimation.fromValue = @0;
    showAnimation.toValue = @1;
    showAnimation.duration = DURATION;
    showAnimation.removedOnCompletion = YES;
    showAnimation.fillMode = kCAFillModeForwards;
    [self.layer addSublayer:self.lineLayer];
    [self.lineLayer addAnimation:showAnimation forKey:@"kClockAnimation"];
}

-(void)createPointLayer {
    //头部小白点
    self.pointLayer = [CAShapeLayer layer];
    self.pointLayer.lineWidth = 1;
    self.pointLayer.strokeColor = [[UIColor whiteColor] CGColor];
    self.pointLayer.fillColor = [[UIColor whiteColor] CGColor];
    UIBezierPath *path = [UIBezierPath new];
    [path addArcWithCenter:CGPointMake(CGRectGetWidth(self.bounds) / 2.0, LINE_WIDTH / 2.0) radius:1 startAngle:- M_PI / 2.0 endAngle:M_PI / 2.0 * 3 clockwise:YES];
    self.pointLayer.path = path.CGPath;
    [self.layer addSublayer:self.pointLayer];
}

-(void)setPercentTextLayer {
    self.textLayer = [CATextLayer layer];
    self.textLayer.contentsScale = [[UIScreen mainScreen] scale];
    self.textLayer.string = [NSString stringWithFormat:@"%.2f%%",self.percent * 100];
    self.textLayer.bounds = self.bounds;
    self.textLayer.font = (__bridge CFTypeRef _Nullable)(@"HiraKakuProN-W3");
    self.textLayer.fontSize = TEXT_FONT;
    self.textLayer.alignmentMode = kCAAlignmentCenter;
    self.textLayer.position = CGPointMake(self.centerPoint.x, self.centerPoint.y + self.radius);
    self.textLayer.foregroundColor =
    [UIColor blackColor].CGColor;
    [self.layer addSublayer:self.textLayer];
}

-(void)setUpScoreTextLabel
{
    self.scoreLabel =[[UICountingLabel alloc]initWithFrame:CGRectMake(0, 0, self.width, 20)];
    [self addSubview:self.scoreLabel];
    self.scoreLabel.textAlignment =NSTextAlignmentCenter;
    self.scoreLabel.font =HMSFOND(13);
    self.scoreLabel.center =CGPointMake(self.width*0.5, self.height*0.5);
    self.scoreLabel.method = UILabelCountingMethodLinear;
    self.scoreLabel.format = @"%d%%";
    
    [self.scoreLabel countFrom:0 to:self.percent*100 withDuration:1];
    
    
}

-(void)reloadViewWithPercent:(float)percent {
    self.percent = percent;
    self.startAngle =START_Angle;
    [self.layer removeAllAnimations];
    [self.lineLayer removeFromSuperlayer];
    [self.pointLayer removeFromSuperlayer];
    [self.textLayer removeFromSuperlayer];
    
    [self.scoreLabel removeFromSuperview];
    [self commonInit];
}
-(void)reloadViewWithPercent:(float)percent withStartAngle:(CGFloat)startAngle
{
    self.percent = percent;
    self.startAngle = startAngle;
    [self.layer removeAllAnimations];
    [self.lineLayer removeFromSuperlayer];
    [self.pointLayer removeFromSuperlayer];
    [self.textLayer removeFromSuperlayer];
    [self.scoreLabel removeFromSuperview];
    
    [self commonInit];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
}
@end
