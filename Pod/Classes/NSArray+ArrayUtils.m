//
//  NSArray+ArrayUtils.m
//  Pods
//
//  Created by Niil Öhlin on 27/06/15.
//
//

#import "NSArray+ArrayUtils.h"

@implementation NSArray (ArrayUtils)


- (BOOL)empty {
    return [self count] == 0;
}

- (NSArray *)map:(id(^)(id obj))block {
    NSMutableArray *returnArray = [NSMutableArray new];
    for(id element in self) {
        [returnArray addObject:block(element)];
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
    NSMutableArray *returnArray = [NSMutableArray new];
    for(id subArray in self) {
        [returnArray arrayByAddingObjectsFromArray:subArray];
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
    
    for(NSUInteger i = 0; i < rowLength; i++) {
        [returnArray addObject:[[NSMutableArray alloc] initWithCapacity:rowLength]];
    }
    
    for(NSUInteger i = 0; i < rowLength; i++) {
        for(NSUInteger j = 0; j < colLength; j++) {
            returnArray[i][j] = self[j][i];
        }
    }
    return returnArray;
}

- (NSArray *)subsequences {
    return nil;
}

- (NSArray *)foldl:(id(^)(id obj, id acc))block {
    return nil;
}
- (NSArray *)foldl_:(id(^)(id obj, id acc))block {
    return nil;
}
- (NSArray *)foldr:(id(^)(id obj, id acc))block {
    return nil;
}
- (NSArray *)foldr_:(id(^)(id obj, id acc))block {
    return nil;
}

- (NSArray *)flatMap:(NSArray*(^)(id obj))block {
    return nil;
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

@end
