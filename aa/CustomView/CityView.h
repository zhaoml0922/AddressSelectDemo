//
//  CityView.h
//  aa
//
//  Created by zhaoml on 2018/3/21.
//  Copyright © 2018年 赵明亮. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CityDelegate <NSObject>

- (void)backCity:(NSString *)name  andDistrictArray:(NSArray *)districtArray;

@end

@interface CityView : UIView

@property (nonatomic,strong)NSArray *dataArr;

@property (nonatomic, weak)id<CityDelegate> delegate;



@end
