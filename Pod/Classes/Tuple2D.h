//
//  Tuple2D.h
//  Pods
//
//  Created by Niil Öhlin on 16/07/15.
//
//

#import <Foundation/Foundation.h>

@interface Tuple2D : NSObject
@property id _1;
@property id _2;

+ (instancetype)tupleWithObjects:(id)first second:(id)second;
- (id)joinWithBlock:(id(^)(id first, id second))block;
@end
