//
//  UILabel+Category.m
//  setTable
//
//  Created by HanDaoliang on 15/7/20.
//  Copyright (c) 2015年 BBT. All rights reserved.
//

#import "UILabel+Category.h"

@implementation UILabel (Category)

+ (UILabel *)initWithFrame:(CGRect)frame text:(NSString *)text fontSize:(CGFloat)fontSize color:(UIColor *)color alignment:(NSTextAlignment)alignment lines:(NSInteger)lines
{
    return [UILabel initWithFrame:frame text:text fontSize:fontSize color:color alignment:alignment lines:lines shadowColor:[UIColor clearColor]];
}

+ (UILabel *)initWithFrame:(CGRect)frame text:(NSString *)text fontSize:(CGFloat)fontSize color:(UIColor *)color alignment:(NSTextAlignment)alignment lines:(NSInteger)lines shadowColor:(UIColor *)txtShadowColor
{
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.backgroundColor = [UIColor clearColor];
    label.numberOfLines = lines;

    label.font = [UIFont systemFontOfSize:fontSize];
    
    label.text = text;
    if (color)
    {
        label.textColor = color;
    }
    if (txtShadowColor)
    {
        label.shadowColor = txtShadowColor;
    }
    label.textAlignment = alignment;
    
    return label;
}

- (CGSize)labelSizeToFitWidth:(CGFloat)width
{
    CGSize maxSize = CGSizeMake(width, CGFLOAT_MAX);
    return [self labelSizeToFit:maxSize];
}

- (CGSize)labelSizeToFitHeight:(CGFloat)height
{
    CGSize maxSize = CGSizeMake(CGFLOAT_MAX, height);
    return [self labelSizeToFit:maxSize];
}

- (CGSize)labelSizeToFit:(CGSize)maxSize
{
    NSStringDrawingOptions options = NSStringDrawingUsesLineFragmentOrigin |  NSStringDrawingUsesFontLeading;
    if (self.lineBreakMode ==  NSLineBreakByTruncatingHead ||
        self.lineBreakMode ==  NSLineBreakByTruncatingTail ||
        self.lineBreakMode ==  NSLineBreakByTruncatingMiddle )
    {
        options |= NSStringDrawingTruncatesLastVisibleLine;
    }
    //NSLineBreakMode mode  = self.lineBreakMode;
    //self.lineBreakMode = NSLineBreakByCharWrapping;
    
    if (self.numberOfLines > 0)
    {
        maxSize = CGSizeMake(maxSize.width, self.font.lineHeight * self.numberOfLines);
    }
    
    CGRect textRect  = [self.attributedText boundingRectWithSize:maxSize options:options context:NULL];
    //self.lineBreakMode = mode;
    
    return textRect.size;
}

@end
