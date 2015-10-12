//
//  FunctionalUtilsTests.m
//  FunctionalUtilsTests
//
//  Created by Niil Öhlin on 06/27/2015.
//  Copyright (c) 2015 Niil Öhlin. All rights reserved.
//

@import XCTest;

#import "NSArray+ArrayUtils.h"
#import "Tuple2D.h"

@interface Tests : XCTestCase

@end

@implementation Tests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testReverse
{
    NSArray *arr = @[@1, @2, @3];
    NSArray *reversed = @[@3, @2, @1];
    
    XCTAssert([[@[] reverse] empty]);
    XCTAssert([[arr reverse] count] == [arr count]);
    for(NSUInteger i = 0; i < [arr count]; i++) {
        XCTAssert([arr reverse][i] == reversed[i]);
    }
    
}

- (void)testMap
{
    
    NSArray *arr = @[@1, @2, @3];
    NSArray *expected = @[@2, @3, @4];
    NSArray *result = [arr map:^(id i) {
        NSNumber *n = (NSNumber*) i;
        return @([n longValue] + 1);
    }];
    
    for(NSUInteger i = 0; i < [arr count]; i++) {
        XCTAssert([result[i] isEqualToNumber:expected[i]]);
    }
}

- (void)testSum
{
    NSArray *arr = @[@1, @2, @3, @4];
    XCTAssert([[arr sum] isEqualToNumber:@10]);
    
    NSArray *empty = @[];
    XCTAssert([[empty sum] isEqualToNumber:@0]);
}

- (void)testTranspose
{
    NSArray *matrix   = @[@[@1, @2], @[@3, @4], @[@5, @6]];
    NSArray *transposed = [matrix transpose];
    NSArray *expected = @[@[@1, @3, @5], @[@2, @4, @6]];
    for(int i = 0; i < [transposed count]; i++) {
        for(int j = 0; j < [[transposed firstObject] count]; j++) {
            XCTAssert([transposed[i][j] isEqualToNumber:expected[i][j]]);
        }
    }
}

- (void)testFlatten {
    NSArray *array = @[@[@1, @2], @[@3, @4]];
    XCTAssert(arrayOfNumbersEqual([array flatten], @[@1, @2, @3, @4]));
}

- (void)testFlatmap
{
    NSArray *array = @[@1, @2];
    NSArray *descr = @[@3, @4];
    NSArray *result = [array flatMap:^(NSNumber *num1){
        return [descr flatMap:^(NSNumber *num2) {
            return @[num1, num2];
        }];
    }];
    XCTAssert(arrayOfNumbersEqual(result, @[@1, @3, @1, @4, @2, @3, @2, @4]));
}

- (void)testStep
{
    
}

- (void)testMaximumBy
{
    NSArray *array = @[@"a", @"aa", @"kalas"];
    XCTAssert([[array maximumBy:^(NSString *first, NSString *second) {
        return [@(first.length) compare:@(second.length)];
    }] isEqualToString:@"kalas"]);
}


- (void)testMinimumBy
{
    NSArray *array = @[@"a", @"aa", @"kalas"];
    XCTAssert([[array minimumBy:^(NSString *first, NSString *second) {
        return [@(first.length) compare:@(second.length)];
    }] isEqualToString:@"a"]);
}


- (void)testGroupBy
{
    
    NSArray *array = @[@"apa", @"der", @"foo", @"derp", @"bepa"];
    NSArray *result = [array groupBy:^(id first, id second) {
        if([first length] == [second length])
            return YES;
        return NO;
    }];
    
    XCTAssert([result[0][0] isEqualToString:@"apa"]);
    XCTAssert([result[0][1] isEqualToString:@"der"]);
    XCTAssert([result[0][2] isEqualToString:@"foo"]);
    
    XCTAssert([result[1][0] isEqualToString:@"derp"]);
    XCTAssert([result[1][1] isEqualToString:@"bepa"]);
}

- (void)testJoinTuple
{
    Tuple2D *t = [Tuple2D tupleWithObjects:@1 second:@2];
    NSNumber *r = [t joinWithBlock:^(NSNumber *n1, NSNumber *n2) {
        return @([n1 intValue] + [n2 intValue]);
    }];
    XCTAssert([r isEqualToNumber:@3]);
}

- (void)testAny
{
    
    NSArray *arr = @[@1, @2, @3, @4];
    BOOL isfour = [arr any:^(NSNumber *num){
        return [num isEqualToNumber:@4];
    }];
    XCTAssert(isfour);
    BOOL isfive = [arr any:^(NSNumber *num){
        return [num isEqualToNumber:@5];
    }];
    XCTAssert(!isfive);
}


- (void)testNub
{
    NSArray *arr = @[@1, @2, @3, @3, @1, @1];
    NSArray *expected = @[@1, @2, @3];
    NSArray *output = [arr nubBy:^(id a, id b) {
        if([a intValue] == [b intValue]) {
            return YES;
        }
        return NO;
    }];
    XCTAssert(arrayOfNumbersEqual(output, expected));
    
    NSNumber *one = @1;
    NSNumber *two = @2;
    NSNumber *three = @3;
    
    arr = @[one, two, three, three, one, one];
    
    output = [arr nub];
    XCTAssert(arrayOfNumbersEqual(output, expected));
    
}


- (void)testZipWith
{
    NSArray *arr1 = @[@1, @2, @1];
    NSArray *arr2 = @[@5, @4, @0];
    NSArray *expected = @[@6, @6, @1];
    
    NSArray *result = [arr1 zipWith:arr2 block:^(NSNumber *n1, NSNumber *n2) {
        return @([n1 intValue] + [n2 intValue]);
    }];
    XCTAssert(arrayOfNumbersEqual(result, expected));
    
}

BOOL arrayOfNumbersEqual(NSArray *arr1, NSArray *arr2) {
    for(int i = 0; i < [arr1 count]; i++) {
        if(![arr1[i] isEqualToNumber:arr2[i]]) {
            return NO;
        }
    }
    return [arr1 count] == [arr2 count];
}



@end
