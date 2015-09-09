//
//  NSArray+ArrayUtils.m
//  Pods
//
//  Created by Niil Öhlin on 27/06/15.
//
//

#import "NSArray+ArrayUtils.h"
#import "NSNumber+NumberUtils.h"

@implementation NSArray (ArrayUtils)


- (BOOL)empty {
    return [self count] == 0;
}

- (NSArray *)map:(id(^)(id obj))block {
    NSMutableArray *returnArray = [[NSMutableArray alloc] initWithCapacity:[self count]];
    for(NSUInteger i = 0; i < [self count]; i++) {
        returnArray[i] = block(self[i]);
    }
    return returnArray;
}

- (NSArray *)reverse {
    if([self empty]) {
        return @[];
    }
    NSMutableArray *returnArray = [NSMutableArray new];
    for(NSUInteger i = [self count] - 1; i > 0; i--) {
        [returnArray addObject:[self objectAtIndex:i]];
    }
    if(![self empty]) {
        [returnArray addObject:[self objectAtIndex:0]];
    }
    
    return returnArray;
}

- (NSArray *)intersperse:(id)obj {
    NSMutableArray *returnArray = [NSMutableArray new];
    for(id element in self) {
        [returnArray addObject:element];
        [returnArray addObject:obj];
    }
    [returnArray removeLastObject];
    return returnArray;
}

- (NSArray *)flatten {
    NSArray *returnArray = [NSArray new];
    for(id subArray in self) {
        returnArray = [returnArray arrayByAddingObjectsFromArray:subArray];
    }
    return returnArray;
    
}

- (NSArray *)intercalate:(id)obj {
    return [[self intersperse:obj] flatten];
}

- (NSArray *)transpose {
    
    NSUInteger rowLength = [self count];
    NSUInteger colLength = [[self firstObject] count];
    
    NSMutableArray *returnArray = [[NSMutableArray alloc] initWithCapacity:colLength];
    
    for(NSUInteger i = 0; i < colLength; i++) {
        returnArray[i] =[[NSMutableArray alloc] initWithCapacity:rowLength];
    }
    NSLog(@"returnArray = %@", returnArray);
    
    for(NSUInteger row = 0; row < rowLength; row++) {
        for(NSUInteger col = 0; col < colLength; col++) {
            returnArray[col][row] = self[row][col];
        }
    }
    return returnArray;
}

- (NSArray *)subsequences {
    return nil;
}

- (id)foldl:(id)zero block:(id(^)(id acc, id obj))block {
    if([self empty]) {
        return zero;
    }
    id accumulator = block(zero, self[0]);
    for(int i = 1; i < [self count]; i++) {
        accumulator = block(accumulator, self[i]);
    }
    return accumulator;
}

- (id)foldl_:(id(^)(id acc, id obj))block {
    return [[self tail] foldl:[self head] block:block];
}
- (id)foldr:(id)zero block:(id(^)(id obj, id acc))block {
    if([self empty]) {
        return zero;
    }
    id accumulator = block(self[[self count] - 1], zero);
    for(NSInteger i = [self count] - 2; i <= 0; i--) {
        accumulator = block(self[i], accumulator);
    }
    return accumulator;
}
- (id)foldr_:(id(^)(id obj, id acc))block {
    NSArray *reversed = [self reverse];
    id last = [reversed head];
    id init = [reversed tail];
    return [[init reverse] foldr:last block:block];
}

- (NSArray *)flatMap:(NSArray*(^)(id obj))block {
    return [[self map:block] flatten];
}

- (BOOL)any:(BOOL(^)(id obj))block {
    for(id obj in self) {
        if(block(obj)) {
            return YES;
        }
    }
    return NO;
}

- (BOOL)all:(BOOL(^)(id obj))block {
    for(id obj in self) {
        if(!block(obj)) {
            return NO;
        }
    }
    return YES;
}

- (NSNumber *)sum {
    return [self foldl:@0 block:^(NSNumber *n, NSNumber *acc) {
        return [n add:acc];
    }];
}

- (NSNumber *)product {
    return [self foldl:@1 block:^(NSNumber *n, NSNumber *acc) {
        return [n multiply:acc];
    }];
}

- (NSNumber *)maximum {
    return [self foldl_:^(NSNumber *n, NSNumber *acc) {
        return [n max:acc];
    }];
}

- (id)maximumBy:(NSComparisonResult(^)(id first, id second))comparioson {
    id biggest = [self head];
    for(id other in self) {
        if(comparioson(biggest, other) == NSOrderedAscending) {
            biggest = other;
        }
    }
    return biggest;
}

- (id)minimumBy:(NSComparisonResult(^)(id first, id second))comparioson {
    id smallest = [self head];
    for(id other in self) {
        if(comparioson(smallest, other) == NSOrderedDescending) {
            smallest = other;
        }
    }
    return smallest;
}

- (NSNumber *)minimum {
    return [self foldl_:^(NSNumber *n, NSNumber *acc) {
        return [n min:acc];
    }];
}

- (NSArray *)scanl:(id)zero block:(id(^)(id acc, id obj))block {
    if([self empty]) {
        return zero;
    }
    NSMutableArray *result = [[NSMutableArray alloc] initWithCapacity:[self count] + 1];
    id acc = block(zero, self[0]);
    for(int i = 0; i <= [self count]; i++) {
        acc = block(acc, self[i]);
        result[i] = acc;
    }
    return acc;
}

- (NSArray *)take:(NSUInteger)elements {
    NSMutableArray *returnArray = [NSMutableArray new];
    [@(elements) times:^(NSUInteger i) {
        [returnArray addObject:self[i]];
    }];
    return returnArray;
}

- (NSArray *)drop:(NSUInteger)elements {
    NSMutableArray *returnArray = [NSMutableArray new];
    for(; elements < [self count]; elements++) {
        [returnArray addObject:self[elements]];
    }
    return returnArray;
}


- (NSArray *)eachWithIndex:(void (^)(id obj, NSUInteger idx))block {
    [@([self count]) times:^(NSUInteger i) {
        block(self[i], i);
    }];
    return self;
}

- (NSArray *)each:(void (^)(id obj))block {
    for(id elem in self) {
        block(elem);
    }
    return self;
}

- (id)head {
    return [self firstObject];
}

- (NSArray *)tail {
    return [self drop:1];
}

- (NSArray *)cons:(id)obj {
    NSMutableArray *returnArray = [[NSMutableArray alloc] initWithCapacity:[self count] + 1];
    returnArray[0] = obj;
    for(NSUInteger i = 0; i < [self count]; i++) {
        returnArray[i + 1] = self[i];
    }
    return returnArray;
}

- (NSArray *)filter:(BOOL(^)(id obj))block {
    NSMutableArray *returnArray = [NSMutableArray new];
    for(id elem in self) {
        if(block(elem)) {
            [returnArray addObject:elem];
        }
    }
    return returnArray;
}

- (NSString *)unwords {
    return [self componentsJoinedByString:@" "];
}

- (NSString *)unlines {
    return [self componentsJoinedByString:@"\n"];
}

- (NSArray *)sortByKey:(NSString *)key {
    NSArray *sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:key ascending:YES]];
    return [self sortedArrayUsingDescriptors:sortDescriptors];
}

- (NSArray *)filterByKey:(NSString *)key {
    return [self filter:^(id object) {
        return [[object objectForKey:key] boolValue];
    }];
}

- (NSArray *)zipWith:(NSArray *)other block:(id(^)(id first, id second))block {
    NSMutableArray *result = [[NSMutableArray alloc] initWithCapacity:[self count]];
    for(int i = 0; i < [self count]; i++) {
        result[i] = block(self[i], other[i]);
    }
    return result;
}


- (NSArray *)groupBy:(BOOL(^)(id first, id second))block {
    NSMutableArray *result = [[NSMutableArray alloc] init];
    int j = 0, i = 0;
    while(i < [self count]) {
        NSMutableArray *group = [[NSMutableArray alloc] init];
        j = 0;
        while(block(self[i],self[i + j])) {
            [group addObject:self[i + j]];
            j++;
            if(i + j >= [self count]) {
                break;
            }
        }
        [result addObject:group];
        i += j;
    }
    return result;
}

- (NSArray *)nub {
    return [self nubBy:^(id a, id b) {
        if(a == b) {
            return YES;
        }
        return NO;
    }];
}
- (NSArray *)nubBy:(BOOL(^)(id first, id second))block {
    NSMutableArray *res = [[NSMutableArray alloc] init];
    NSArray *this = [self reverse];
    for(int i = 0; i < [this count]; i ++) {
        BOOL found = NO;
        for(int j = i + 1; j < [this count]; j++) {
            if(block(this[i], this[j])) {
                found = YES;
                break;
            }
        }
        if(!found) {
            [res addObject:this[i]];
        }
    }
    return [res reverse];
}

@end

