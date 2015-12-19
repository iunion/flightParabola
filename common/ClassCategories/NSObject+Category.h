//
//  NSObject+Category.h
//  Lehuo_Billiards
//
//  Created by qq on 12-8-7.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+Frankenstein.h"

@interface NSObject (Category)

/**
 * Additional performSelector signatures that support up to 7 arguments.
 */
- (id)performSelector:(SEL)selector withObject:(id)p1 withObject:(id)p2 withObject:(id)p3;
- (id)performSelector:(SEL)selector withObject:(id)p1 withObject:(id)p2 withObject:(id)p3
           withObject:(id)p4;
- (id)performSelector:(SEL)selector withObject:(id)p1 withObject:(id)p2 withObject:(id)p3
           withObject:(id)p4 withObject:(id)p5;
- (id)performSelector:(SEL)selector withObject:(id)p1 withObject:(id)p2 withObject:(id)p3
           withObject:(id)p4 withObject:(id)p5 withObject:(id)p6;
- (id)performSelector:(SEL)selector withObject:(id)p1 withObject:(id)p2 withObject:(id)p3
           withObject:(id)p4 withObject:(id)p5 withObject:(id)p6 withObject:(id)p7;

- (BOOL)isValided;
- (BOOL)isNotNSNull;
- (BOOL)isNotEmpty;
- (BOOL)isNotEmptyDictionary;

+ (NSString *)className;
- (NSString *)className;

@end

/*
@interface UIResponder(UIResponderInsertTextAdditions)

- (void)insertText:(NSString*)text;

@end
*/

@interface NSObject (JRSwizzle)

+ (BOOL)swizzleMethod:(SEL)origSel_ withMethod:(SEL)altSel_ error:(NSError**)error_;
+ (BOOL)swizzleClassMethod:(SEL)origSel_ withClassMethod:(SEL)altSel_ error:(NSError**)error_;

@end
