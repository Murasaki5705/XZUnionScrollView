//
//  TopScrollView.m
//  联动ScrollView
//
//  Created by XinZhi on 15/10/21.
//  Copyright (c) 2015年 Murasaki. All rights reserved.
//

#import "TopScrollView.h"

#define TEXTBUTTONWIDTH 100
#define TEXTBUTTONHIGH 30

@interface TopScrollView ()
{
    UIView *_lineIndicator;
}

@end

@implementation TopScrollView

#pragma mark - 初始化方法
+ (instancetype)topScrollView{

    return [[self alloc]initWithFrame:CGRectZero];
}

- (instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        
        self.tagButtonArray = [NSMutableArray new];
        
        self.backgroundColor = [UIColor cyanColor];
        self.rowHigh = 40;
    }
    
    return self;
}

#pragma mark - set方法
- (void)setTagArray:(NSArray *)tagArray{

    _tagArray = tagArray;
    
    self.contentSize = CGSizeMake(tagArray.count*TEXTBUTTONWIDTH, TEXTBUTTONHIGH);
    self.showsHorizontalScrollIndicator = NO;
    self.showsVerticalScrollIndicator = NO;
    
    for (int i = 0; i < tagArray.count; i++) {
        
        // 设置button
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        CGFloat buttonX = i*TEXTBUTTONWIDTH;
        CGFloat buttonY = (self.rowHigh-TEXTBUTTONHIGH)/2;
        
        button.frame = CGRectMake(buttonX, buttonY, TEXTBUTTONWIDTH, TEXTBUTTONHIGH);
        button.tag = i;
        
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitle:tagArray[i] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        
        [self.tagButtonArray addObject:button];
        [self addSubview:button];
        
        [button addTarget:self action:@selector(tagClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            
            // 设置view
            CGFloat lineH = 2;
            CGFloat lineW = button.frame.size.width;
            CGFloat lineX = 0;
            CGFloat lineY = self.bounds.size.height-lineH;
            
            _lineIndicator = [[UIView alloc]initWithFrame:CGRectMake(lineX, lineY, lineW, lineH)];
            _lineIndicator.backgroundColor = [UIColor redColor];
            [self addSubview:_lineIndicator];
        });
    }
}

- (void)tagClicked:(UIButton *)button{
    
    [UIView animateWithDuration:0.2 animations:^{
        
        _lineIndicator.frame = CGRectMake(button.frame.origin.x, _lineIndicator.frame.origin.y, _lineIndicator.frame.size.width, _lineIndicator.frame.size.height);
    }];
    
    // 比较左边
    CGFloat leftOffsetX = self.contentOffset.x - button.frame.origin.x;
    
    if (leftOffsetX > 0) {
        
        [UIView animateWithDuration:0.2 animations:^{
            
            [self setContentOffset:CGPointMake((self.contentOffset.x - leftOffsetX), 0)];
        }];
    }

    // 比较右边
    CGFloat rightOffsetX = (self.contentOffset.x+self.frame.size.width) - (button.frame.origin.x + button.frame.size.width);
    
    if (rightOffsetX < 0) {
        
        [UIView animateWithDuration:0.2 animations:^{
            
            [self setContentOffset:CGPointMake((self.contentOffset.x - rightOffsetX), 0)];
        }];
    }
    
    if (self.tapBlock) {
        
        self.tapBlock((int)button.tag);
    }
}

@end
