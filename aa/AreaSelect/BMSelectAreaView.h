//
//  BMSelectAreaView.h
//  aa
//
//  Created by zhaoml on 2018/4/24.
//  Copyright © 2018年 赵明亮. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SelectAreaDelegate <NSObject>

- (void)selectAreaName:(NSString *)areaName;

@end


@interface BMSelectAreaView : UIView

- (void)show;

@property (nonatomic, weak)id<SelectAreaDelegate> delegate;

@end
