//
//  NSString+FormatTime.m
//  NextDoor
//
//  Created by 豆凯强 on 2017/4/23.
//  Copyright © 2017年 豆凯强. All rights reserved.
//

#import "NSString+FormatTime.h"

@implementation NSString (FormatTime)
+(NSString*)formTimeWithStr:(NSString*)form andDateStr:(NSString*)str{
    if (form==nil) {
        form=@"yyyy-MM-ddTHH:mm:ss";
    }
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:form];
    NSDate *date = [dateFormatter dateFromString:str];
   return [dateFormatter stringFromDate:date];
}
@end
