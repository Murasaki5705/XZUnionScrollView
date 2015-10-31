//
//  UnionScrollView.h
//  联动ScrollView
//
//  Created by XinZhi on 15/10/22.
//  Copyright (c) 2015年 Murasaki. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UnionView : UIView

// 顶部视图label
@property (nonatomic, strong) NSArray *tagArray;

// 底部视图(TableView)数据(网址)
@property (nonatomic, strong) NSArray *dataArray;

+ (instancetype)unionView;


@end
