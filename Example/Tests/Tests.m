//
//  FunctionalUtilsTests.m
//  FunctionalUtilsTests
//
//  Created by Niil Öhlin on 06/27/2015.
//  Copyright (c) 2015 Niil Öhlin. All rights reserved.
//

@import XCTest;

#import "NSArray+ArrayUtils.h"

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

BOOL arrayOfNumbersEqual(NSArray *arr1, NSArray *arr2) {
    for(int i = 0; i < [arr1 count]; i++) {
        if(![arr1[i] isEqualToNumber:arr2[i]]) {
            return NO;
        }
    }
    return [arr1 count] == [arr2 count];
}



@end
