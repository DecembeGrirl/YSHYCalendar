//
//  YSHYCalendarManager.m
//  YSHYCalendar
//
//  Created by 杨淑园 on 2017/5/4.
//  Copyright © 2017年 杨淑园. All rights reserved.
//

#import "YSHYCalendarManager.h"


@implementation YSHYCalendarManager

-(instancetype)init
{
    if(self = [super init])
    {
        _calendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        _formatter = [[NSDateFormatter alloc]init];
        [_formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh"]];
    }
    return  self;
}

-(NSInteger)getNumberOfDaysInCurretnMonth
{
    return  [self getNumberOfDaysInMonthWithDate:[NSDate date]];
}
// 计算一个月有多少天
-(NSInteger)getNumberOfDaysInMonthWithDate:(NSDate *)currentDate
{
    NSRange range = [_calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:currentDate];
    return range.length;
}
// 计算当前日期是周几
-(id)getWeekDayWithCurrentDate
{
    return [self getWeekDayWith:[NSDate date]];
}

// 计算当前日期是周几
-(id)getWeekDayWith:(NSDate*)date
{
    NSDateComponents * comps = [_calendar components:NSCalendarUnitWeekday fromDate:date];
    // 1是周日 2是周一  ....
    return@([comps weekday]);
}

//获取每个月中所有天数是周几
-(NSArray *)getWeeksDayInMonthWith:(NSDate *)date
{
    NSUInteger dayCount = [self getNumberOfDaysInMonthWithDate:date];
    [_formatter setDateFormat:@"yyyy-MM"];
    //  得到年月
    NSString * dateStr = [_formatter stringFromDate:date];
    [_formatter setDateFormat:@"yyyy-MM-dd"];
    
    NSMutableArray * allWeeks = [NSMutableArray arrayWithCapacity:dayCount];
    for (int i = 1; i <= dayCount; i++) {
        NSString * str = [NSString stringWithFormat:@"%@-%d",dateStr,i];
        NSDate* tempDate = [_formatter dateFromString:str];
        
        [allWeeks addObject:[self getWeekDayWith:tempDate]];
    }
    return allWeeks;
}
//获取当前日期所在月份 每天是周几
-(NSArray *)getWeeksDayInMonthWithCurrentDate
{
    return  [self getWeeksDayInMonthWith:[NSDate date]];
}

// 获取当前日期 是几号
-(NSInteger)getDayWith:(NSDate *)date
{
    NSDateComponents * comps = [_calendar componentsInTimeZone:[NSTimeZone systemTimeZone] fromDate:date];
    return comps.day;
}
// 获取当前月份
-(NSInteger)getMonthWith:(NSDate *)date
{
    NSDateComponents * comps = [_calendar componentsInTimeZone:[NSTimeZone systemTimeZone] fromDate:date];
    return comps.month;
}
// 获取当前年份
-(NSInteger)getYearWith:(NSDate *)date
{
    NSDateComponents * comps = [_calendar componentsInTimeZone:[NSTimeZone systemTimeZone] fromDate:date];
    return comps.year;
}
// 获取第一天所在的位置
-(NSInteger)getFirstDayIndexWith:(NSInteger)week
{
    if (week > 1) {
        return  week-2;
    }
    else
    {
        return  6;
    }
}



@end
