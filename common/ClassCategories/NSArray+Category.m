//
//  NSArray+NSArray_Category.m
//  lama
//
//  Created by mac on 13-12-18.
//  Copyright (c) 2013年 babytree. All rights reserved.
//

#import "NSArray+Category.h"
#import "NSObject+Category.h"
#import <objc/runtime.h>

@implementation NSArray (Category)

+ (NSString *)arrayToJSON:(NSArray*)array
{
    // NSJSONWritingPrettyPrinted
    return [NSArray arrayToJSON:array options:0];
}

+ (NSString *)arrayToJSON:(NSArray*)array options:(NSJSONWritingOptions)options
{
    return [array toJSONWithOptions:options];
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

+ (NSArray *)reversedArray:(NSArray*)array
{
    NSMutableArray *arrayTemp = [NSMutableArray arrayWithCapacity:[array count]];
    NSEnumerator *enumerator = [array reverseObjectEnumerator];
    
    for (id element in enumerator)
    {
        [arrayTemp addObject:element];
    }
    
    return arrayTemp;
}


- (id)randomObject
{
    if (!self.count) return nil;
    
    static BOOL seeded = NO;
    if (!seeded) {seeded = YES; srandom((unsigned int) time(0));}
    
    NSUInteger whichItem = (NSUInteger)(random() % self.count);
    
    return self[whichItem];
}

- (id)safeObjectAtIndex:(NSUInteger)index
{
    if (self.count > 0 && self.count > index)
    {
        return [self objectAtIndex:index];
    }
    else
    {
        return nil;
    }
}

+ (NSInteger)circleIndex:(NSInteger)index maxSize:(NSInteger)maxSize
{
    if(index < 0)
    {
        index = index % maxSize;
        index += maxSize;
    }
    if(index >= maxSize)
    {
        index = index % maxSize;
    }
    
    return index;
}

- (id)objectAtCircleIndex:(NSInteger)index
{
    return [self objectAtIndex:[NSArray circleIndex:index maxSize:self.count]];
}

- (NSArray *)firstArrayWithCount:(NSUInteger)count
{
    if (self.count <= count)
    {
        return self;
    }
    
    NSRange range = NSMakeRange(0, count);
    NSIndexSet *indexSet = [[NSIndexSet alloc] initWithIndexesInRange:range];
    
    return [self objectsAtIndexes:indexSet];
}

- (NSArray *)lastArrayWithCount:(NSUInteger)count
{
    if (self.count <= count)
    {
        return self;
    }
    
    NSRange range = NSMakeRange(self.count-count, count);
    NSIndexSet *indexSet = [[NSIndexSet alloc] initWithIndexesInRange:range];
    
    return [self objectsAtIndexes:indexSet];
}

- (NSMutableArray *)divisionWithCount:(NSUInteger)count
{
    if (count == 0)
    {
        return nil;
    }
    
    NSMutableArray *arrayArray = [NSMutableArray arrayWithCapacity:0];
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
    
    for (NSUInteger index = 0; index < self.count; index++)
    {
        [array addObject:self[index]];
        
        if (((index+1) % count) == 0)
        {
            [arrayArray addObject:array];
            array = [NSMutableArray array];
        }
    }
    
    if (array.count > 0)
    {
        [arrayArray addObject:array];
    }
    
    return arrayArray;
}

- (NSMutableArray *)divisionWithCount:(NSUInteger)count1 andCount:(NSUInteger)count2
{
    if (count1 == 0)
    {
        return nil;
    }

    if (count2 == 0)
    {
        return [self divisionWithCount:count1];
    }

    NSMutableArray *arrayArray = [NSMutableArray arrayWithCapacity:0];
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
    
    for (NSUInteger index = 0; index < self.count; index++)
    {
        [array addObject:self[index]];
        
        if (((index+1) % (count1+count2)) == 0)
        {
            NSArray *array1 = [array firstArrayWithCount:count1];
            NSArray *array2 = [array lastArrayWithCount:count2];
            [arrayArray addObject:array1];
            [arrayArray addObject:array2];
            array = [NSMutableArray array];
        }
    }
    
    if (array.count > 0)
    {
        NSArray *array1 = [array firstArrayWithCount:count1];
        
        [arrayArray addObject:array1];
        
        if (array.count > array1.count)
        {
            NSArray *array2 = [array lastArrayWithCount:(array.count - array1.count)];
            
            [arrayArray addObject:array2];
        }
    }
    
    return arrayArray;
}

- (NSArray *)reversedArray
{
    return [NSArray reversedArray:self];
}

- (NSArray *)sortedArray
{
    NSArray *resultArray = [self sortedArrayUsingComparator:
                            ^(id obj1, id obj2){return [obj1 compare:obj2];}];
    return resultArray;
}

- (NSArray *)sortedCaseInsensitiveArray
{
    NSArray *resultArray = [self sortedArrayUsingComparator:
                            ^(id obj1, id obj2){return [obj1 caseInsensitiveCompare:obj2];}];
    return resultArray;
}

- (NSArray *)uniqueArray
{
    return [NSOrderedSet orderedSetWithArray:self].array.copy;
}

- (NSArray *)unionWithArray:(NSArray *)anArray
{
    NSMutableOrderedSet *set1 = [NSMutableOrderedSet orderedSetWithArray:self];
    NSMutableOrderedSet *set2 = [NSMutableOrderedSet orderedSetWithArray:anArray];
    
    [set1 unionOrderedSet:set2];
    
    return set1.array.copy;
}

- (NSArray *)intersectionWithArray:(NSArray *)anArray
{
    NSMutableOrderedSet *set1 = [NSMutableOrderedSet orderedSetWithArray:self];
    NSMutableOrderedSet *set2 = [NSMutableOrderedSet orderedSetWithArray:anArray];
    
    [set1 intersectOrderedSet:set2];
    
    return set1.array.copy;
}

- (NSArray *)differenceToArray:(NSArray *)anArray
{
    NSMutableOrderedSet *set1 = [NSMutableOrderedSet orderedSetWithArray:self];
    NSMutableOrderedSet *set2 = [NSMutableOrderedSet orderedSetWithArray:anArray];
    
    [set1 minusOrderedSet:set2];
    
    return set1.array.copy;
}

- (NSArray *)filterArray:(BOOL(^)(id obj, NSUInteger index))filterBlock
{
    NSMutableArray *filteredArray = [NSMutableArray arrayWithCapacity:[self count]];
    NSUInteger i = 0;
    for (id obj in self)
    {
        if (filterBlock(obj, i))
        {
            [filteredArray addObject:obj];
        }
        i++;
    }
    
    return [NSArray arrayWithArray:filteredArray];
}

@end


#pragma mark -
#pragma mark NSMutableArray

@implementation NSMutableArray (Category)

- (void)moveObjectToTop:(NSUInteger)index
{
    [self moveObjectFromIndex:index toIndex:0];
}

- (void)moveObjectFromIndex:(NSUInteger)oldIndex toIndex:(NSUInteger)newIndex
{
    if (oldIndex == newIndex)
    {
		return;
    }
    
    if (oldIndex >= self.count || newIndex >= self.count)
    {
        return;
    }
    
    [self exchangeObjectAtIndex:newIndex withObjectAtIndex:oldIndex];
}

- (NSMutableArray *)removeFirstObject
{
	[self removeObjectAtIndex:0];
    
	return self;
}

- (BOOL)addObject:(id)anObject withMaxCount:(NSUInteger)maxCount
{
    if (![anObject isNotEmpty])
    {
        return NO;
    }
    
    if (self.count < maxCount)
    {
        [self addObject:anObject];
        return YES;
    }
    return NO;
}

- (NSUInteger)addObjectsFromArray:(id)array withMaxCount:(NSUInteger)maxCount
{
    NSUInteger count = 0;
    for (id anObject in array)
    {
        if ([self addObject:anObject withMaxCount:maxCount])
        {
            count++;
        }
        else
        {
            break;
        }
    }
    
    return count;
}

- (void)insertArray:(NSArray *)array atIndex:(NSUInteger)index
{
    NSIndexSet *indexes = [[NSIndexSet alloc] initWithIndexesInRange:NSMakeRange(index, [array count])];
    [self insertObjects:array atIndexes:indexes];
}

- (NSUInteger)replaceObject:(id)objectToReplace withObject:(id)object
{
    NSUInteger index = [self indexOfObject:objectToReplace];
    if (index != NSNotFound)
    {
        [self replaceObjectAtIndex:index withObject:object];
    }
    
    return index;
}

- (void)shuffle
{
    for (NSInteger i = (NSInteger)[self count] - 1; i > 0; i--)
    {
        NSUInteger j = (NSUInteger)arc4random_uniform((uint32_t)i + 1);
        [self exchangeObjectAtIndex:j withObjectAtIndex:(NSUInteger)i];
    }
}

@end

