//
//  MLAlertCenter.h
//  DiDiDoctor
//
//  Created by zhaoml on 16/5/3.
//  Copyright © 2016年 DouDou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MLAlertCenter : NSObject


+ (MLAlertCenter*)defaultCenter;


- (void)postAlertWithContent:(NSString *)content;

@end
