//
//  NSNumber+Num.m
//  Pods
//
//  Created by Niil Öhlin on 28/06/15.
//
//

#import "NSNumber+Num.h"

@implementation NSNumber (Num)

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


@end
