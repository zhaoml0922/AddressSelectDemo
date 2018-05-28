//
//  MLAlertCenter.m
//  DiDiDoctor
//
//  Created by zhaoml on 16/5/3.
//  Copyright © 2016年 DouDou. All rights reserved.
//



#define MaxWidth  [UIScreen mainScreen].bounds.size.width*(2.0/3.0)-40
#define TextFont   15

#import "MLAlertCenter.h"

static MLAlertCenter *center = nil;

@implementation MLAlertCenter
{
    UILabel *contentLabel;
    UIView *groundView;
    /*!@brief alert底视图*/
    UIView *aleView;


}


+ (MLAlertCenter *)defaultCenter {
    static dispatch_once_t one;
    dispatch_once(&one, ^{
        
        center = [[MLAlertCenter alloc]init];
    });
    return center;
}


- (id)init {
    self = [super init];
    if (self) {
        [self creatAlertUI];
    }
    return self;
}


- (void)postAlertWithContent:(NSString *)content {
    contentLabel.text = content;
    CGFloat width = [self getWidthWithStr:content
                                andHeight:TextFont
                              andTextFont:TextFont];
    if (width>MaxWidth) {
        
        CGFloat height = [self getHeightWithStr:content
                                      andWeight:MaxWidth
                                    andTextFont:TextFont];
        contentLabel.frame = CGRectMake(0, 0, MaxWidth, height);
        
    }else{
        contentLabel.frame = CGRectMake(0, 0, width, TextFont);
    }
    aleView.frame = CGRectMake(0, 0, contentLabel.frame.size.width+40, contentLabel.frame.size.height+20);
    groundView.frame = CGRectMake(0, 0, contentLabel.frame.size.width+40, contentLabel.frame.size.height+20);
    groundView.center = CGPointMake([UIScreen mainScreen].bounds.size.width/2, [UIScreen mainScreen].bounds.size.height/2);
    contentLabel.center = CGPointMake(groundView.frame.size.width/2, groundView.frame.size.height/2);
    
    [self showCallAlertView];
}


/*!
 *  @author 赵明亮 , 16-03-09 14:03:48
 *
 *  @brief 创建UI
 */
- (void)creatAlertUI {
    
    groundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    groundView.alpha = 0;
    groundView.layer.cornerRadius = 5;
    groundView.layer.masksToBounds = YES;
    
    aleView = [[UIView alloc]initWithFrame:groundView.bounds];
    aleView.backgroundColor=[UIColor blackColor];
    aleView.layer.masksToBounds=YES;
    aleView.layer.cornerRadius=5;
    aleView.alpha = 0.8;
    [groundView addSubview:aleView];
    
    contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, MaxWidth, 16)];
    contentLabel.font = [UIFont systemFontOfSize:TextFont];
    contentLabel.numberOfLines = 0;
    contentLabel.textAlignment=NSTextAlignmentCenter;
    contentLabel.textColor=[UIColor whiteColor];
    [groundView addSubview:contentLabel];
    
  }


/*!
 *  @author 赵明亮 , 16-03-09 10:03:29
 *
 *  @brief 确定按钮的点击
 */
- (void)hide {
    [self hideShake];
    groundView.alpha = 0;
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
}


/*!
 *  @author 赵明亮 , 16-03-09 10:03:59
 *
 *  @brief 显示alertView
 */
- (void)showCallAlertView {
    
     groundView.alpha = 1;
    [[UIApplication sharedApplication].keyWindow addSubview:groundView];
    [self showShake];
    [self performSelector:@selector(hide)
               withObject:nil
               afterDelay:1.0f];
}



/*!
 *  @author 赵明亮 , 16-03-09 10:03:31
 *
 *  @brief 关闭时的动画效果
 */
- (void)hideShake{
    
    CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.2;
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.5, 0.5, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
    animation.values = values;
    [aleView.layer addAnimation:animation forKey:nil];
    [groundView.layer addAnimation:animation forKey:nil];
}

/*!
 *  @author 赵明亮 , 16-03-09 10:03:20
 *
 *  @brief 展示时的动画效果
 */
- (void) showShake{
    CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.20;
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.4, 1.4, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    animation.values = values;
    [groundView.layer addAnimation:animation forKey:nil];
    [aleView.layer addAnimation:animation forKey:nil];
}

-(CGFloat)getWidthWithStr:(NSString *)str
                andHeight:(CGFloat)height
              andTextFont:(int)num
{
    if(str.length>0)
    {
        CGRect rect = [str boundingRectWithSize:CGSizeMake(MAXFLOAT,height)
                                        options:NSStringDrawingUsesLineFragmentOrigin
                                     attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:num]}
                                        context:nil];
        float wight = rect.size.width;
        return wight+2;
    }else{
        return 5;
    }
}

-(CGFloat)getHeightWithStr:(NSString *)str
                 andWeight:(CGFloat)weight
               andTextFont:(int)num
{
    if(str.length>0)
    {
        CGRect rect = [str boundingRectWithSize:CGSizeMake(weight,MAXFLOAT)
                                        options:NSStringDrawingUsesLineFragmentOrigin
                                     attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:num]}
                                        context:nil];
        float height = rect.size.height;
        return height+2;
    }else{
        return 5;
    }
}

@end
