//
//  CommonMacros.h
//  miqian
//
//  Created by dengjiang on 15/8/17.
//  Copyright (c) 2015年 ShiCaiDai. All rights reserved.
//
#import "CommonUIDef.h"

#ifndef miqian_CommonMacros_h
#define miqian_CommonMacros_h

// 能否弹出push信息窗口
extern BOOL g_Commom_CanShowPush;

#pragma mark -
#pragma mark - Device macro

#define IS_IPHONE4  (CGSizeEqualToSize(CGSizeMake(320.0f, 480.0f), [[UIScreen mainScreen] bounds].size) ? YES : NO)
#define IS_IPHONE5  (CGSizeEqualToSize(CGSizeMake(320.0f, 568.0f), [[UIScreen mainScreen] bounds].size) ? YES : NO)
#define IS_IPHONE6  (CGSizeEqualToSize(CGSizeMake(375.0f, 667.0f), [[UIScreen mainScreen] bounds].size) ? YES : NO)
#define IS_IPHONE6P (CGSizeEqualToSize(CGSizeMake(414.0f, 736.0f), [[UIScreen mainScreen] bounds].size) ? YES : NO)

// 获取系统版本
#define CURRENT_SYSTEMVERSION [[UIDevice currentDevice] systemVersion]
#ifndef IOS_VERSION
#define IOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]
#endif

/**
 *  Macros that returns if the iOS version is greater or equal to choosed one
 *
 *  @return Returns a BOOL
 */
#define IS_IOS_5_OR_LATER    (IOS_VERSION >= 5.0)
#define IS_IOS_6_OR_LATER    (IOS_VERSION >= 6.0)
#define IS_IOS_7_OR_LATER    (IOS_VERSION >= 7.0)
#define IS_IOS_8_OR_LATER    (IOS_VERSION >= 8.0)
#define IS_IOS_9_OR_LATER    (IOS_VERSION >= 9.0)


/**
 *  Macros to compare system versions
 *
 *  @param v Version, like @"8.0"
 *
 *  @return Return a BOOL
 */
// 检查系统版本
#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

#define APP_VERSIONNO [[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"]
#define APP_BUILDNO [[NSBundle mainBundle] infoDictionary][@"CFBundleVersion"]

// 获取当前语言
#define CurrentLanguage [[NSLocale preferredLanguages] objectAtIndex:0]

// 判断是真机还是模拟器
#if TARGET_OS_IPHONE
// iPhone Device
#endif

#if TARGET_IPHONE_SIMULATOR
// iPhone Simulator
#endif


#pragma mark -
#pragma mark - data change macro

// 由角度获取弧度 由弧度获取角度
#define DEGREES_TO_RADIANS(x)       ((x) * (M_PI / 180.0))
#define RADIANS_TO_DEGREES(x)       ((x) * (180.0 / M_PI))

//RGB color macro
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


#pragma mark -
#pragma mark - Func

// 测试
#ifdef __OPTIMIZE__
#define USE_TEST_HELP           0
#else
#define USE_TEST_HELP           1
#endif

// API明文加密
#define API_RSA                 1


#pragma mark -
#pragma mark - Log

#ifndef LLog
#define LLogF(format, ...) NSLog(@"%s:%i: %@", __FILE__, __LINE__, [NSString stringWithFormat:format, ##__VA_ARGS__]);

#ifdef DEBUG
#define LLog(format, ...) LLogF(format, ##__VA_ARGS__);
#else
#define LLog(format, ...) while(0){}
#endif
#endif


// DEBUG开关
#ifndef __OPTIMIZE__
#define COMMON_DEBUG    1
#endif

// Log写入文件标识
#if (COMMON_DEBUG)
#define COMMON_LOGINFILE 0
#endif

#if (__OPTIMIZE__ ) //(__OPTIMIZE__ && (COMMON_RUNFOR_DISTRIBUTION == 0))
#define COMMON_DEBUG    0
#endif



#pragma mark - Text lenth macro



#pragma mark -
#pragma mark - UI macro

#define UI_NAVIGATION_BAR_DEFAULTHEIGHT 44
#define UI_NAVIGATION_BAR_HEIGHT        44
#define UI_TOOL_BAR_HEIGHT              44
#define UI_TAB_BAR_HEIGHT               49
#define UI_TAB_BAR_HEIGHT_OFFY          9
#define UI_STATUS_BAR_HEIGHT            20
#define UI_SCREEN_WIDTH                 ([[UIScreen mainScreen] bounds].size.width)
#define UI_SCREEN_HEIGHT                ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_WIDTH ((([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortrait) || ([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortraitUpsideDown)) ? [[UIScreen mainScreen] bounds].size.width : [[UIScreen mainScreen] bounds].size.height)
#define SCREEN_HEIGHT ((([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortrait) || ([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortraitUpsideDown)) ? [[UIScreen mainScreen] bounds].size.height : [[UIScreen mainScreen] bounds].size.width)
#define UI_SCREEN_SCALE                 ([UIScreen mainScreen].scale)
#define UI_MAINSCREEN_HEIGHT            (UI_SCREEN_HEIGHT - UI_STATUS_BAR_HEIGHT)
#define UI_MAINSCREEN_HEIGHT_ROTATE     (UI_SCREEN_WIDTH - UI_STATUS_BAR_HEIGHT)
#define UI_WHOLE_SCREEN_FRAME           CGRectMake(0, 0, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT)
#define UI_WHOLE_SCREEN_FRAME_ROTATE    CGRectMake(0, 0, UI_SCREEN_HEIGHT, UI_SCREEN_WIDTH)
#define UI_MAIN_VIEW_FRAME              CGRectMake(0, UI_STATUS_BAR_HEIGHT, UI_SCREEN_WIDTH, UI_MAINSCREEN_HEIGHT)
#define UI_MAIN_VIEW_FRAME_ROTATE       CGRectMake(0, UI_STATUS_BAR_HEIGHT, UI_SCREEN_HEIGHT, UI_MAINSCREEN_HEIGHT_ROTATE)

#define UI_IPHONE4_SCREEN_HEIGHT        480.0f
#define UI_IPHONE5_SCREEN_HEIGHT        568.0f
#define UI_IPHONE6_SCREEN_HEIGHT        667.0f
#define UI_IPHONE6P_SCREEN_HEIGHT       736.0f


// 单像素
#define SINGLE_LINE_WIDTH           (1 / [UIScreen mainScreen].scale)
#define SINGLE_LINE_ADJUST_OFFSET   ((1 / [UIScreen mainScreen].scale) / 2)
// UIView *view = [[UIView alloc] initWithFrame:CGrect(x - SINGLE_LINE_ADJUST_OFFSET, 0, SINGLE_LINE_WIDTH, 100)];


#pragma mark -
#pragma mark - Default define

// 照片压缩质量
#define LAMA_PHOTO_COMPRESSIONQUALITY   (0.7f)

// 动画默认时长
#define DEFAULT_DELAY_TIME              (0.25f)
// 等待默认时长
#define PROGRESSBOX_DEFAULT_HIDE_DELAY  (1.0f)

#define TIMEZONE_BEIJING [NSTimeZone timeZoneWithName:@"Asia/Shanghai"]

#define TABLE_EACH_LOAD_COUNT           20

#define PASSWORD_MAXLENGTH              16
#define PASSWORD_MINLENGTH              6

#define VERIFICATIONCODE_LENGTH         6

#define LABEL_DEFAULT_TEXT              @"- -"

#define ESQPHONENUMBER                  @"400-6656-191"


#pragma mark -
#pragma mark - UI config

#pragma mark - Control Color

#define RGBColor(r,g,b,a)                   [UIColor colorWithRed:r/255. green:g/255. blue:b/255. alpha:a]

// 以下请从 mark - Color 中选取颜色
// PopView背景颜色
#define UI_POPVIEW_BGCOLOR                  [UIColor colorWithHex:0xFFFFFF]

// View背景颜色
#define UI_VIEW_BGCOLOR                     UI_COLOR_B7

// 导航条背景颜色
#define UI_NAVIGATION_BGCOLOR_VALUE         0xF13E3E
#define UI_NAVIGATION_BGCOLOR               [UIColor colorWithHex:UI_NAVIGATION_BGCOLOR_VALUE]

// 工具条背景颜色
#define UI_BAR_BGCOLOR                      UI_COLOR_B6
#define UI_BAR_TEXTNORMALCOLOR              UI_COLOR_B2
#define UI_BAR_TEXTSELECTCOLOR              UI_COLOR_R1
#define UI_SUBBAR_BGCOLOR                   [UIColor colorWithHex:0xD5ECFB]

// 文本颜色
#define UI_TEXT_TITLE_DEFAULTCOLOR          UI_COLOR_B1
#define UI_TEXT_CONTENT_DEFAULTCOLOR        UI_COLOR_B2
#define UI_TEXT_DETAIL_DEFAULTCOLOR         UI_COLOR_B2
#define UI_TEXT_COUNT_DEFAULTCOLOR          UI_COLOR_R1
#define UI_TEXT_OTHER_DEFAULTCOLOR          UI_COLOR_B2

// Cell背景颜色
#define UI_CELL_BGCOLOR                     UI_COLOR_B7

// Cell选中状态背景颜色
#define UI_CELL_SELECT_BGCOLOR              UI_COLOR_B5

// 分割线颜色
#define UI_DEFAULT_LINECOLOR                UI_COLOR_B2
#define UI_DEFAULT_CHARTCOLOR               UI_COLOR_BL2

// 辅助色
#define UI_DEFAULT_REDCOLOR                 UI_COLOR_R1
#define UI_DEFAULT_YELLOWCOLOR              UI_COLOR_Y
#define UI_DEFAULT_GREENCOLOR               UI_COLOR_G
#define UI_DEFAULT_BLUECOLOR                UI_COLOR_BL1

// 警告错误
#define UI_DEFAULT_ERRORCOLOR               [UIColor colorWithHex:0xFF0000]


#pragma mark -
#pragma mark UI Font

// UI_MQ_FONT32
#define UI_MQ_FONTBIGGEST       UI_MQ_FONTNO07
// UI_MQ_FONT18
#define UI_MQ_FONTBIG           UI_MQ_FONTNO01
// UI_MQ_FONT16
#define UI_MQ_FONTMIDDLE1       UI_MQ_FONTNO02
// UI_MQ_FONT14
#define UI_MQ_FONTMIDDLE2       UI_MQ_FONTNO03
// UI_MQ_FONT12
#define UI_MQ_FONTSMALL         UI_MQ_FONTNO04


//************ 整体的一些公共尺寸 ***************//

// 距离导航栏距离
#define UI_TOP_SIDE_18                  (18.0f)
#define UI_TOP_VIEWSIDE_15              (15.0)

// 距离左边距离
#define UI_LEFT_SIDE_15                 (15.0f)

// 距离右边距离
#define UI_RIGHT_SIDE_15                (15.0f)

#define UI_BOTTOM_SIDE_10               (10.0f)

// 按钮的高度
#define UI_BUTTON_HEIGHT_44             (44.0f)
#define UI_BUTTON_HEIGHT_46             (46.0f)

// 提示Lable的高度
#define UI_REMINDER_LABLE_HEIGHT_20     (20)

// 按钮的圆角
#define UI_BUTTON_RADIUS_3              (3.0f)
#define UI_BUTTON_RADIUS_6              (6.0f)

// table header section height
#define TABLE_HEADERINSECTION_HEIGHT    (8.0f)

#define TABLE_CELL_HEIGHT               (44.0f)


// *****************通知************************** // 



#pragma mark -
#pragma mark typedef

typedef NS_OPTIONS(NSInteger, MQRefreshType)
{
    MQRefreshType_NONE = 0,
    MQRefreshType_Head = 1 << 0 ,
    MQRefreshType_Bottom = 1 << 1
};

// 每次加载数据的方式 按页取/按个数取
typedef NS_ENUM(NSInteger, MQLoadDataType)
{
    MQLoadDataType_None = 0,
    MQLoadDataType_Page = 1,
    MQLoadDataType_ID,
    MQLoadDataType_Time = MQLoadDataType_ID,
    MQLoadDataType_Count
};


#endif
