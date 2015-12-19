//
//  UIParabolaView.m
//  Flight
//
//  Created by dengjiang on 15/11/18.
//  Copyright © 2015年 ShiCaiDai. All rights reserved.
//

#import "UIParabolaView.h"

@implementation UIParabolaView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        // Set default values for properties
        self.contentMode = UIViewContentModeCenter;
        self.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin
								| UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        
        // Transparent background
        self.opaque = NO;
        self.backgroundColor = [UIColor clearColor];
        
        self.m_StartPoint = CGPointMake(40, self.height-20);
        self.m_EndPoint = CGPointMake(self.width-40, self.height-20);
        self.m_Height = self.height-40;
        
        self.m_LineColor = [UIColor redColor];
        
        _m_bShow = YES;
    }
    
    return self;
}

- (void)setM_StartPoint:(CGPoint)startPoint
{
    _m_StartPoint = startPoint;
    
    [self setNeedsDisplay];
}

- (void)setM_EndPoint:(CGPoint)endPoint
{
    _m_EndPoint = endPoint;
    
    [self setNeedsDisplay];
}

- (void)setM_Height:(CGFloat)height
{
    _m_Height = height;
    
    [self setNeedsDisplay];
}

- (void)setM_bShow:(BOOL)bShow
{
    _m_bShow = bShow;
    
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    // Drawing code
    [super drawRect:rect];
    
    if (!self.m_bShow)
    {
        return;
    }
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGFloat cpx = (self.m_StartPoint.x + self.m_EndPoint.x) / 2;
    CGFloat cpy = -self.m_Height;
    CGContextMoveToPoint(context, self.m_StartPoint.x, self.m_StartPoint.y);
    CGContextAddQuadCurveToPoint(context, cpx, cpy, self.m_EndPoint.x, self.m_EndPoint.y);
    // 线颜色
    CGContextSetStrokeColorWithColor(context, self.m_LineColor.CGColor);
    CGContextSetLineWidth(context, 5.0f);
    CGContextStrokePath(context);
}


@end
