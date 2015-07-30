//
//  Tuple2D.m
//  Pods
//
//  Created by Niil Öhlin on 16/07/15.
//
//

#import "Tuple2D.h"

@implementation Tuple2D

+ (instancetype)tupleWithObjects:(id)first second:(id)second {
    Tuple2D *tuple = [[Tuple2D alloc] init];
    tuple._1 = first;
    tuple._2 = second;
    return tuple;
}

- (id)joinWithBlock:(id(^)(id first, id second))block {
    return block(self._1, self._2);
}

- (NSString *)description {
    return [NSString stringWithFormat:@"(%@, %@)", self._1, self._2];
}
@end
