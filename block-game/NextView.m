//
//  NextView.m
//  block-game
//
//  Created by li shuai on 12-10-29.
//  Copyright (c) 2012年 li shuai. All rights reserved.
//

#import "NextView.h"

@implementation NextView

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

- (void)paint:(int)nextBlock {
    block = nextBlock;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef c = UIGraphicsGetCurrentContext();
    
    CGContextSetRGBFillColor(c, 1.0, 1.0, 1.0, 1.0);
    CGContextFillRect(c, CGRectMake(0, 0, 160, 160));
    
    CGContextSetRGBStrokeColor(c, 0.5, 0.5, 0.5, 1.0);
    
    for (int i = 0; i <= 160; i += 40) {
        CGContextMoveToPoint(c, i, 0);
        CGContextAddLineToPoint(c, i, 160);
        
        CGContextMoveToPoint(c, 0, i);
        CGContextAddLineToPoint(c, 160, i);
    }
    
    CGContextStrokePath(c);
    CGContextFillPath(c);
    
    CGColorRef colorRef = ((UIColor *)[color objectAtIndex:block]).CGColor;
    CGContextSetFillColorWithColor(c, colorRef);
    
    int t[4];
    
    if (block == 0) {
        t[0] = 1;
        t[1] = 5;
        t[2] = 9;
        t[3] = 13;
    } else if (block == 1) {
        t[0] = 5;
        t[1] = 6;
        t[2] = 9;
        t[3] = 10;
    } else if (block == 2) {
        t[0] = 4;
        t[1] = 5;
        t[2] = 9;
        t[3] = 10;
    } else if (block == 3) {
        t[0] = 5;
        t[1] = 6;
        t[2] = 8;
        t[3] = 9;
    } else if (block == 4) {
        t[0] = 4;
        t[1] = 8;
        t[2] = 9;
        t[3] = 10;
    } else if (block == 5) {
        t[0] = 6;
        t[1] = 8;
        t[2] = 9;
        t[3] = 10;
    } else if (block == 6) {
        t[0] = 5;
        t[1] = 8;
        t[2] = 9;
        t[3] = 10;
    }
    
    CGContextFillRect(c, CGRectMake(t[0] % 4 * 40 + 1, t[0] / 4 * 40 + 1, 38, 38));
    CGContextFillRect(c, CGRectMake(t[1] % 4 * 40 + 1, t[1] / 4 * 40 + 1, 38, 38));
    CGContextFillRect(c, CGRectMake(t[2] % 4 * 40 + 1, t[2] / 4 * 40 + 1, 38, 38));
    CGContextFillRect(c, CGRectMake(t[3] % 4 * 40 + 1, t[3] / 4 * 40 + 1, 38, 38));
    
    CGContextFillPath(c);
}


@end
