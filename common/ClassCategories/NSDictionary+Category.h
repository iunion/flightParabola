
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSDictionary (Category)

- (long long)longForKey:(id)key;
- (long long)longForKey:(id)key withDefault:(long long)theDefault;
- (NSInteger)intForKey:(id)key;
- (NSInteger)intForKey:(id)key withDefault:(NSInteger)theDefault;
- (NSUInteger)uintForKey:(id)key;
- (NSUInteger)uintForKey:(id)key withDefault:(NSUInteger)theDefault;
- (BOOL)boolForKey:(id)key;
- (BOOL)boolForKey:(id)key withDefault:(BOOL)theDefault;
- (float)floatForKey:(id)key;
- (float)floatForKey:(id)key withDefault:(float)theDefault;
- (double)doubleForKey:(id)key;
- (double)doubleForKey:(id)key withDefault:(double)theDefault;

- (NSDate *)dateForKey:(id)key;
- (NSDate *)dateForKey:(id)key withFormat:(NSString *)format;
- (NSDate *)dateForKey:(id)key withDefault:(NSDate *)theDefault format:(NSString *)format;

- (NSString *)stringForKey:(id)key;
- (NSString *)stringForKey:(id)key withDefault:(NSString *)theDefault;
- (NSString *)stringTrimForKey:(id)key;
- (NSString *)stringTrimForKey:(id)key withDefault:(NSString *)theDefault;

- (CGPoint)pointForKey:(id)key;
- (CGSize)sizeForKey:(id)key;
- (CGRect)rectForKey:(id)key;

- (NSArray *)arrayForKey:(id)key;
- (NSDictionary *)dictionaryForKey:(id)key;

- (BOOL)containsObjectForKey:(id)key;

- (NSString *)toJSON;
- (NSString *)toJSONWithOptions:(NSJSONWritingOptions)options;

@end

@interface NSDictionary (DeepMutableCopy)

- (NSMutableDictionary *)deepMutableCopy;

@end

@interface NSMutableDictionary (bbCategory)

- (void)setInt:(NSInteger)value forKey:(NSString *)key;
- (void)setUInt:(NSUInteger)value forKey:(NSString *)key;
- (void)setBool:(BOOL)value forKey:(NSString *)key;
- (void)setFloat:(float)value forKey:(NSString *)key;
- (void)setDouble:(double)value forKey:(NSString *)key;
- (void)setString:(NSString *)value forKey:(NSString *)key;

- (void)setPoint:(CGPoint)value forKey:(NSString *)key;
- (void)setSize:(CGSize)value forKey:(NSString *)key;
- (void)setRect:(CGRect)value forKey:(NSString *)key;

@end
