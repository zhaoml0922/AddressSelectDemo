//
//  DistrictView.m
//  aa
//
//  Created by zhaoml on 2018/3/21.
//  Copyright © 2018年 赵明亮. All rights reserved.
//

#import "DistrictView.h"

@interface DistrictView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *listView;
@end


@implementation DistrictView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

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
        NSString *str = _dataArr[indexPath.row];
        cell.textLabel.text = str;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath  {
    return 45;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *str =_dataArr[indexPath.row];
    [self.delegate backDistrict:str];
}

@end
