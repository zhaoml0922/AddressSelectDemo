//
//  CityView.m
//  aa
//
//  Created by zhaoml on 2018/3/21.
//  Copyright © 2018年 赵明亮. All rights reserved.
//

#import "CityView.h"


@interface CityView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *listView;
@end


@implementation CityView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self creatUI];
    }
    return self;
}

- (void)creatUI {
    _listView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
    _listView.delegate = self;
    _listView.dataSource = self;
    _listView.backgroundColor = [UIColor whiteColor];
    _listView.separatorColor = [UIColor clearColor];
    [self addSubview:_listView];
}

- (void)setDataArr:(NSArray *)dataArr {
    _dataArr = dataArr;
    [_listView reloadData];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"provinceList"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"provinceList"];
    }
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    if (_dataArr.count!= 0) {
        NSArray *arr = [_dataArr[indexPath.row] allKeys];
        NSString *str = [arr firstObject];
        cell.textLabel.text = str;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath  {
    return 45;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dict = _dataArr[indexPath.row];
    NSArray *arr = [dict allKeys];
    NSString *str = [arr firstObject];
    [self.delegate backCity:str andDistrictArray:dict[str]];
}

- (NSMutableArray *)backArrOfDic:(NSMutableDictionary *)dict {
    NSMutableArray *arr = [NSMutableArray array];
    for (int i=0; i<dict.allKeys.count; i++) {
        [arr addObject:dict[[NSString stringWithFormat:@"%d",i]]];
    }
    return arr;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


@end
