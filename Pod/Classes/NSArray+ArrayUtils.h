//
//  NSArray+ArrayUtils.h
//  Pods
//
//  Created by Niil Öhlin on 27/06/15.
//
//

#import <Foundation/Foundation.h>

@interface NSArray (ArrayUtils)

- (BOOL)empty;
- (NSArray *)map:(id(^)(id obj))block;
- (NSArray *)reverse;
- (NSArray *)intersperse:(id)obj;
- (NSArray *)flatten;
- (NSArray *)intercalate:(id)obj;
- (NSArray *)transpose;
- (NSNumber *)sum;
- (NSNumber *)product;
- (NSNumber *)maximum;
- (NSNumber *)minimum;
- (id)maximumBy:(NSComparisonResult(^)(id first, id second))comparioson;
- (id)minimumBy:(NSComparisonResult(^)(id first, id second))comparioson;
- (NSArray *)groupBy:(BOOL(^)(id first, id second))block;
- (NSArray *)take:(NSUInteger)elements;
- (NSArray *)drop:(NSUInteger)elements;
- (NSArray *)eachWithIndex:(void (^)(id obj, NSUInteger idx))block;
- (NSArray *)each:(void (^)(id obj))block;
- (id)head;
- (NSArray *)tail;
- (NSArray *)cons:(id)obj;
- (NSArray *)filter:(BOOL(^)(id obj))block;
- (NSArray *)flatMap:(NSArray*(^)(id obj))block;
- (id)foldl:(id)zero block:(id(^)(id acc, id obj))block;
- (id)foldl_:(id(^)(id acc, id obj))block;
- (id)foldr:(id)zero block:(id(^)(id obj, id acc))block;
- (id)foldr_:(id(^)(id obj, id acc))block;
- (BOOL)any:(BOOL(^)(id obj))block;
- (BOOL)all:(BOOL(^)(id obj))block;
@end
