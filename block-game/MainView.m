//
//  MainView.m
//  block-game
//
//  Created by li shuai on 12-10-26.
//  Copyright (c) 2012年 li shuai. All rights reserved.
//

#import "MainView.h"

@implementation MainView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        color = @[
        [UIColor redColor],
        [UIColor greenColor],
        [UIColor blueColor],
        [UIColor yellowColor],
        [UIColor brownColor],
        [UIColor darkGrayColor],
        [UIColor cyanColor]
        ];
    }
    return self;
}

- (void)paint:(int [10][20][2])array {
    for (int i = 0; i < 10; i ++ ) {
        for (int j = 0; j < 20; j ++ ) {
            for (int k = 0; k < 2; k ++) {
                n[i][j][k] = array[i][j][k];
            }
        }
    }
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef c = UIGraphicsGetCurrentContext();
    
    CGContextSetRGBFillColor(c, 1.0, 1.0, 1.0, 1.0);
    CGContextFillRect(c, CGRectMake(0, 0, 400, 800));
    
    CGContextSetRGBStrokeColor(c, 0.5, 0.5, 0.5, 1.0);
    
    for (int x = 0; x <= 400; x += 40) {
        CGContextMoveToPoint(c, x, 0);
        CGContextAddLineToPoint(c, x, 800);
    }
    
    for (int y = 0; y <= 800; y += 40) {
        CGContextMoveToPoint(c, 0, y);
        CGContextAddLineToPoint(c, 400, y);
    }
    
    CGContextStrokePath(c);
    CGContextFillPath(c);
    
    for (int i = 0; i < 10; i ++ ) {
        for (int j = 0; j < 20; j ++ ) {
            if (n[i][j][0] != 0) {
//                CGContextSetRGBFillColor(c, 1.0, 0.0, 0.0, 1.0);
                CGColorRef colorRef = ((UIColor *)[color objectAtIndex:n[i][j][1]]).CGColor;
                CGContextSetFillColorWithColor(c, colorRef);
                CGContextFillRect(c, CGRectMake(i * 40 + 1, j * 40 + 1, 38, 38));
            }
        }
    }
    
    CGContextFillPath(c);
}

@end
