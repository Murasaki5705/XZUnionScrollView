//
//  BottomScrollView.h
//  联动ScrollView
//
//  Created by XinZhi on 15/10/22.
//  Copyright (c) 2015年 Murasaki. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BottomScrollView : UIScrollView

@property (nonatomic, strong) NSArray *tagArray;
@property (nonatomic, strong) NSArray *dataArray;

@property (nonatomic, copy) void (^flipBlock)(int page);

+ (instancetype)bottomScrollView;

- (void)pageInit:(int)page;

@end
