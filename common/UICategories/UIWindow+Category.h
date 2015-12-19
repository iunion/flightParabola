//
//  UIWindow+Category.h
//  lama
//
//  Created by Dennis on 15-2-26.
//  Copyright (c) 2015年 lama. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIWindow (Category)

- (UIImage *)screenshot;
- (UIImage *)screenshotWithRect:(CGRect)rect;

@end
