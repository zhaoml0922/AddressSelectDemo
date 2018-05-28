//
//  SelectCityView.h
//  aa
//
//  Created by zhaoml on 2018/3/21.
//  Copyright © 2018年 赵明亮. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SelectCityDelegate <NSObject>

- (void)selectCityWithName:(NSString *)name;

@end

@interface SelectCityView : UIView

- (void)show;

@property (nonatomic, weak)id<SelectCityDelegate> delegate;

@property (nonatomic,strong)NSMutableArray *selectBaseArray;


@end
