//
//  BottomScrollView.m
//  联动ScrollView
//
//  Created by XinZhi on 15/10/22.
//  Copyright (c) 2015年 Murasaki. All rights reserved.
//

#import "BottomScrollView.h"

#import "TableView.h"

@interface BottomScrollView()<UIScrollViewDelegate>
{
    NSMutableArray *_viewArray;
    NSMutableArray *_viewInitArray;
}

@end

@implementation BottomScrollView

+ (instancetype)bottomScrollView{

    return [[self alloc]init];
}

- (instancetype)init{

    if (self = [super init]) {
        
        _viewArray = [NSMutableArray array];
        _viewInitArray = [NSMutableArray array];
    }
    
    return self;
}

- (void)setTagArray:(NSArray *)tagArray{
    
    _tagArray = tagArray;
    
    self.pagingEnabled = YES;
    self.bounces = NO;
    self.delegate = self;
    
    self.contentSize = CGSizeMake(self.bounds.size.width * tagArray.count, self.bounds.size.height);
    _viewArray = [[NSMutableArray alloc]initWithCapacity:tagArray.count];
    
    for (int i = 0; i < tagArray.count; i++){
    
        [_viewInitArray addObject:@"0"];
    
    }
}

- (void)setDataArray:(NSArray *)dataArray{

    _dataArray = dataArray;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        if (dataArray > 0) {
            TableView *tableView = [[TableView alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
            tableView.dataArray = @[dataArray[0]];
            
            [self addSubview:tableView];
            [_viewArray addObject:tableView];
        }
        _viewInitArray[0] = @"1";
    });
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    int page = self.contentOffset.x / self.bounds.size.width;
    
    [self pageInit:page];
    
    if (self.flipBlock) {
        
        self.flipBlock(page);
    }
}

- (void)pageInit:(int)page{
        
    if ([_viewInitArray[page] isEqualToString:@"0"]) {
        
        TableView *tableView = [[TableView alloc]initWithFrame:CGRectMake(self.contentOffset.x, self.contentOffset.y, self.bounds.size.width, self.bounds.size.height)];
        tableView.dataArray = @[self.dataArray[page]];
        
        [self addSubview:tableView];
        
        _viewInitArray[page] = @"1";
        [_viewArray addObject:tableView];
    }
}

@end
