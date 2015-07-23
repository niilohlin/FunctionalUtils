//
//  Tuple2D.m
//  Pods
//
//  Created by Niil Öhlin on 16/07/15.
//
//

#import "Tuple2D.h"

@implementation Tuple2D

- (instancetype)initWithObjects:(id)first second:(id)second {
    self._1 = first;
    self._2 = second;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"(%@, %@)", self._1, self._2];
}
@end
