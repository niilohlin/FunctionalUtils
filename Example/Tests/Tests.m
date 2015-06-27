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

@end
