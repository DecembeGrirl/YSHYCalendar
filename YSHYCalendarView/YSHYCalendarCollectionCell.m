//
//  YSHYCalendarCollectionCell.m
//  YSHYCalendar
//
//  Created by 杨淑园 on 2017/5/3.
//  Copyright © 2017年 杨淑园. All rights reserved.
//

#import "YSHYCalendarCollectionCell.h"

@implementation YSHYCalendarCollectionCell

-(instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        backGroudView = [[UIView alloc]initWithFrame:CGRectMake(CELL_WIDTH / 2 - 16, 1, 32, 32)];
        [self addSubview:backGroudView];
        
        backgroundViewLayer = [CAShapeLayer layer];
        UIBezierPath * path = [UIBezierPath bezierPathWithRoundedRect:backGroudView.bounds cornerRadius:20];
        backgroundViewLayer.fillColor = [UIColor  whiteColor].CGColor;
        backgroundViewLayer.path = path.CGPath;
        [backGroudView.layer addSublayer:backgroundViewLayer];
        
         todayLayer = [CAShapeLayer layer];
        UIBezierPath * path1 = [UIBezierPath bezierPathWithRoundedRect:backGroudView.bounds cornerRadius:20];
        path1.lineWidth = 0.5f;
        path1.lineCapStyle = kCGLineCapRound;
        path1.lineJoinStyle = kCGLineJoinRound;
        todayLayer.path = path1.CGPath;
        todayLayer.fillColor = [UIColor clearColor].CGColor;
        [backGroudView.layer addSublayer:todayLayer];
        
        
        _dataLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, CELL_WIDTH, CELL_WIDTH - 20)];
        [_dataLab setTextAlignment:NSTextAlignmentCenter];
        _dataLab.font = [UIFont fontWithName:@"Helvetica" size:16];
        [self addSubview:_dataLab];
        
        descrpLab = [[UILabel alloc]initWithFrame:CGRectMake(0, CELL_WIDTH-20, CELL_WIDTH , 15)];
        [descrpLab setFont:[UIFont fontWithName:@"Helvetica" size:10]];
        [descrpLab setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:descrpLab];
    }
    
    return self;

}

-(void)configData:(id)data
{
    _dataLab.text =(NSString *)data;
}

-(void)clearData
{
    _dataLab.text = @"";
    [self cancelSelectedCell];
    
}

-(void)setTodayFlag
{
   todayLayer.strokeColor = [UIColor redColor].CGColor;
}

-(void)notTodayFlag
{
    todayLayer.strokeColor = [UIColor whiteColor].CGColor;
}

-(void)selectedCell
{
    _selecetd = YES;
    backgroundViewLayer.fillColor = [UIColor blackColor].CGColor;
    _dataLab.font = [UIFont fontWithName:@"Helvetica" size:20];
    [_dataLab setTextColor:[UIColor whiteColor]];
}

-(void)cancelSelectedCell
{
    _selecetd = NO;
    backgroundViewLayer.fillColor = [UIColor whiteColor].CGColor;
    _dataLab.font = [UIFont fontWithName:@"Helvetica" size:16];
    [_dataLab setTextColor:[UIColor blackColor]];
    
}


@end
