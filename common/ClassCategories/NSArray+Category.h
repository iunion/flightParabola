//
//  NSArray+NSArray_Category.h
//  lama
//
//  Created by mac on 13-12-18.
//  Copyright (c) 2013年 babytree. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (Category)

/**
 *  Convert the given array to JSON as NSString
 *
 *  @param array The array to be reversed
 *
 *  @return Return the JSON as NSString or nil if error while parsing
 */
+ (NSString *)arrayToJSON:(NSArray*)array;
+ (NSString *)arrayToJSON:(NSArray*)array options:(NSJSONWritingOptions)options;

- (NSString *)toJSON;
- (NSString *)toJSONWithOptions:(NSJSONWritingOptions)options;

/**
 *  Create a reversed array from the given array
 *
 *  @param array The array to be converted
 *
 *  @return Return the reversed array
 */
+ (NSArray *)reversedArray:(NSArray *)array;

// 随机获取一个元素
- (id)randomObject;

/**
 *  Get the object at a given index in safe mode (nil if self is empty or out of range)
 *
 *  @param index The index
 *
 *  @return Return the object at a given index in safe mode (nil if self is empty or out of range)
 */
- (id)safeObjectAtIndex:(NSUInteger)index;

/**
 *  Simulates the array as a circle. When it is out of range, begins again
 *
 *  @param index The index
 *
 *  @return Return the object at a given index
 */
+ (NSInteger)circleIndex:(NSInteger)index maxSize:(NSInteger)maxSize;

- (id)objectAtCircleIndex:(NSInteger)index;

/**
 *  Create a new array with count form begin to end
 *
 *  @param count the count of new array
 *
 *  @return a new array
 */
- (NSArray *)firstArrayWithCount:(NSUInteger)count;

/**
 *  Create a new array with count form end to begin
 *
 *  @param count the count of new array
 *
 *  @return a new array
 */
- (NSArray *)lastArrayWithCount:(NSUInteger)count;

/**
 *  将array分割成count个数的子array并创建新的MutableArray
 *
 *  @param count 子array的元素数
 *
 *  @return MutableArray
 */
- (NSMutableArray *)divisionWithCount:(NSUInteger)count;
- (NSMutableArray *)divisionWithCount:(NSUInteger)count1 andCount:(NSUInteger)count2;

/**
 *  Create a reversed array from self
 *
 *  @return Return the reversed array
 */
- (NSArray *)reversedArray;

- (NSArray *)sortedArray;
- (NSArray *)sortedCaseInsensitiveArray;


// 简单去重
- (NSArray *)uniqueArray;
// 简单合并
- (NSArray *)unionWithArray:(NSArray *)anArray;
// 简单交叉，找相同
- (NSArray *)intersectionWithArray:(NSArray *)anArray;
// 简单排除
- (NSArray *)differenceToArray:(NSArray *)anArray;

/*!
 Filter array.
 @param filterBlock Filter block
 */
- (NSArray *)filterArray:(BOOL(^)(id obj, NSUInteger index))filterBlock;

@end


@interface NSMutableArray (Category)

- (void)moveObjectToTop:(NSUInteger)index;

- (void)moveObjectFromIndex:(NSUInteger)oldIndex toIndex:(NSUInteger)newIndex;

- (NSMutableArray *)removeFirstObject;

// maxCount 数组最大容量
- (BOOL)addObject:(id)anObject withMaxCount:(NSUInteger)maxCount;
- (NSUInteger)addObjectsFromArray:(id)array withMaxCount:(NSUInteger)maxCount;

- (void)insertArray:(NSArray *)array atIndex:(NSUInteger)index;
- (NSUInteger)replaceObject:(id)objectToReplace withObject:(id)object;

- (void)shuffle;

@end

