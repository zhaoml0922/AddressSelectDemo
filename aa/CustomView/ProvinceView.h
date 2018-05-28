//
//  ProvinceView.h
//  aa
//
//  Created by zhaoml on 2018/3/21.
//  Copyright © 2018年 赵明亮. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ProvinceDelegate <NSObject>

- (void)backProvince:(NSString *)name andCityArray:(NSArray *)cityArray;

@end

@interface ProvinceView : UIView

@property (nonatomic,strong)NSArray *dataArr;

@property (nonatomic, weak)id<ProvinceDelegate> delegate;

@end
