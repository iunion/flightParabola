//
//  UILabel+Category.h
//  setTable
//
//  Created by HanDaoliang on 15/7/20.
//  Copyright (c) 2015年 BBT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Category)

+ (UILabel *)initWithFrame:(CGRect)frame text:(NSString *)text fontSize:(CGFloat)fontSize color:(UIColor *)color alignment:(NSTextAlignment)alignment lines:(NSInteger)lines;
+ (UILabel *)initWithFrame:(CGRect)frame text:(NSString *)text fontSize:(CGFloat)fontSize color:(UIColor *)color alignment:(NSTextAlignment)alignment lines:(NSInteger)lines shadowColor:(UIColor *)txtShadowColor;

- (CGSize)labelSizeToFitWidth:(CGFloat)width;
- (CGSize)labelSizeToFitHeight:(CGFloat)height;
- (CGSize)labelSizeToFit:(CGSize)maxSize;


@end
