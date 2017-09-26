//
//  YSHYCalendarManager.h
//  YSHYCalendar
//
//  Created by 杨淑园 on 2017/5/4.
//  Copyright © 2017年 杨淑园. All rights reserved.
//

#import <Foundation/Foundation.h>

//#define CHINESE_MONTHS @[@"正月",@"二月",@"三月",@"四月",@"五月",@"六月",@"七月",@"八月",@"九月",@"十月",@"十一月",@"十二月"]
//
//#define CHINESE_FESTIVAL_TRANDINAL @[@"春节",@"元宵",@"端午",@"七夕",@"中元",@"中秋",@"重阳",@"腊八",@"小年"]
//#define CHINESE_FESTICAL @[@"元旦",@"情人节",@"妇女节",@"愚人节",@"劳动节",@"青年节",@"儿童节",@"建军节",@"教师节",@"国庆节",@""]


@interface YSHYCalendarManager : NSObject
@property (nonatomic, strong) NSCalendar * calendar;
@property (nonatomic, strong) NSDateFormatter * formatter;

-(NSInteger)getNumberOfDaysInCurretnMonth;
-(NSInteger)getNumberOfDaysInMonthWithDate:(NSDate *)currentDate;
-(id)getWeekDayWithCurrentDate;
-(id)getWeekDayWith:(NSDate*)date;
-(NSArray *)getWeeksDayInMonthWith:(NSDate *)date;
-(NSArray *)getWeeksDayInMonthWithCurrentDate;
-(NSInteger)getDayWith:(NSDate *)date;
-(NSInteger)getMonthWith:(NSDate *)date;
-(NSInteger)getYearWith:(NSDate *)date;
-(NSInteger)getFirstDayIndexWith:(NSInteger)week;
@end
