//
//  TopScrollView.h
//  联动ScrollView
//
//  Created by XinZhi on 15/10/21.
//  Copyright (c) 2015年 Murasaki. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TopScrollView : UIScrollView

@property (nonatomic, copy) NSArray *tagArray;
@property (nonatomic, strong) NSMutableArray *tagButtonArray;

@property (nonatomic, assign) CGFloat rowHigh;
@property (nonatomic, copy) void (^tapBlock)(int page);

+ (instancetype)topScrollView;

- (void)tagClicked:(UIButton *)button;

@end
