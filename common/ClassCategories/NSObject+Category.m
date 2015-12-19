//
//  NSObject+Category.m
//  Lehuo_Billiards
//
//  Created by qq on 12-8-7.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "NSObject+Category.h"
#if TARGET_OS_IPHONE
#import <objc/runtime.h>
#import <objc/message.h>
#else
#import <objc/objc-class.h>
#endif

@implementation NSObject (Category)

///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)performSelector:(SEL)selector withObject:(id)p1 withObject:(id)p2 withObject:(id)p3 {
    NSMethodSignature *sig = [self methodSignatureForSelector:selector];
    if (sig) {
        NSInvocation* invo = [NSInvocation invocationWithMethodSignature:sig];
        [invo setTarget:self];
        [invo setSelector:selector];
        [invo setArgument:&p1 atIndex:2];
        [invo setArgument:&p2 atIndex:3];
        [invo setArgument:&p3 atIndex:4];
        [invo invoke];
        if (sig.methodReturnLength) {
            id anObject;
            [invo getReturnValue:&anObject];
            return anObject;
            
        } else {
            return nil;
        }
        
    } else {
        return nil;
    }
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)performSelector:(SEL)selector withObject:(id)p1 withObject:(id)p2 withObject:(id)p3
           withObject:(id)p4 {
    NSMethodSignature *sig = [self methodSignatureForSelector:selector];
    if (sig) {
        NSInvocation* invo = [NSInvocation invocationWithMethodSignature:sig];
        [invo setTarget:self];
        [invo setSelector:selector];
        [invo setArgument:&p1 atIndex:2];
        [invo setArgument:&p2 atIndex:3];
        [invo setArgument:&p3 atIndex:4];
        [invo setArgument:&p4 atIndex:5];
        [invo invoke];
        if (sig.methodReturnLength) {
            id anObject;
            [invo getReturnValue:&anObject];
            return anObject;
            
        } else {
            return nil;
        }
        
    } else {
        return nil;
    }
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)performSelector:(SEL)selector withObject:(id)p1 withObject:(id)p2 withObject:(id)p3
           withObject:(id)p4 withObject:(id)p5 {
    NSMethodSignature *sig = [self methodSignatureForSelector:selector];
    if (sig) {
        NSInvocation* invo = [NSInvocation invocationWithMethodSignature:sig];
        [invo setTarget:self];
        [invo setSelector:selector];
        [invo setArgument:&p1 atIndex:2];
        [invo setArgument:&p2 atIndex:3];
        [invo setArgument:&p3 atIndex:4];
        [invo setArgument:&p4 atIndex:5];
        [invo setArgument:&p5 atIndex:6];
        [invo invoke];
        if (sig.methodReturnLength) {
            id anObject;
            [invo getReturnValue:&anObject];
            return anObject;
            
        } else {
            return nil;
        }
        
    } else {
        return nil;
    }
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)performSelector:(SEL)selector withObject:(id)p1 withObject:(id)p2 withObject:(id)p3
           withObject:(id)p4 withObject:(id)p5 withObject:(id)p6 {
    NSMethodSignature *sig = [self methodSignatureForSelector:selector];
    if (sig) {
        NSInvocation* invo = [NSInvocation invocationWithMethodSignature:sig];
        [invo setTarget:self];
        [invo setSelector:selector];
        [invo setArgument:&p1 atIndex:2];
        [invo setArgument:&p2 atIndex:3];
        [invo setArgument:&p3 atIndex:4];
        [invo setArgument:&p4 atIndex:5];
        [invo setArgument:&p5 atIndex:6];
        [invo setArgument:&p6 atIndex:7];
        [invo invoke];
        if (sig.methodReturnLength) {
            id anObject;
            [invo getReturnValue:&anObject];
            return anObject;
            
        } else {
            return nil;
        }
        
    } else {
        return nil;
    }
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)performSelector:(SEL)selector withObject:(id)p1 withObject:(id)p2 withObject:(id)p3
           withObject:(id)p4 withObject:(id)p5 withObject:(id)p6 withObject:(id)p7 {
    NSMethodSignature *sig = [self methodSignatureForSelector:selector];
    if (sig) {
        NSInvocation* invo = [NSInvocation invocationWithMethodSignature:sig];
        [invo setTarget:self];
        [invo setSelector:selector];
        [invo setArgument:&p1 atIndex:2];
        [invo setArgument:&p2 atIndex:3];
        [invo setArgument:&p3 atIndex:4];
        [invo setArgument:&p4 atIndex:5];
        [invo setArgument:&p5 atIndex:6];
        [invo setArgument:&p6 atIndex:7];
        [invo setArgument:&p7 atIndex:8];
        [invo invoke];
        if (sig.methodReturnLength) {
            id anObject;
            [invo getReturnValue:&anObject];
            return anObject;
            
        } else {
            return nil;
        }
        
    } else {
        return nil;
    }
}

+ (NSString *)className
{
    return NSStringFromClass(self);
}

- (NSString *)className
{
    return [NSString stringWithUTF8String:class_getName([self class])];
}


- (BOOL)isValided
{
    return !(self == nil || [self isKindOfClass:[NSNull class]]);
}

- (BOOL)isNotNSNull
{
	return ![self isKindOfClass:[NSNull class]];
}

- (BOOL)isNotEmpty
{
    return !(self == nil
             || [self isKindOfClass:[NSNull class]]
             || ([self respondsToSelector:@selector(length)]
                 && [(NSData *)self length] == 0)
             || ([self respondsToSelector:@selector(count)]
                 && [(NSArray *)self count] == 0));
}


- (BOOL)isNotEmptyDictionary
{
    if ([self isNotEmpty])
    {
        return [self isKindOfClass:[NSDictionary class]];
    }
    
    return NO;
}


@end

/*
@implementation UIResponder(UIResponderInsertTextAdditions)

- (void)insertText:(NSString*)text
{
    // 获取系统剪贴板
    UIPasteboard* generalPasteboard= [UIPasteboard generalPasteboard];
    
    // 保存系统剪贴板内容，以便最后能恢复它们
    NSArray *items =generalPasteboard.items;
    
    //修改系统剪贴板的内容为要插入的文本
    generalPasteboard.string = text;
    
    // 告诉responder从系统剪贴板粘贴文本到当前光标位置
    [self paste: self];
    
    // 恢复系统剪贴板原有的内容
    generalPasteboard.items = items;
    
    // 释放临时数组items
    [items ah_release];
}

@end
*/


#define SetNSErrorFor(FUNC, ERROR_VAR, FORMAT,...)	\
if (ERROR_VAR) {	\
NSString *errStr = [NSString stringWithFormat:@"%s: " FORMAT,FUNC,##__VA_ARGS__]; \
*ERROR_VAR = [NSError errorWithDomain:@"NSCocoaErrorDomain" \
code:-1	\
userInfo:[NSDictionary dictionaryWithObject:errStr forKey:NSLocalizedDescriptionKey]]; \
}
#define SetNSError(ERROR_VAR, FORMAT,...) SetNSErrorFor(__func__, ERROR_VAR, FORMAT, ##__VA_ARGS__)

#if OBJC_API_VERSION >= 2
#define GetClass(obj)	object_getClass(obj)
#else
#define GetClass(obj)	(obj ? obj->isa : Nil)
#endif

@implementation NSObject (JRSwizzle)

+ (BOOL)swizzleMethod:(SEL)origSel_ withMethod:(SEL)altSel_ error:(NSError**)error_
{
    Method origMethod = class_getInstanceMethod(self, origSel_);
    if (!origMethod) {
#if TARGET_OS_IPHONE
        SetNSError(error_, @"original method %@ not found for class %@", NSStringFromSelector(origSel_), [self class]);
#else
        SetNSError(error_, @"original method %@ not found for class %@", NSStringFromSelector(origSel_), [self className]);
#endif
        return NO;
    }
    
    Method altMethod = class_getInstanceMethod(self, altSel_);
    if (!altMethod) {
#if TARGET_OS_IPHONE
        SetNSError(error_, @"alternate method %@ not found for class %@", NSStringFromSelector(altSel_), [self class]);
#else
        SetNSError(error_, @"alternate method %@ not found for class %@", NSStringFromSelector(altSel_), [self className]);
#endif
        return NO;
    }
    
    class_addMethod(self,
                    origSel_,
                    class_getMethodImplementation(self, origSel_),
                    method_getTypeEncoding(origMethod));
    class_addMethod(self,
                    altSel_,
                    class_getMethodImplementation(self, altSel_),
                    method_getTypeEncoding(altMethod));
    
    method_setImplementation(class_getInstanceMethod(self, origSel_), class_getMethodImplementation(self, altSel_));
    //method_exchangeImplementations(class_getInstanceMethod(self, origSel_), class_getInstanceMethod(self, altSel_));
    return YES;
}

+ (BOOL)swizzleClassMethod:(SEL)origSel_ withClassMethod:(SEL)altSel_ error:(NSError**)error_
{
    return [GetClass((id)self) swizzleMethod:origSel_ withMethod:altSel_ error:error_];
}

@end