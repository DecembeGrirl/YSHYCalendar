//
//  ViewController.m
//  YSHYCalendar
//
//  Created by 杨淑园 on 2017/5/3.
//  Copyright © 2017年 杨淑园. All rights reserved.
//

#import "ViewController.h"
#import "YSHYCalendarView.h"
@interface ViewController ()<YSHYCalendarViewDelegate,UIPickerViewDelegate,UIPickerViewDataSource>
{
    YSHYCalendarView * calendarView;
    UIButton * dateBtn;
    NSDateFormatter * formatter;
    UIPickerView * myPickerView;
    UIView * pickerTopView;
    
    NSMutableArray *yearsArr;
    NSMutableArray *monthsArr;
    
    NSDate * curretnDate;
    NSDate * todayDate;
    
    NSInteger daysOfMonth;
    NSInteger startYear;
    NSInteger yearIndex;
    NSInteger monthIndex;
    NSInteger dayIndex;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    curretnDate = [NSDate date];
    todayDate = curretnDate;
    formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy年MM月dd日"];
    NSString * str = [formatter stringFromDate:curretnDate];
    
    calendarView = [[YSHYCalendarView alloc]initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, 300)];
    calendarView.delegate = self;
    calendarView.currentDate = curretnDate;
    [self.view addSubview:calendarView];
    [calendarView configDateWith:curretnDate];
    
    dateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [dateBtn setFrame:CGRectMake(0, 20, self.view.bounds.size.width, 30)];
    [dateBtn setTitleColor:[UIColor magentaColor] forState:UIControlStateNormal];
    [dateBtn setTitle:str forState:UIControlStateNormal];
    [dateBtn addTarget:self action:@selector(showPickerView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:dateBtn];
    
    pickerTopView = [[UIView alloc]init];
    [pickerTopView setFrame:CGRectMake(0, self.view.bounds.size.height - 140, self.view.bounds.size.width, 20)];
    [self.view addSubview:pickerTopView];
    UIButton * comfirBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [comfirBtn setFrame:CGRectMake(self.view.bounds.size.width - 50, 0, 40, 20)];
    [comfirBtn setTitle:@"确认" forState:UIControlStateNormal];
    [comfirBtn addTarget:self action:@selector(clickComfirmBtn) forControlEvents:UIControlEventTouchUpInside];
    pickerTopView.hidden = YES;
    [pickerTopView addSubview:comfirBtn];
    
    
    UIButton * backTodayBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backTodayBtn setFrame:CGRectMake(self.view.bounds.size.width / 2 - 40, 0, 80, 20)];
    [backTodayBtn addTarget:self action:@selector(clickbackTodayBtn) forControlEvents:UIControlEventTouchUpInside];
    [backTodayBtn setTitle:@"回到今日" forState:UIControlStateNormal];
    [backTodayBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [pickerTopView addSubview:backTodayBtn];
    
    
    myPickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, self.view.bounds.size.height - 120, self.view.bounds.size.width, 120)];
    myPickerView.delegate = self;
    myPickerView.dataSource = self;
    myPickerView.hidden = YES;
    [self.view addSubview:myPickerView];
    [self getdata];
}


#pragma mark ------------YSHYCalendarViewDelegate-----------
-(void)selectedADay:(NSDate *)date
{
    NSString * str = [formatter stringFromDate:date];
    [dateBtn setTitle:str forState:UIControlStateNormal];
}

#pragma mark -------------UIPickerViewDelegate-------------
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if(component == 0)
    {
        return 100;
    }
    else if(component == 1)
    {
        return 12;
    }
    else
    {
        return  daysOfMonth;
    }
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if(component == 0)
    {
        return [NSString stringWithFormat:@"%ld",startYear + row];
    }else if(component == 1)
    {
        return [NSString stringWithFormat:@"%ld",row+1];
    }else
    {
        return [NSString stringWithFormat:@"%ld",row+1];
    }
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if(component == 0)
    {
        yearIndex = row;
        [self getDaysInMonth];
        [myPickerView reloadComponent:2];
    }
    else if(component == 1)
    {
        monthIndex = row+1;
        [self getDaysInMonth];
        [myPickerView reloadComponent:2];
    }
    else
    {
        dayIndex = row+1;
        NSLog(@"%ld",dayIndex);
    }

}


-(void)getdata
{
    startYear = 1951;
    [self initPickerViewWith:curretnDate];
}


-(void)clickComfirmBtn
{
    [self hiddenPickerView];
    NSString * dateStr = [NSString stringWithFormat:@"%ld年%ld月%ld日",yearIndex+startYear,monthIndex,dayIndex];
    NSString * date1Str = [NSString stringWithFormat:@"%ld年%ld月%d日",yearIndex+startYear,monthIndex,1];
    NSDate *tempDate = [formatter dateFromString:date1Str];
    curretnDate = [formatter dateFromString:dateStr];
    [dateBtn setTitle:dateStr forState:UIControlStateNormal];
    NSInteger firstDayWeek = [[calendarView.manager getWeekDayWith:tempDate] integerValue];
    NSInteger firstDayIndex = [calendarView.manager getFirstDayIndexWith:firstDayWeek];
    
    NSInteger row = (firstDayIndex + daysOfMonth) / 7;
    
    row = (firstDayIndex + daysOfMonth) % 7?row +1:row;
    [calendarView setFrame:CGRectMake(0, 64, self.view.bounds.size.width, row* [UIScreen mainScreen].bounds.size.width / 7 + 20)];
    [calendarView resetCollectionviewFrame];
    [calendarView configDateWith:curretnDate];
}

-(void)clickbackTodayBtn
{
    [self hiddenPickerView];
    curretnDate = todayDate;
    NSString * dateStr = [formatter stringFromDate:curretnDate];
    [dateBtn setTitle:dateStr forState:UIControlStateNormal];
    NSInteger row = (calendarView.firstDayIndex + daysOfMonth) / 7;
    
    row = (calendarView.firstDayIndex + daysOfMonth) % 7?row:row +1;
    [calendarView setFrame:CGRectMake(0, 64, self.view.bounds.size.width, row* [UIScreen mainScreen].bounds.size.width / 7)];
    [calendarView configDateWith:curretnDate];
}

-(void)showPickerView
{
    pickerTopView.hidden = NO;
    myPickerView.hidden = NO;
    [self initPickerViewWith:curretnDate];
}

-(void)hiddenPickerView
{
    pickerTopView.hidden = YES;
    myPickerView.hidden = YES;
}

-(void)getDaysInMonth
{
    NSString * dateStr = [NSString stringWithFormat:@"%ld年%ld月%@日",yearIndex+startYear,monthIndex,@"1"];
    curretnDate = [formatter dateFromString:dateStr];
    NSRange range = [calendarView.manager.calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:curretnDate];
    if(dayIndex == daysOfMonth && daysOfMonth > range.length)
    {
        [myPickerView selectRow:range.length inComponent:2 animated:NO];
        dayIndex = range.length;
    }
    daysOfMonth = range.length;
    
}
-(void)initPickerViewWith:(NSDate *)date
{
    NSRange range = [calendarView.manager.calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
    daysOfMonth = range.length;
    NSDateComponents * comps =  [calendarView.manager.calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:date];
    yearIndex = comps.year - startYear;
    monthIndex = comps.month ;
    dayIndex = comps.day;

    [myPickerView reloadAllComponents];
    [myPickerView selectRow:yearIndex inComponent:0 animated:NO];
    [myPickerView selectRow:monthIndex-1 inComponent:1 animated:NO];
    [myPickerView selectRow:dayIndex-1 inComponent:2 animated:NO];

}

// 电子价签
// ERM 结算 审批

@end
