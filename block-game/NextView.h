//
//  NextView.h
//  block-game
//
//  Created by li shuai on 12-10-29.
//  Copyright (c) 2012年 li shuai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NextView : UIView
{
    int block;
    NSArray * color;
}

- (void)paint:(int)nextBlock;

@end
