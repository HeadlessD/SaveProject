//
//  ATPnChartsTool.m
//  AvanTSampleManeger
//
//  Created by 罗艺 on 2017/12/25.
//  Copyright © 2017年 罗艺. All rights reserved.
//

#import "ATPnChartsTool.h"
#import <PNLineChart.h>
#import <PNBarChart.h>
#import <PNLineChartData.h>
#import <PNLineChartDataItem.h>
@implementation ATPnChartsTool

+(instancetype)getInstance{
    static ATPnChartsTool*tool;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tool=[[ATPnChartsTool alloc]init];
    });
    return tool;
}

-(PNLineChart*)getLinChartWithData:(NSArray*)arr andFrame:(CGRect)frame{
    PNLineChart * lineChart = [[PNLineChart alloc] initWithFrame:frame];
    [lineChart setXLabels:arr];
    
    // Line Chart No.1
    NSArray * data01Array = @[@60.1, @160.1, @126.4, @262.2, @186.2];
    PNLineChartData *data01 = [PNLineChartData new];
    data01.color = PNFreshGreen;
    
    data01.itemCount = lineChart.xLabels.count;
    data01.getData = ^(NSUInteger index) {
        CGFloat yValue = [data01Array[index] floatValue];
        return [PNLineChartDataItem dataItemWithY:yValue];
    };
    // Line Chart No.2
    NSArray * data02Array = @[@20.1, @180.1, @26.4, @202.2, @126.2];
    PNLineChartData *data02 = [PNLineChartData new];
    data02.color = PNTwitterColor;
    data02.itemCount = lineChart.xLabels.count;
    data02.getData = ^(NSUInteger index) {
        CGFloat yValue = [data02Array[index] floatValue];
        return [PNLineChartDataItem dataItemWithY:yValue];
    };
    
    lineChart.chartData = @[data01, data02];
    [lineChart strokeChart];
    
    return lineChart;
}

-(PNBarChart*)getBarChartWithArr:(NSArray*)arr andFrame:(CGRect)frame{
    PNBarChart * barChart = [[PNBarChart alloc] initWithFrame:frame];
    [barChart setXLabels:@[@"SEP 1",@"SEP 2",@"SEP 3",@"SEP 4",@"SEP 5"]];
    [barChart setYValues:@[@1,  @10, @2, @6, @3]];
    barChart.barBackgroundColor=[UIColor clearColor];
    barChart.isShowNumbers=NO;
    barChart.isGradientShow=YES;
    [barChart setChartMarginTop:4];
    [barChart strokeChart];
    return barChart;
}



@end
