//
//  YSHYCalendarCollectionCell.h
//  YSHYCalendar
//
//  Created by 杨淑园 on 2017/5/3.
//  Copyright © 2017年 杨淑园. All rights reserved.
//

#import <UIKit/UIKit.h>

#define  CELL_WIDTH [UIScreen mainScreen].bounds.size.width / 7
@interface YSHYCalendarCollectionCell : UICollectionViewCell
{
    UILabel * descrpLab;
    UIView * backGroudView;
    CAShapeLayer * backgroundViewLayer;
    CAShapeLayer * todayLayer;
}
@property (nonatomic, strong)UILabel * dataLab;
@property (nonatomic, assign) BOOL selecetd;

-(void)configData:(id)data;
-(void)clearData;
-(void)setTodayFlag;
-(void)notTodayFlag;
-(void)selectedCell;
-(void)cancelSelectedCell;
@end
