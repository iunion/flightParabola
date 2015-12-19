//
//  UIButton+Category.m
//  setTable
//
//  Created by HanDaoliang on 15/7/20.
//  Copyright (c) 2015年 BBT. All rights reserved.
//

#import "UIButton+Category.h"
#import "UIImage+Category.h"


@implementation UIButton (Category)

+ (id)initWithFrame:(CGRect)frame
{
    return [UIButton initWithFrame:frame title:nil];
}

+ (id)initWithFrame:(CGRect)frame title:(NSString *)title
{
    return [UIButton initWithFrame:frame title:title backgroundImage:nil];
}

+ (id)initWithFrame:(CGRect)frame title:(NSString *)title backgroundImage:(UIImage *)backgroundImage
{
    return [UIButton initWithFrame:frame title:title backgroundImage:backgroundImage highlightedBackgroundImage:nil];
}

+ (id)initWithFrame:(CGRect)frame title:(NSString *)title backgroundImage:(UIImage *)backgroundImage highlightedBackgroundImage:(UIImage *)highlightedBackgroundImage
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:frame];
    [button setTitle:title forState:UIControlStateNormal];
    [button setBackgroundImage:backgroundImage forState:UIControlStateNormal];
    [button setBackgroundImage:highlightedBackgroundImage forState:UIControlStateHighlighted];
    
    return button;
}

+ (id)initWithFrame:(CGRect)frame title:(NSString *)title color:(UIColor *)color
{
    const CGFloat *components = CGColorGetComponents(color.CGColor);
    return [UIButton initWithFrame:frame title:title backgroundImage:[UIImage imageWithColor:color] highlightedBackgroundImage:[UIImage imageWithColor:[UIColor colorWithRed:components[0]-0.1 green:components[1]-0.1 blue:components[2]-0.1 alpha:1]]];
}

+ (id)initWithFrame:(CGRect)frame title:(NSString *)title color:(UIColor *)color highlightedColor:(UIColor *)highlightedColor
{
    return [UIButton initWithFrame:frame title:title backgroundImage:[UIImage imageWithColor:color] highlightedBackgroundImage:[UIImage imageWithColor:highlightedColor]];
}

+ (id)initWithFrame:(CGRect)frame color:(UIColor *)color
{
    const CGFloat *components = CGColorGetComponents(color.CGColor);
    return [UIButton initWithFrame:frame title:nil backgroundImage:[UIImage imageWithColor:color] highlightedBackgroundImage:[UIImage imageWithColor:[UIColor colorWithRed:components[0]-0.1 green:components[1]-0.1 blue:components[2]-0.1 alpha:1]]];
}

+ (id)initWithFrame:(CGRect)frame color:(UIColor *)color highlightedColor:(UIColor *)highlightedColor
{
    return [UIButton initWithFrame:frame title:nil backgroundImage:[UIImage imageWithColor:color] highlightedBackgroundImage:[UIImage imageWithColor:highlightedColor]];
}

+ (id)initWithFrame:(CGRect)frame image:(UIImage *)image
{
    return [UIButton initWithFrame:frame image:image highlightedImage:nil];
}

+ (id)initWithFrame:(CGRect)frame image:(UIImage *)image highlightedImage:(UIImage *)highlightedImage
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:frame];
    [button setImage:image forState:UIControlStateNormal];
    [button setImage:highlightedImage forState:UIControlStateHighlighted];
    
    return button;
}

- (void)setTitleColor:(UIColor *)color
{
    [self setTitleColor:color highlightedColor:[color colorWithAlphaComponent:0.4]];
}

- (void)setTitleColor:(UIColor *)color highlightedColor:(UIColor *)highlightedColor
{
    [self setTitleColor:color forState:UIControlStateNormal];
    [self setTitleColor:highlightedColor forState:UIControlStateHighlighted];
}

- (void)setTitleColor:(UIColor *)color highlightedColor:(UIColor *)highlightedColor selectedColor:(UIColor *)selectedColor
{
    [self setTitleColor:color forState:UIControlStateNormal];
    [self setTitleColor:highlightedColor forState:UIControlStateHighlighted];
    [self setTitleColor:selectedColor forState:UIControlStateSelected];
}

@end
