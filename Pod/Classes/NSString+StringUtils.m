//
//  NSString+StringUtils.m
//  Pods
//
//  Created by Niil Öhlin on 29/06/15.
//
//

#import "NSString+StringUtils.h"

@implementation NSString (StringUtils)

- (NSArray *)words {
    return [self componentsSeparatedByString:@" "];
}

- (NSArray *)lines {
    return [self componentsSeparatedByString:@"\n"];
}

@end
