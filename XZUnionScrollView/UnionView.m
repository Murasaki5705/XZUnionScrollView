//
//  UnionScrollView.m
//  联动ScrollView
//
//  Created by XinZhi on 15/10/22.
//  Copyright (c) 2015年 Murasaki. All rights reserved.
//

#import "UnionView.h"

#import "TopScrollView.h"
#import "BottomScrollView.h"

@interface UnionView ()<UIScrollViewDelegate>

@property (nonatomic, strong) BottomScrollView *bottomScrollView;
@property (nonatomic, strong) TopScrollView *topScrollView;

@end

@implementation UnionView

+ (instancetype)unionView{

    return [[self alloc]initWithFrame:CGRectZero];
}

- (instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
    
        _topScrollView = [TopScrollView topScrollView];
        [self addSubview:_topScrollView];
        
        _bottomScrollView = [BottomScrollView bottomScrollView];
        [self addSubview:_bottomScrollView];
    }
    
    return self;
}

- (void)setTagArray:(NSArray *)tagArray{

    _tagArray = tagArray;
    
    _topScrollView.tagArray = tagArray;
    _bottomScrollView.tagArray = tagArray;

    // block TopScrollView点击事件
    __weak typeof (self) ws = self;
    [_topScrollView setTapBlock:^(int page) {
        
        [UIView animateWithDuration:0.2 animations:^{
            
            [ws.bottomScrollView setContentOffset:CGPointMake(page * _bottomScrollView.bounds.size.width, 0)];
        }];
        
        [ws.bottomScrollView pageInit:page];
    }];
    
    [_bottomScrollView setFlipBlock:^(int page) {
       
        UIButton *button = ws.topScrollView.tagButtonArray[page];
        [ws.topScrollView tagClicked:button];
    }];
}

- (void)setDataArray:(NSArray *)dataArray{

    _dataArray = dataArray;
    
    self.bottomScrollView.dataArray = dataArray;
}

- (void)willMoveToSuperview:(UIView *)newSuperview{

    self.frame = newSuperview.frame;
    
    _topScrollView.frame = CGRectMake(0, 64, self.frame.size.width, 40);
    _bottomScrollView.frame = CGRectMake(0, _topScrollView.frame.origin.y+_topScrollView.bounds.size.height, self.frame.size.width, self.bounds.size.height-_topScrollView.bounds.size.height);
}

@end
