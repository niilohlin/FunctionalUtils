//
//  NSNumber+Num.h
//  Pods
//
//  Created by Niil Öhlin on 28/06/15.
//
//

#import <Foundation/Foundation.h>

@interface NSNumber (Num)

- (NSNumber *)add:(NSNumber *)other;
- (NSNumber *)multiply:(NSNumber *)other;
- (NSNumber *)min:(NSNumber *)other;
- (NSNumber *)max:(NSNumber *)other;

@end
