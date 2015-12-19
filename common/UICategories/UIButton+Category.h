//
//  UIButton+Category.h
//  setTable
//
//  Created by HanDaoliang on 15/7/20.
//  Copyright (c) 2015年 BBT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Category)

+ (id)initWithFrame:(CGRect)frame;
+ (id)initWithFrame:(CGRect)frame title:(NSString *)title;

+ (id)initWithFrame:(CGRect)frame title:(NSString *)title backgroundImage:(UIImage *)backgroundImage;
+ (id)initWithFrame:(CGRect)frame title:(NSString *)title backgroundImage:(UIImage *)backgroundImage highlightedBackgroundImage:(UIImage *)highlightedBackgroundImage;

+ (id)initWithFrame:(CGRect)frame title:(NSString *)title color:(UIColor *)color;
+ (id)initWithFrame:(CGRect)frame title:(NSString *)title color:(UIColor *)color highlightedColor:(UIColor *)highlightedColor;

+ (id)initWithFrame:(CGRect)frame color:(UIColor *)color;
+ (id)initWithFrame:(CGRect)frame color:(UIColor *)color highlightedColor:(UIColor *)highlightedColor;

+ (id)initWithFrame:(CGRect)frame image:(UIImage *)image;
+ (id)initWithFrame:(CGRect)frame image:(UIImage *)image highlightedImage:(UIImage *)highlightedImage;


- (void)setTitleColor:(UIColor *)color;
- (void)setTitleColor:(UIColor *)color highlightedColor:(UIColor *)highlightedColor;
- (void)setTitleColor:(UIColor *)color highlightedColor:(UIColor *)highlightedColor selectedColor:(UIColor *)selectedColor;

@end
