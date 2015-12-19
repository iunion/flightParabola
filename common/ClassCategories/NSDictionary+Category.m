#import "NSDictionary+Category.h"
#import "NSObject+Category.h"
#import "NSDate+Category.h"
#import "NSString+Category.h"

@implementation NSDictionary (Category)

- (long long)longForKey:(id)key
{
    return [self longForKey:key withDefault:0];
}

- (long long)longForKey:(id)key withDefault:(long long)theDefault
{
    long long value = 0;
    
    id object = [self objectForKey:key];
    if ([object isValided] && ([object isKindOfClass:[NSNumber class]] || [object isKindOfClass:[NSString class]]))
    {
        value = [object longLongValue];
    }
    
    return value;
}

- (NSInteger)intForKey:(id)key
{
    return [self intForKey:key withDefault:0];
}

- (NSInteger)intForKey:(id)key withDefault:(NSInteger)theDefault
{
    NSInteger value = theDefault;
    
    id object = [self objectForKey:key];
    if ([object isValided] && ([object isKindOfClass:[NSNumber class]] || [object isKindOfClass:[NSString class]]))
    {
        value = [object integerValue];
    }
    
    return value;
}

- (NSUInteger)uintForKey:(id)key
{
    return [self uintForKey:key withDefault:0];
}

- (NSUInteger)uintForKey:(id)key withDefault:(NSUInteger)theDefault
{
    NSInteger value = theDefault;
    
    id object = [self objectForKey:key];
    if ([object isValided] && ([object isKindOfClass:[NSNumber class]] || [object isKindOfClass:[NSString class]]))
    {
        if ([object isKindOfClass:[NSString class]])
        {
            NSNumberFormatter *nf = [[NSNumberFormatter alloc] init];
            object = [nf numberFromString:object];
        }
        
        if ([object isKindOfClass:[NSNumber class]])
        {
            return [object unsignedIntegerValue];
        }
    }
    
    return value;
}

- (BOOL)boolForKey:(id)key
{
    return [self boolForKey:key withDefault:NO];
}

- (BOOL)boolForKey:(id)key withDefault:(BOOL)theDefault
{
    BOOL value = theDefault;
    
    id object = [self objectForKey:key];
    if ([object isValided] && ([object isKindOfClass:[NSNumber class]] || [object isKindOfClass:[NSString class]]))
    {
        value = [object boolValue];
    }
    
    return value;
}

- (float)floatForKey:(id)key
{
    return [self floatForKey:key withDefault:0.0f];
}

- (float)floatForKey:(id)key withDefault:(float)theDefault
{
    float value = theDefault;
    
    id object = [self objectForKey:key];
    if ([object isValided] && ([object isKindOfClass:[NSNumber class]] || [object isKindOfClass:[NSString class]]))
    {
        value = [object floatValue];
    }
    
    return value;
}

- (double)doubleForKey:(id)key
{
    return [self doubleForKey:key withDefault:0.0f];
}

- (double)doubleForKey:(id)key withDefault:(double)theDefault
{
    double value = theDefault;
    
    id object = [self objectForKey:key];
    if ([object isValided] && ([object isKindOfClass:[NSNumber class]] || [object isKindOfClass:[NSString class]]))
    {
        value = [object doubleValue];
    }
    
    return value;
}

- (NSDate *)dateForKey:(id)key
{
    return [self dateForKey:key withDefault:nil format:nil];
}

- (NSDate *)dateForKey:(id)key withFormat:(NSString *)format
{
    return [self dateForKey:key withDefault:nil format:format];
}

- (NSDate *)dateForKey:(id)key withDefault:(NSDate *)theDefault format:(NSString *)format
{
    NSDate *value = theDefault;
    
    id object = [self objectForKey:key];
    
    if ([object isValided])
    {
        if ([object isKindOfClass:[NSDate class]])
        {
            return object;
        }
        else if (format == nil && ([object isKindOfClass:[NSNumber class]] || [object isKindOfClass:[NSString class]]))
        {
            value = [NSDate dateWithTimeIntervalSince1970:[object doubleValue]];
        }
        else if (format && [object isKindOfClass:[NSString class]])
        {
            value = [NSDate dateFromString:object withFormat:format];
        }
    }
    
    return value;
}

- (NSString *)stringForKey:(id)key
{
    return [self stringForKey:key withDefault:nil];
}

- (NSString *)stringForKey:(id)key withDefault:(NSString *)theDefault
{
    NSString *value = theDefault;
    
    id object = [self objectForKey:key];
    if ([object isValided] && [object isKindOfClass:[NSString class]])
    {
        value = object;
    }
    else if ([object isValided] && [object isKindOfClass:[NSNumber class]])
    {
        value = [object stringValue];
    }
    
    return value;
}

- (NSString *)stringTrimForKey:(id)key
{
    return [self stringTrimForKey:key withDefault:nil];
}

- (NSString *)stringTrimForKey:(id)key withDefault:(NSString *)theDefault
{
    NSString *value = [self stringForKey:key withDefault:theDefault];
    
    return [value trim];
}

- (CGPoint)pointForKey:(id)key
{
    CGPoint point = CGPointZero;
    NSDictionary *dictionary = [self valueForKey:key];
    
    if ([dictionary isValided] && [dictionary isKindOfClass:[NSDictionary class]])
    {
        BOOL success = CGPointMakeWithDictionaryRepresentation((__bridge CFDictionaryRef)dictionary, &point);
        if (success)
            return point;
        else
            return CGPointZero;
    }
    
    return CGPointZero;
}

- (CGSize)sizeForKey:(id)key
{
    CGSize size = CGSizeZero;
    NSDictionary *dictionary = [self valueForKey:key];
    
    if ([dictionary isValided] && [dictionary isKindOfClass:[NSDictionary class]])
    {
        BOOL success = CGSizeMakeWithDictionaryRepresentation((__bridge CFDictionaryRef)dictionary, &size);
        if (success)
            return size;
        else
            return CGSizeZero;
    }
    
    return CGSizeZero;
}

- (CGRect)rectForKey:(id)key
{
    CGRect rect = CGRectZero;
    NSDictionary *dictionary = [self valueForKey:key];
    
    if ([dictionary isValided] && [dictionary isKindOfClass:[NSDictionary class]])
    {
        BOOL success = CGRectMakeWithDictionaryRepresentation((__bridge CFDictionaryRef)dictionary, &rect);
        if (success)
            return rect;
        else
            return CGRectZero;
    }
    
    return CGRectZero;
}

- (NSArray *)arrayForKey:(id)key
{
    NSArray *value = nil;
    
    id object = [self objectForKey:key];
    if ([object isValided] && [object isKindOfClass:[NSArray class]])
    {
        value = object;
    }
    
    return value;
}

- (NSDictionary *)dictionaryForKey:(id)key
{
    NSDictionary *value = nil;
    
    id object = [self objectForKey:key];
    if ([object isValided] && [object isKindOfClass:[NSDictionary class]])
    {
        value = object;
    }
    
    return value;
}

- (BOOL)containsObjectForKey:(id)key
{
    return [[self allKeys] containsObject:key];
}

- (NSString *)toJSON
{
    // NSJSONWritingPrettyPrinted
    return [self toJSONWithOptions:0];
}

- (NSString *)toJSONWithOptions:(NSJSONWritingOptions)options
{
    NSString *json = nil;
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:options error:&error];
    
    if (!jsonData)
    {
        return @"{}";
    }
    else if (!error)
    {
        json = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        return json;
    }
    else
    {
        NSLog(@"%@", error.localizedDescription);
    }
    
    return nil;
}

@end


@implementation NSDictionary (DeepMutableCopy)


- (NSMutableDictionary *)deepMutableCopy;
{
    NSMutableDictionary *newDictionary;
    NSEnumerator *keyEnumerator;
    id anObject;
    id aKey;
	
    newDictionary = [self mutableCopy];
    // Run through the new dictionary and replace any objects that respond to -deepMutableCopy or -mutableCopy with copies.
    keyEnumerator = [[newDictionary allKeys] objectEnumerator];
    while ((aKey = [keyEnumerator nextObject])) {
        anObject = [newDictionary objectForKey:aKey];
        if ([anObject respondsToSelector:@selector(deepMutableCopy)]) {
            anObject = [anObject deepMutableCopy];
            [newDictionary setObject:anObject forKey:aKey];
            //[anObject ah_release];
        } else if ([anObject respondsToSelector:@selector(mutableCopyWithZone:)]) {
            anObject = [anObject mutableCopyWithZone:nil];
            [newDictionary setObject:anObject forKey:aKey];
            //[anObject ah_release];
        } else {
			[newDictionary setObject:anObject forKey:aKey];
		}
    }
	
    return newDictionary;
}

@end


@implementation NSMutableDictionary (bbCategory)

- (void)setInt:(NSInteger)value forKey:(NSString *)key
{
    NSNumber *number = [NSNumber numberWithInteger:value];
    [self setObject:number forKey:key];    
}

- (void)setUInt:(NSUInteger)value forKey:(NSString *)key
{
    NSNumber *number = [NSNumber numberWithUnsignedInteger:value];
    [self setObject:number forKey:key];
}

- (void)setBool:(BOOL)value forKey:(NSString *)key
{
    NSNumber *number = [NSNumber numberWithBool:value];
    [self setObject:number forKey:key];    
}

- (void)setFloat:(float)value forKey:(NSString *)key
{
    NSNumber *number = [NSNumber numberWithFloat:value];
    [self setObject:number forKey:key];
}

- (void)setDouble:(double)value forKey:(NSString *)key
{
    NSNumber *number = [NSNumber numberWithDouble:value];
    [self setObject:number forKey:key];
}

- (void)setString:(NSString *)value forKey:(NSString *)key
{
    if (!value)
    {
       return;
    }
    [self setObject:value forKey:key];
}

- (void)setPoint:(CGPoint)value forKey:(NSString *)key
{
    CFDictionaryRef dictionary = CGPointCreateDictionaryRepresentation(value);
    NSDictionary *pointDict = [NSDictionary dictionaryWithDictionary:
                               (__bridge NSDictionary *)dictionary]; // autoreleased
    CFRelease(dictionary);
    
    [self setValue:pointDict forKey:key];
}

- (void)setSize:(CGSize)value forKey:(NSString *)key
{
    CFDictionaryRef dictionary = CGSizeCreateDictionaryRepresentation(value);
    NSDictionary *sizeDict = [NSDictionary dictionaryWithDictionary:
                               (__bridge NSDictionary *)dictionary]; // autoreleased
    CFRelease(dictionary);
    
    [self setValue:sizeDict forKey:key];
}

- (void)setRect:(CGRect)value forKey:(NSString *)key
{
    CFDictionaryRef dictionary = CGRectCreateDictionaryRepresentation(value);
    NSDictionary *rectDict = [NSDictionary dictionaryWithDictionary:
                              (__bridge NSDictionary *)dictionary]; // autoreleased
    CFRelease(dictionary);
    
    [self setValue:rectDict forKey:key];
}

@end
