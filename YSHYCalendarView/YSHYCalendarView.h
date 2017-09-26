//
//  YSHYCalendarView.h
//  YSHYCalendar
//
//  Created by 杨淑园 on 2017/5/3.
//  Copyright © 2017年 杨淑园. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YSHYCalendarManager.h"
#import "YSHYCalendarCollectionCell.h"

@protocol YSHYCalendarViewDelegate <NSObject>

-(void)selectedADay:(NSDate *)date;

@end

@interface YSHYCalendarView : UIView<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    UIView * weeksView;   // 周标签
    UICollectionView * myCollectionView;
    
    NSArray * allWeeks;
    NSString * todayStr;     // 今天日期
    NSString * currentDateStr;   // 当前日期
    
    NSInteger currentDay; // 今天的是几号
     NSInteger currentMonth; // 今天的是几月
     NSInteger currentYear; // 今天的是哪一年
    YSHYCalendarCollectionCell * currentSelectedCell;  //当前选中的日期
}
@property (nonatomic, assign)NSInteger firstDayIndex; // 每月第一天的 起始位置
@property (nonatomic, strong) YSHYCalendarManager * manager;
@property (nonatomic, strong)NSDate * currentDate;
@property (nonatomic, weak) id<YSHYCalendarViewDelegate>delegate;

-(void)configDateWith:(NSDate *)date;
-(void)resetCollectionviewFrame;
@end
