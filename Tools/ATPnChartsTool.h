//
//  ATPnChartsTool.h
//  AvanTSampleManeger
//
//  Created by 罗艺 on 2017/12/25.
//  Copyright © 2017年 罗艺. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <PNChart.h>
@interface ATPnChartsTool : NSObject
+(instancetype)getInstance;
-(PNLineChart*)getLinChartWithData:(NSArray*)arr andFrame:(CGRect)frame;
-(PNBarChart*)getBarChartWithArr:(NSArray*)arr andFrame:(CGRect)frame;
@end
