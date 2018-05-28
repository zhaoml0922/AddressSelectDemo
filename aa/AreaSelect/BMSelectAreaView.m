//
//  BMSelectAreaView.m
//  aa
//
//  Created by zhaoml on 2018/4/24.
//  Copyright © 2018年 赵明亮. All rights reserved.
//

#import "BMSelectAreaView.h"

@interface BMSelectAreaView()<UIPickerViewDataSource,UIPickerViewDelegate>

@property (nonatomic, strong) UIView *alpView;
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UIPickerView *pickerView;
@property (nonatomic, strong) NSMutableArray *proArray;
@property (nonatomic, strong) NSMutableArray *cityArray;
@property (nonatomic, strong) NSMutableDictionary *baseDic;
@end

@implementation BMSelectAreaView
{
    CGRect oldRect;
    CGRect showRect;
}
- (instancetype) init {
    self = [super init];
    if (self) {
        _proArray = [NSMutableArray array];
        _cityArray = [NSMutableArray array];
        oldRect = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 280);
        showRect = CGRectMake(0, SCREEN_HEIGHT - 280, SCREEN_WIDTH, 280);
        NSString *path = [[NSBundle mainBundle]pathForResource:@"area" ofType:@"plist"];
        _baseDic=[NSMutableDictionary dictionaryWithContentsOfFile:path];
        _proArray = [self backArrOfDic:_baseDic];
        [self creatUI];
    }
    return self;
}


- (void)creatUI {
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    
    _alpView = [[UIView alloc] initWithFrame:self.bounds];
    _alpView.alpha = 0.5;
    _alpView.backgroundColor = [UIColor blackColor];
    [self addSubview:_alpView];
    
    _backView = [[UIView alloc] initWithFrame:oldRect];
    _backView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_backView];
    
    _pickerView = [ [ UIPickerView alloc] initWithFrame:CGRectMake(0,30,SCREEN_WIDTH,oldRect.size.height - 30)];
    _pickerView.backgroundColor=[UIColor whiteColor];
    _pickerView.delegate=self;
    _pickerView.dataSource=self;
    [_backView addSubview:_pickerView];
    
    UIView *inputView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
    inputView.backgroundColor = [UIColor whiteColor];
    [_backView addSubview:inputView];
    
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    cancelBtn.frame=CGRectMake(0, 0, 60, 30);
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    cancelBtn.titleLabel.font=[UIFont systemFontOfSize:14];
    [cancelBtn addTarget:self action:@selector(cancelClick) forControlEvents:UIControlEventTouchUpInside];
    [inputView addSubview:cancelBtn];
    
    
    UIButton *suretimeBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    suretimeBtn.frame=CGRectMake(SCREEN_WIDTH-60, 0, 60, 30);
    [suretimeBtn setTitle:@"完成" forState:UIControlStateNormal];
    [suretimeBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    suretimeBtn.titleLabel.font=[UIFont systemFontOfSize:14];
    [suretimeBtn addTarget:self action:@selector(confirmDate) forControlEvents:UIControlEventTouchUpInside];
    [inputView addSubview:suretimeBtn];
 
}

-(void)cancelClick{
    
    [self hide];
}
-(void)confirmDate{
    NSString *selectStr = @"";
    if (_cityArray.count == 0) {
        NSInteger row = [_pickerView selectedRowInComponent:0];
        NSDictionary *dict = _proArray[row];
        NSArray *arr = [dict allKeys];
        selectStr = [arr firstObject];
    }else{
        NSInteger row = [_pickerView selectedRowInComponent:1];
        NSDictionary *dict = _cityArray[row];
        NSArray *arr = [dict allKeys];
        selectStr = [arr firstObject];
    }
    [self hide];
    [self.delegate selectAreaName:selectStr];
}

-(void)show{
    [MyWindow addSubview:self];
    if(_backView.frame.origin.y == showRect.origin.y){
        [self hide];
        return;
    }
    [UIView animateWithDuration:0.5 animations:^{
        
        _alpView.alpha = 0.5;
        _backView.frame = showRect;
    }];
}

-(void)hide{
    
    [UIView animateWithDuration:0.5 animations:^{
        
        _alpView.alpha = 0;
        _backView.frame = oldRect;
    }completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 2;
}
-(NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (component == 0) {
        return _proArray.count;
    }else {
        return _cityArray.count;
    }
}
-(NSString*) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (component == 0) {
        NSArray *arr = [_proArray[row] allKeys];
        NSString *str = [arr firstObject];
        return str;
    }else {
        NSArray *arr = [_cityArray[row] allKeys];
        NSString *str = [arr firstObject];
        return str;
    }
}
-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 40;
}

-(CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    if (_cityArray.count == 0) {
        if (component == 0) {
            return SCREEN_WIDTH;
        }else{
            return 0;
        }
    }else{
        return SCREEN_WIDTH/2;
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    if (component == 0) {
        //记录当前选中的省会
        NSInteger proIndex = [pickerView selectedRowInComponent:0];
        NSDictionary *dict = _proArray[proIndex];
        NSArray *arr = [dict allKeys];
        NSString *str = [arr firstObject];
        _cityArray = [self backArrOfDic:dict[str]];
        pickerView.delegate = self;
        [pickerView reloadComponent:1];
        
    }
}


///返回数据
- (NSMutableArray *)backArrOfDic:(NSMutableDictionary *)dict {
    NSMutableArray *arr = [NSMutableArray array];
    for (int i=0; i<dict.allKeys.count; i++) {
        [arr addObject:dict[[NSString stringWithFormat:@"%d",i]]];
    }
    return arr;
}

@end
