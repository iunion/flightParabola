//
//  ThrowLineTool.m
//  Flight
//
//  Created by dengjiang on 15/11/18.
//  Copyright © 2015年 ShiCaiDai. All rights reserved.
//

#import "ThrowLineTool.h"
#import <QuartzCore/QuartzCore.h>


@interface ThrowLineTool ()

@property (nonatomic, strong) UIView *showingView;

@end


@implementation ThrowLineTool

- (void)dealloc
{
    
}

+ (ThrowLineTool *)sharedTool
{
    static ThrowLineTool *s_sharedInstance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        s_sharedInstance = [[self alloc] init];
    });
    
    return s_sharedInstance;
}

/**
 *  将某个view或者layer从起点抛到终点
 *
 *  @param obj    被抛的物体
 *  @param start  起点坐标
 *  @param end    终点坐标
 *  @param height 高度，抛物线最高点比起点/终点y坐标最低(即高度最高)所超出的高度
 */
- (void)throwObject:(UIView *)obj from:(CGPoint)start to:(CGPoint)end
             height:(CGFloat)height duration:(CGFloat)duration
{
    self.showingView = obj;
    //初始化抛物线path
    CGMutablePathRef path = CGPathCreateMutable();
    CGFloat cpx = (start.x + end.x) / 2;
    CGFloat cpy = -height;
    CGPathMoveToPoint(path, NULL, start.x, start.y);
    CGPathAddQuadCurveToPoint(path, NULL, cpx, cpy, end.x, end.y);
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.path = path;
    CFRelease(path);
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.autoreverses = YES;
    scaleAnimation.toValue = [NSNumber numberWithFloat:(CGFloat)((arc4random() % 7) + 4) / 10.0];
    
    CAAnimationGroup *groupAnimation = [CAAnimationGroup animation];
    groupAnimation.delegate = self;
    groupAnimation.repeatCount = 1;
    groupAnimation.duration = duration;
    groupAnimation.removedOnCompletion = NO;
    groupAnimation.animations = @[scaleAnimation, animation];
    [obj.layer addAnimation:groupAnimation forKey:@"position scale"];
}

- (void)animationDidStart:(CAAnimation *)anim
{
    
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(animationDidFinish)])
    {
        [self.delegate performSelector:@selector(animationDidFinish) withObject:nil];
    }
    
    self.showingView = nil;
}

@end
