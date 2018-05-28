//
//  DistrictView.h
//  aa
//
//  Created by zhaoml on 2018/3/21.
//  Copyright © 2018年 赵明亮. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DistrictDelegate <NSObject>

- (void)backDistrict:(NSString *)name;

@end

@interface DistrictView : UIView

@property (nonatomic,strong)NSArray *dataArr;

@property (nonatomic, weak)id<DistrictDelegate> delegate;

@end
