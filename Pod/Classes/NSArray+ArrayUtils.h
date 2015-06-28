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
- (NSArray *)flatMap:(NSArray*(^)(id obj))block;
@end
