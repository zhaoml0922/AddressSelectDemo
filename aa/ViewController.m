//
//  ViewController.m
//  aa
//
//  Created by zhaoml on 2018/3/5.
//  Copyright © 2018年 赵明亮. All rights reserved.
//

#import "ViewController.h"
#import "SelectCityView.h"
#import "BMSelectAreaView.h"
#import "MLAlertCenter.h"
@interface ViewController ()<SelectAreaDelegate,SelectCityDelegate>

@property (nonatomic,strong)SelectCityView *sView;
@property (nonatomic, strong) BMSelectAreaView *aView;
@end

@implementation ViewController

- (BMSelectAreaView *)aView {
    if (!_aView) {
        _aView = [[BMSelectAreaView alloc] init];
        _aView.delegate = self;
    }
    return _aView;
}

- (SelectCityView *)sView {
    if (!_sView) {
        _sView = [[SelectCityView alloc] init];
        _sView.delegate = self;
    }
    return _sView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *arr = @[@"pickerView",@"CustomView"];
    for (int i=0; i<2; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        button.frame = CGRectMake(20, 30+80*i, SCREEN_WIDTH-40, 50);
        [button setTitle:arr[i] forState:UIControlStateNormal];
        button.tag = 100+i;
        [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
    }
    
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)btnClick:(UIButton *)btn {
    if (btn.tag == 100) {
        [self.aView show];
    }else{
        [self.sView show];
    }
}


- (void)selectAreaName:(NSString *)areaName {
    [[MLAlertCenter defaultCenter] postAlertWithContent:[NSString stringWithFormat:@"您选择的地址是：%@",areaName]];
}

- (void)selectCityWithName:(NSString *)name {
    [[MLAlertCenter defaultCenter] postAlertWithContent:[NSString stringWithFormat:@"您选择的地址是：%@",name]];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
