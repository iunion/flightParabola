//
//  UILocalNotification+Category.h
//  miqian
//
//  Created by dengjiang on 15/8/26.
//  Copyright (c) 2015年 ShiCaiDai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILocalNotification (Category)

// 1: 周日 2~7: 周一~周六
+ (NSDate *)makeNotifDateWithWeekDay:(NSUInteger)weekDay hour:(NSUInteger)hour;

+ (void)localNotificationWithFireDate:(NSDate *)fireDate repeatInterval:(NSCalendarUnit)repeatInterval
                            alertBody:(NSString *)alertBody alertAction:(NSString *)alertAction
                            soundName:(NSString *)soundName
                            noticeKey:(NSString *)noticeKey userInfo:(NSDictionary *)userInfo;

@end
