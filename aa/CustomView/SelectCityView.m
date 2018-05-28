//
//  SelectCityView.m
//  aa
//
//  Created by zhaoml on 2018/3/21.
//  Copyright © 2018年 赵明亮. All rights reserved.
//

#define scroHeight   500
#define minWidth   60

#import "SelectCityView.h"
#import "ProvinceView.h"
#import "CityView.h"
#import "DistrictView.h"
@interface SelectCityView()<UIScrollViewDelegate,ProvinceDelegate,CityDelegate,DistrictDelegate>

@property (nonatomic,strong)NSMutableDictionary *baseDic;
@property (nonatomic, strong) UITapGestureRecognizer *tap;
@property (nonatomic,strong)UIView *alpView;
@property (nonatomic,strong)UIView *groundView;
@property (nonatomic,strong)UIScrollView *scroll;
@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, strong) ProvinceView *pView;
@property (nonatomic, strong) CityView *cView;
@property (nonatomic, strong) DistrictView *dView;

@property (nonatomic, strong) UILabel *provinceLabel;
@property (nonatomic, strong) UILabel *cityLabel;
@property (nonatomic, strong) UILabel *districtLabel;

@property (nonatomic, strong) UIButton *provincebtn;
@property (nonatomic, strong) UIButton *cityBtn;
@property (nonatomic, strong) UIButton *districtbtn;

@property (nonatomic, strong) NSMutableArray *selectArr;

@property (nonatomic, assign) NSInteger index;
@end

@implementation SelectCityView

- (instancetype)init {
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0 ,SCREEN_WIDTH  , SCREEN_HEIGHT);
        self.index = 1;
        _selectArr = [NSMutableArray arrayWithArray:@[@"",@"",@""]];
        NSString *path = [[NSBundle mainBundle]pathForResource:@"area" ofType:@"plist"];
        _baseDic=[NSMutableDictionary dictionaryWithContentsOfFile:path];
        [self creatUI];
    }
    return self;
}

- (void)creatUI {
    self.userInteractionEnabled = YES;
    
    _alpView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _alpView.backgroundColor = [UIColor blackColor];
    _alpView.alpha = 0;
    [self addSubview:_alpView];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - scroHeight);
    [button addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchDown];
    [_alpView addSubview:button];
    
    _groundView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT , SCREEN_WIDTH, scroHeight)];
    _groundView.backgroundColor = [UIColor whiteColor];
    _groundView.userInteractionEnabled = YES;
    [self addSubview:_groundView];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, 25)];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.text = @"收货地址";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:16];
    [_groundView addSubview:titleLabel];
    
    UIView *lineV = [[UIView alloc] initWithFrame:CGRectMake(0, 44.5, SCREEN_WIDTH, 0.5)];
    lineV.backgroundColor = [UIColor lightGrayColor];
    [_groundView addSubview:lineV];
    
    _provinceLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _provinceLabel.textColor = [UIColor blackColor];
    _provinceLabel.font = [UIFont systemFontOfSize:13];
    _provinceLabel.textAlignment = NSTextAlignmentCenter;
    _provinceLabel.userInteractionEnabled = YES;
    _provinceLabel.hidden = YES;
    [_groundView addSubview:_provinceLabel];
    
    _provincebtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_provincebtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [_provinceLabel addSubview:_provincebtn];
    
    _cityLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _cityLabel.textColor = [UIColor blackColor];
    _cityLabel.font = [UIFont systemFontOfSize:13];
    _cityLabel.userInteractionEnabled = YES;
    _cityLabel.textAlignment = NSTextAlignmentCenter;
    _cityLabel.hidden = YES;
    [_groundView addSubview:_cityLabel];
    
    _cityBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_cityBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [_cityLabel addSubview:_cityBtn];
    
    _districtLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _districtLabel.textColor = [UIColor redColor];
    _districtLabel.text = @"请选择";
    _districtLabel.userInteractionEnabled = YES;
    _districtLabel.font = [UIFont systemFontOfSize:13];
    _districtLabel.textAlignment = NSTextAlignmentCenter;
    [_groundView addSubview:_districtLabel];
    
    _districtbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_districtbtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [_districtLabel addSubview:_districtbtn];
    
    _lineView = [[UIView alloc] initWithFrame:CGRectZero];
    _lineView.backgroundColor = [UIColor redColor];
    [_groundView addSubview:_lineView];
    
    _scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 45+30, SCREEN_WIDTH, scroHeight- 75)];
    _scroll.backgroundColor = [UIColor whiteColor];
    _scroll.pagingEnabled = YES;
    _scroll.bounces = NO;
    _scroll.delegate = self;
    _scroll.showsVerticalScrollIndicator = NO;
    _scroll.showsHorizontalScrollIndicator = NO;
    [_groundView addSubview:_scroll];
    
    _pView = [[ProvinceView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, scroHeight- 75)];
    _pView.delegate = self;
    [_scroll addSubview:_pView];
    
    _cView = [[CityView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, scroHeight- 75)];
    _cView.delegate = self;
    [_scroll addSubview:_cView];
    
    _dView = [[DistrictView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH*2, 0, SCREEN_WIDTH, scroHeight- 75)];
    _dView.delegate = self;
    [_scroll addSubview:_dView];
    
    [self loadStartData];
}

- (void)show {
    [MyWindow addSubview:self];
    self.hidden = NO;
    [UIView animateWithDuration:0.2 animations:^{
        _alpView.alpha = 0.5;
        _groundView.frame = CGRectMake(0, SCREEN_HEIGHT - scroHeight, SCREEN_WIDTH, scroHeight);
    }];
}
- (void)hide {
    self.hidden = YES;
    _alpView.alpha = 0;
    _groundView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, scroHeight);
    
}

- (void)setIndex:(NSInteger)index {
    if (index < 1) {
        return;
    }
    _index = index;
    _scroll.contentSize = CGSizeMake(SCREEN_WIDTH*(1+!_cityLabel.isHidden+!_provinceLabel.isHidden), _scroll.height);
    [UIView animateWithDuration:0.2 animations:^{
        _scroll.contentOffset = CGPointMake(SCREEN_WIDTH * (index - 1), 0);
        if (index == 1) {
            if (_provinceLabel.isHidden == YES) {
                 _lineView.frame = CGRectMake(0, 45+28, _districtLabel.width, 2);
                _districtLabel.frame = CGRectMake(0, 45, _districtLabel.width, 28);
            }else{
                 _lineView.frame = CGRectMake(0, 45+28, _provinceLabel.width, 2);
                if (_cityLabel.isHidden) {
                    _districtLabel.frame = CGRectMake(_provinceLabel.width, 45, _districtLabel.width, 28);
                }else{
                    _districtLabel.frame = CGRectMake(_provinceLabel.width+_cityLabel.width, 45, _districtLabel.width, 28);
                }
            }
        
        }else if (index == 2) {
            if (_cityLabel.isHidden) {
                _districtLabel.frame = CGRectMake(_provinceLabel.width, 45, _districtLabel.width, 28);
                _lineView.frame = CGRectMake(_provinceLabel.width, 45+28, _districtLabel.width, 2);
            }else{
                _districtLabel.frame = CGRectMake(_provinceLabel.width+_cityLabel.width, 45, _districtLabel.width, 28);
                _lineView.frame = CGRectMake(_provinceLabel.width, 45+28, _cityLabel.width, 2);
            }
        }else{
            _districtLabel.frame = CGRectMake(_provinceLabel.width+_cityLabel.width, 45, _districtLabel.width, 28);
            _lineView.frame = CGRectMake(_provinceLabel.width+_cityLabel.width, 45+28, _districtLabel.width, 2);
        }
    }];
}

- (void)loadStartData {
    _scroll.contentSize = CGSizeMake(SCREEN_WIDTH, _scroll.height);
    _districtLabel.frame = CGRectMake(0, 45, [self backWidth:_districtLabel], 28);
    _districtbtn.frame = _districtLabel.bounds;
    self.index = 0;
    _pView.dataArr = [self backArrOfDic:_baseDic];
    _lineView.frame = CGRectMake(0, 45+28, _districtLabel.width, 2);
}

- (CGFloat)backWidth:(UILabel *)label {
    [label sizeToFit];
    CGFloat width = label.frame.size.width+30;
    if (width<minWidth) {
        return minWidth;
    }
    return width;
}


- (void)buttonClick:(UIButton *)btn {
    if (btn == _provincebtn) {
        self.index = 1;
    }else if (btn == _cityBtn) {
        self.index = 2;
    }else{
        self.index = _index+1;
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger i = scrollView.contentOffset.x/SCREEN_WIDTH;
    self.index = i+1;
}

///返回数据
- (NSMutableArray *)backArrOfDic:(NSMutableDictionary *)dict {
    NSMutableArray *arr = [NSMutableArray array];
    for (int i=0; i<dict.allKeys.count; i++) {
        [arr addObject:dict[[NSString stringWithFormat:@"%d",i]]];
    }
    return arr;
}

- (void)backProvince:(NSString *)name andCityArray:(NSArray *)cityArray {
    [_selectArr replaceObjectAtIndex:0 withObject:name];
    [_selectArr replaceObjectAtIndex:1 withObject:@""];
    [_selectArr replaceObjectAtIndex:2 withObject:@""];
    _cView.dataArr = cityArray;
    _provinceLabel.text = name;
    CGFloat width = [self backWidth:_provinceLabel];
    _provinceLabel.frame = CGRectMake(0, 45, width, 28);
    _provincebtn.frame = _provinceLabel.bounds;
    _provinceLabel.hidden = NO;
    _cityLabel.hidden = YES;
    self.index = 2;
}


- (void)backCity:(NSString *)name andDistrictArray:(NSArray *)districtArray{
    [_selectArr replaceObjectAtIndex:1 withObject:name];
    [_selectArr replaceObjectAtIndex:2 withObject:@""];
    _dView.dataArr = districtArray;
    _cityLabel.text = name;
    CGFloat width = [self backWidth:_cityLabel];
    _cityLabel.frame = CGRectMake(_provinceLabel.right, 45, width, 28);
    _cityLabel.hidden = NO;
    _cityBtn.frame = _cityLabel.bounds;
    self.index = 3;
}

- (void)backDistrict:(NSString *)name {
    [_selectArr replaceObjectAtIndex:2 withObject:name];
    [self hide];    
    [self.delegate selectCityWithName:[_selectArr componentsJoinedByString:@" "]];
}


@end
