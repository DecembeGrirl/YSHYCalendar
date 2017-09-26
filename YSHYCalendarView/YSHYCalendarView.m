//
//  YSHYCalendarView.m
//  YSHYCalendar
//
//  Created by 杨淑园 on 2017/5/3.
//  Copyright © 2017年 杨淑园. All rights reserved.
//

#import "YSHYCalendarView.h"

@implementation YSHYCalendarView
-(instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        NSArray * weeks = @[@"周一",@"周二",@"周三",@"周四",@"周五",@"周六",@"周日"];
        
        weeksView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, 20)];
        [self addSubview:weeksView];
        
        CGFloat width = self.frame.size.width / 7;
        for (int i = 0; i < 7; i++) {
            UILabel * lab = [[UILabel alloc]init];
            [lab setFrame:CGRectMake(width*i, 0, width, 20)];
            [lab setTextAlignment:NSTextAlignmentCenter];
            [lab setText:weeks[i]];
            lab.font = [UIFont fontWithName:@"Helvetica" size:10];
            [weeksView addSubview:lab];
        }
        
        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
        
        myCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 20, frame.size.width, frame.size.height - 20) collectionViewLayout:layout];
        myCollectionView.delegate = self;
        myCollectionView.dataSource = self;
        myCollectionView.backgroundColor = [UIColor whiteColor];
        [self addSubview:myCollectionView];
        
        [myCollectionView registerClass:[YSHYCalendarCollectionCell class] forCellWithReuseIdentifier:@"cellID"];
        _manager = [[YSHYCalendarManager alloc]init];
    }
    return  self;
}

-(void)configDateWith:(NSDate *)date
{
    [currentSelectedCell cancelSelectedCell];
    _currentDate = date;
    [_manager.formatter setDateFormat:@"yyyy-M-d"];
    currentDateStr = [_manager.formatter stringFromDate:_currentDate];
    todayStr = [_manager.formatter stringFromDate:[NSDate date]];
    allWeeks = [_manager getWeeksDayInMonthWith:_currentDate];
    currentYear = [_manager getYearWith:_currentDate];
    currentMonth = [_manager getMonthWith:_currentDate];
    currentDay = [_manager getDayWith:_currentDate];
    
    [myCollectionView reloadData];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSInteger count =  [_manager getNumberOfDaysInMonthWithDate:_currentDate];

    return  count += self.firstDayIndex;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    YSHYCalendarCollectionCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellID" forIndexPath:indexPath];
    if(indexPath.row >= _firstDayIndex)
    {
        NSInteger tempDay = indexPath.row - _firstDayIndex + 1;
        NSString * str = [NSString stringWithFormat:@"%ld",tempDay];
        NSString * tempDateStr = [NSString stringWithFormat:@"%ld-%ld-%ld",currentYear,currentMonth,tempDay];
        [cell configData:str];
         cell.selecetd = NO;
        cell.userInteractionEnabled = YES;
        if([currentDateStr isEqualToString:tempDateStr])
        {
            [cell selectedCell];
            currentSelectedCell = cell;
            if([tempDateStr isEqualToString:todayStr])
            {
                [cell setTodayFlag];
            }else
            {
                [cell notTodayFlag];
            }
        }
        else
        {
            [cell notTodayFlag];
        }
    }
    else
    {
        [cell clearData];
        cell.userInteractionEnabled = NO;
    }
    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(CELL_WIDTH, CELL_WIDTH);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    YSHYCalendarCollectionCell * cell = (YSHYCalendarCollectionCell *)[collectionView cellForItemAtIndexPath:indexPath];
    if(![cell isEqual:currentSelectedCell])
    {
        currentDay = [cell.dataLab.text integerValue];
        [currentSelectedCell cancelSelectedCell];
        [cell selectedCell];
        currentSelectedCell = cell;
        [_manager.formatter setDateFormat:@"yyyy-M-d"];
        NSString * str = [NSString stringWithFormat:@"%ld-%ld-%ld",(long)currentYear,(long)currentMonth,(long)currentDay];
         NSDate* tempDate = [_manager.formatter dateFromString:str];
        [self.delegate selectedADay:tempDate];
    }
}

-(NSInteger)firstDayIndex
{
    NSInteger weekOfFirstDay = [allWeeks[0] integerValue];
    
    _firstDayIndex = [self.manager getFirstDayIndexWith:weekOfFirstDay];
    return  _firstDayIndex;
}

-(void)resetCollectionviewFrame
{
    [myCollectionView  setFrame:CGRectMake(0, 20, self.frame.size.width, self.frame.size.height - 20)];
}

@end
