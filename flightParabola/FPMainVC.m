//
//  FPMainVC.m
//  flightParabola
//
//  Created by dengjiang on 15/11/18.
//  Copyright © 2015年 ShiCaiDai. All rights reserved.
//

#import "FPMainVC.h"
#import "ThrowLineTool.h"
#import "UIParabolaView.h"
#import "ASValueTrackingSlider.h"
#import "RESwitch.h"

#define M_G     9.8f

#define TOP_GAP         20.0f
#define LEFT_GAP        30.0f


@interface FPMainVC ()
<
    ThrowLineToolDelegate
>

@property (weak, nonatomic) IBOutlet UIScrollView *m_ScrollView;

@property (weak, nonatomic) IBOutlet UILabel *m_SpeedLabel;
@property (weak, nonatomic) IBOutlet UILabel *m_AngleLabel;

@property (weak, nonatomic) IBOutlet ASValueTrackingSlider *m_SpeedSlider;
@property (weak, nonatomic) IBOutlet ASValueTrackingSlider *m_AngleSlider;

@property (strong, nonatomic) UIParabolaView *m_ParabolaView;

@property (strong, nonatomic) UIImageView *m_FlightImageView;

@property (nonatomic, assign) CGFloat m_StartAngle;
@property (nonatomic, assign) CGFloat m_StartSpeed;

@property (nonatomic, assign) CGPoint m_StartPoint;
@property (nonatomic, assign) CGPoint m_EndPoint;
@property (nonatomic, assign) CGFloat m_MaxX;
@property (nonatomic, assign) CGFloat m_Height;
@property (nonatomic, assign) CGFloat m_DuringTime;

@end

@implementation FPMainVC


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.m_ScrollView.contentSize = self.m_ScrollView.bounds.size;
    
    
    self.m_StartPoint = CGPointMake(0, self.m_ScrollView.height);
    
    _m_StartSpeed = 100.0f;
    _m_StartAngle = 45.0f;
    
    [self.m_SpeedSlider setMaxFractionDigitsDisplayed:0];
    self.m_SpeedSlider.popUpViewAnimatedColors = @[[UIColor blueColor], [UIColor purpleColor], [UIColor redColor]];
    [self.m_SpeedSlider addTarget:self action:@selector(sliderChanged:) forControlEvents:UIControlEventValueChanged];
    [self.m_SpeedSlider addTarget:self action:@selector(sliderUp:) forControlEvents:UIControlEventTouchUpInside];

    [self.m_AngleSlider setMaxFractionDigitsDisplayed:0];
    self.m_AngleSlider.popUpViewAnimatedColors = @[[UIColor blueColor], [UIColor redColor], [UIColor blueColor]];
    [self.m_AngleSlider addTarget:self action:@selector(sliderChanged:) forControlEvents:UIControlEventValueChanged];
    [self.m_AngleSlider addTarget:self action:@selector(sliderUp:) forControlEvents:UIControlEventTouchUpInside];

    self.m_FlightImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"flight"]];
    self.m_FlightImageView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin
    | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    
    self.m_SpeedLabel.text = [NSString stringWithFormat:@"起始速度: %0.0f", self.m_StartSpeed];
    self.m_AngleLabel.text = [NSString stringWithFormat:@"起始角度: %0.0f", self.m_StartAngle];

    RESwitch *defaultSwitch = [[RESwitch alloc] initWithFrame:CGRectMake(self.m_AngleSlider.right+20, self.m_AngleSlider.top, 76, 28)];
    [self.view addSubview:defaultSwitch];
    [defaultSwitch addTarget:self action:@selector(switchViewChanged:) forControlEvents:UIControlEventValueChanged];
    
    [self makeData];
    
    [self beginDraw];
    
    [self beginThrowing:self.m_FlightImageView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)beginDraw
{
    UIParabolaView *parabolaView = [[UIParabolaView alloc] initWithFrame:CGRectMake(LEFT_GAP, 0, self.m_MaxX, self.m_ScrollView.contentSize.height-TOP_GAP)];
    parabolaView.m_StartPoint = self.m_StartPoint;
    parabolaView.m_EndPoint = self.m_EndPoint;
    parabolaView.m_Height = self.m_Height;
    
    self.m_ParabolaView = parabolaView;
    
    [self.m_ScrollView addSubview:parabolaView];
    [self.m_ParabolaView sendToBack];
    [self.m_ParabolaView addSubview:self.m_FlightImageView];

    [self makeData];
}

- (void)setM_StartAngle:(CGFloat)startAngle
{
    _m_StartAngle = startAngle;
    
    [self makeData];
}

- (void)setM_StartSpeed:(CGFloat)startSpeed
{
    _m_StartSpeed = startSpeed;
    
    [self makeData];
}

- (void)setM_MaxX:(CGFloat)maxX
{
    _m_MaxX = maxX;

    if (maxX < self.m_ScrollView.width)
    {
        maxX = self.m_ScrollView.width;
    }
    
    self.m_ScrollView.contentSize = CGSizeMake(maxX+LEFT_GAP*2, self.m_ScrollView.contentSize.height);
    self.m_ParabolaView.width = maxX;
}

- (void)setM_Height:(CGFloat)height
{
    _m_Height = height;

    if (height < self.m_ScrollView.height)
    {
        height = self.m_ScrollView.height;
    }

    self.m_ScrollView.contentSize = CGSizeMake(self.m_ScrollView.contentSize.width, height+TOP_GAP*2);
    self.m_ScrollView.contentOffset = CGPointMake(self.m_ScrollView.contentOffset.x, height+TOP_GAP-self.m_ScrollView.height);
    self.m_ParabolaView.height = height;
}

- (void)makeData
{
    CGFloat angle = self.m_StartAngle*M_PI/180;
    
    self.m_DuringTime = 2*self.m_StartSpeed*sin(angle)/M_G;
    
    CGFloat maxX =  self.m_StartSpeed*cos(angle)*self.m_DuringTime;
    self.m_MaxX = maxX;

    self.m_Height = (self.m_StartSpeed*sin(angle))*(self.m_StartSpeed*sin(angle))/(2*M_G);
    
    self.m_StartPoint = CGPointMake(0, self.m_ScrollView.contentSize.height-TOP_GAP);
    self.m_EndPoint = CGPointMake(maxX, self.m_ScrollView.contentSize.height-TOP_GAP);
    
    CGPoint point = self.m_StartPoint;//[self.m_ScrollView convertPoint:self.m_StartPoint fromView:self.m_ParabolaView];
    //point.x = LEFT_GAP;
    point.y = self.m_StartPoint.y-TOP_GAP;
    self.m_FlightImageView.center = point;
}

- (void)sliderChanged:(ASValueTrackingSlider *)slider
{
    [self.m_FlightImageView stopAnimation];
    
    if (slider == self.m_SpeedSlider)
    {
        self.m_StartSpeed = (NSUInteger)(self.m_SpeedSlider.value);
        self.m_SpeedLabel.text = [NSString stringWithFormat:@"起始速度: %0.0f", self.m_StartSpeed];
    }
    else
    {
        self.m_StartAngle = (NSUInteger)(self.m_AngleSlider.value);
        self.m_AngleLabel.text = [NSString stringWithFormat:@"起始角度: %0.0f", self.m_StartAngle];
    }
    
    self.m_ParabolaView.m_StartPoint = self.m_StartPoint;
    self.m_ParabolaView.m_EndPoint = self.m_EndPoint;
    self.m_ParabolaView.m_Height = self.m_Height;
}

- (void)sliderUp:(ASValueTrackingSlider *)slider
{
    [self beginThrowing:self.m_FlightImageView];
}


- (void)beginThrowing:(UIView *)view
{
    ThrowLineTool *tool = [ThrowLineTool sharedTool];
    tool.delegate = self;

    CGFloat startX = self.m_StartPoint.x;
    CGFloat startY = self.m_StartPoint.y - TOP_GAP;
    
    CGFloat endX = self.m_EndPoint.x;
    CGFloat endY = self.m_EndPoint.y - TOP_GAP;
    CGFloat height = self.m_Height;
    
    [tool throwObject:view
                 from:CGPointMake(startX, startY)
                   to:CGPointMake(endX, endY)
               height:height duration:self.m_DuringTime];
}

- (void)animationDidFinish
{
    
}


- (void)switchViewChanged:(RESwitch *)switchView
{
    NSLog(@"Value: %i", switchView.on);
    
    self.m_ParabolaView.m_bShow = switchView.on;
}

@end
