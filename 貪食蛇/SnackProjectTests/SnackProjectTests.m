//
//  SnackProjectTests.m
//  SnackProjectTests
//
//  Created by w91379137 on 2016/4/30.
//  Copyright © 2016年 w91379137. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "SPMap.h"
#import "SPSnack.h"

@interface SnackProjectTests : XCTestCase
{
    SPMap *gameMap;
}

@end

@implementation SnackProjectTests

#pragma mark - Init
- (void)setUp
{
    [super setUp];
    gameMap = [SPMap new];
    gameMap.width = 3;
    gameMap.height = 3;
}

- (void)tearDown
{
    [super tearDown];
}

#pragma mark - Setter / Getter
- (SPSnack *)newSnake
{
    SPSnack *snake = [SPSnack new];
    snake.gameMap = gameMap;
    snake.maxBodyLength = 6;
    [snake.bodyPointArray addObject:[gameMap randomCoordinatesWithoutArray:nil]];
    return snake;
}

#pragma mark - Tests
- (void)testMove_Up_Down
{
    {
        SPSnack *snake = [self newSnake];
        snake.direction = UISwipeGestureRecognizerDirectionUp;
        [snake move];
        
        XCTAssertTrue(snake.bodyPointArray.count > 1,@"must count > 1.");
        
        SPCoordinates *first = snake.bodyPointArray[0];
        SPCoordinates *second = snake.bodyPointArray[1];
        
        XCTAssertTrue(first.y - second.y == -1 ||
                      first.y - second.y == -1 + gameMap.height,
                      @"must == -1.");
    }
    
    {
        SPSnack *snake = [self newSnake];
        snake.direction = UISwipeGestureRecognizerDirectionDown;
        [snake move];
        
        XCTAssertTrue(snake.bodyPointArray.count > 1,@"must count > 1.");
        
        SPCoordinates *first = snake.bodyPointArray[0];
        SPCoordinates *second = snake.bodyPointArray[1];
        
        XCTAssertTrue(first.y - second.y == 1 ||
                      first.y - second.y == 1 - gameMap.height,
                      @"must == 1.");
    }
}

- (void)testMove_Right_Left
{
    {
        SPSnack *snake = [self newSnake];
        snake.direction = UISwipeGestureRecognizerDirectionRight;
        [snake move];
        
        XCTAssertTrue(snake.bodyPointArray.count > 1,@"must count > 1.");
        
        SPCoordinates *first = snake.bodyPointArray[0];
        SPCoordinates *second = snake.bodyPointArray[1];
        
        XCTAssertTrue(first.x - second.x == 1 ||
                      first.x - second.x == 1 - gameMap.width,
                      @"must == 1.");
    }
    
    {
        SPSnack *snake = [self newSnake];
        snake.direction = UISwipeGestureRecognizerDirectionLeft;
        [snake move];
        
        XCTAssertTrue(snake.bodyPointArray.count > 1,@"must count > 1.");
        
        SPCoordinates *first = snake.bodyPointArray[0];
        SPCoordinates *second = snake.bodyPointArray[1];
        
        XCTAssertTrue(first.x - second.x == -1 ||
                      first.x - second.x == -1 + gameMap.width,
                      @"must == -1.");
    }
}

- (void)testHit
{
    SPSnack *snake = [self newSnake];
    snake.direction = UISwipeGestureRecognizerDirectionUp;
    [snake move];
    
    snake.direction = UISwipeGestureRecognizerDirectionLeft;
    [snake move];
    
    snake.direction = UISwipeGestureRecognizerDirectionDown;
    [snake move];
    
    snake.direction = UISwipeGestureRecognizerDirectionRight;
    [snake move];
    XCTAssertTrue([snake isHeadTouchSelf] == YES , @"must hit the body.");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
