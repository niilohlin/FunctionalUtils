//
//  NSNumber+NumberUtils.h
//  Pods
//
//  Created by Niil Öhlin on 28/06/15.
//
//

#import <Foundation/Foundation.h>

@interface NSNumber (NumberUtils)

- (NSNumber *)add:(NSNumber *)other;
- (NSNumber *)multiply:(NSNumber *)other;
- (NSNumber *)min:(NSNumber *)other;
- (NSNumber *)max:(NSNumber *)other;
- (NSNumber *)times:(void(^)(NSUInteger i))block;
- (NSNumber *)downto:(NSNumber *)lower doBlock:(void(^)(NSUInteger i))block;
- (NSNumber *)upto:(NSNumber *)upper doBlock:(void(^)(NSUInteger i))block;
- (NSNumber *)step:(NSNumber *)to step:(NSNumber *)step doBlock:(void(^)(NSUInteger i))block;

@end
