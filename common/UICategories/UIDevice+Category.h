//
//  UIDevice+BFKit.h
//  BFKit
//
//  The MIT License (MIT)
//
//  Copyright (c) 2014 - 2015 Fabrizio Brancati. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.

@import Foundation;
@import UIKit;

@interface UIDevice (Category)

/**
 *  Returns the device platform string
 *  Example: "iPhone7,2"
 *
 *  @return Returns the device platform string
 */
+ (NSString *)devicePlatform;
/**
 *  Returns the user-friendly device platform string
 *  Example: "iPad Air (Cellular)"
 *
 *  @return Returns the user-friendly device platform string
 */
+ (NSString *)devicePlatformString;

/**
 *  Check if the current device is an iPad
 *
 *  @return Returns YES if it's an iPad, NO if not
 */
+ (BOOL)isiPad;

/**
 *  Check if the current device is an iPhone
 *
 *  @return Returns YES if it's an iPhone, NO if not
 */
+ (BOOL)isiPhone;

/**
 *  Check if the current device is an iPod
 *
 *  @return Returns YES if it's an iPod, NO if not
 */
+ (BOOL)isiPod;

/**
 *  Check if the current device is an Apple TV
 *
 *  @return Returns YES if it's an Apple TV, NO if not
 */
+ (BOOL)isAppleTV;

/**
 *  Check if the current device is an Apple Watch
 *
 *  @return Returns YES if it's an Apple Watch, NO if not
 */
+ (BOOL)isAppleWatch;

/**
 *  Check if the current device is the simulator
 *
 *  @return Returns YES if it's the simulator, NO if not
 */
+ (BOOL)isSimulator;

/**
 *  Check if the current device has a Retina display
 *
 *  @return Returns YES if it has a Retina display, NO if not
 */
+ (BOOL)isRetina;

/**
 *  Check if the current device has a Retina HD display
 *
 *  @return Returns YES if it has a Retina HD display, NO if not
 */
+ (BOOL)isRetinaHD;

/**
 *  Returns the iOS version without the subversion
 *  Example: 7
 *
 *  @return Returns the iOS version
 */
+ (CGFloat)iOSVersion;

/**
 *  Returns the current device CPU frequency
 *
 *  @return Returns the current device CPU frequency
 */
+ (NSUInteger)cpuFrequency;

/**
 *  Returns the current device BUS frequency
 *
 *  @return Returns the current device BUS frequency
 */
+ (NSUInteger)busFrequency;

/**
 *  Returns the current device RAM size
 *
 *  @return Returns the current device RAM size
 */
+ (NSUInteger)ramSize;

/**
 *  Returns the current device CPU number
 *
 *  @return Returns the current device CPU number
 */
+ (NSUInteger)cpuNumber;

/**
 *  Returns the current device total memory
 *
 *  @return Returns the current device total memory
 */
+ (NSUInteger)totalMemory;

/**
 *  Returns the current device non-kernel memory
 *
 *  @return Returns the current device non-kernel memory
 */
+ (NSUInteger)userMemory;

/**
 *  Returns the current device total disk space
 *
 *  @return Returns the current device total disk space
 */
+ (NSNumber *)totalDiskSpace;

/**
 *  Returns the current device free disk space
 *
 *  @return Returns the current device free disk space
 */
+ (NSNumber *)freeDiskSpace;

@end
