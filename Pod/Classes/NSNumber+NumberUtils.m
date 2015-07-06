//
//  NSNumber+NumberUtils.m
//  Pods
//
//  Created by Niil Öhlin on 28/06/15.
//
//

#import "NSNumber+NumberUtils.h"

@implementation NSNumber (NumberUtils)

- (NSNumber *)add:(NSNumber *)other {
    return @([self doubleValue] + [other doubleValue]);
}

- (NSNumber *)multiply:(NSNumber *)other {
    return @([self doubleValue] * [other doubleValue]);
}

- (NSNumber *)min:(NSNumber *)other {
    return [self doubleValue] < [other doubleValue] ? self : other;
}

- (NSNumber *)max:(NSNumber *)other {
    return [self doubleValue] > [other doubleValue] ? self : other;
}

- (NSNumber *)times:(void(^)(NSUInteger i))block {
    for(NSUInteger i = 0; i < [self doubleValue]; i++) {
        block(i);
    }
    return self;
}

- (NSNumber *)upto:(NSNumber *)upper doBlock:(void(^)(NSUInteger i))block {
    for(NSUInteger i = [self intValue]; i < [upper doubleValue]; i++) {
        block(i);
    }
    return self;
}

- (NSNumber *)downto:(NSNumber *)lower doBlock:(void(^)(NSUInteger i))block {
    for(NSUInteger i = [self intValue]; i >= [lower doubleValue]; i--) {
        block(i);
    }
    return self;
}

- (NSNumber *)step:(NSNumber *)to step:(NSNumber *)step doBlock:(void(^)(NSUInteger i))block {
    for(NSUInteger i = [self intValue]; between(i, [self doubleValue], [to doubleValue]); i += [step doubleValue]) {
        block(i);
    }
    return self;
}

BOOL between(double x, double a, double b) {
    return (a <= x && x < b) || (b <= x && x < a);
}
        

@end
