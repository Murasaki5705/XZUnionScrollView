//
//  TableViewType.m
//  联动ScrollView
//
//  Created by XinZhi on 15/10/22.
//  Copyright (c) 2015年 Murasaki. All rights reserved.
//

#import "TableView.h"

@interface TableView () <UITableViewDataSource>

@end

@implementation TableView

- (void)setDataArray:(NSArray *)dataArray{
    
    _dataArray = dataArray;
    self.dataSource = self;
}

- (instancetype)init{

    if (self = [super init]) {
        
    }
    return self;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (!cell) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    cell.textLabel.text = self.dataArray[indexPath.row];
    
    return cell;
}

@end
