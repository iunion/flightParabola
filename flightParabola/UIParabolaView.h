//
//  UIParabolaView.h
//  Flight
//
//  Created by dengjiang on 15/11/18.
//  Copyright © 2015年 ShiCaiDai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIParabolaView : UIView

@property (nonatomic, assign) CGPoint m_StartPoint;
@property (nonatomic, assign) CGPoint m_EndPoint;
@property (nonatomic, assign) CGFloat m_Height;

@property (nonatomic, strong) UIColor *m_LineColor;

@property (nonatomic, assign) BOOL m_bShow;

@end
