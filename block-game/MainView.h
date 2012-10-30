//
//  MainView.h
//  block-game
//
//  Created by li shuai on 12-10-26.
//  Copyright (c) 2012年 li shuai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainView : UIView
{
    int n[10][20][2];
    NSArray * color;
}

- (void)paint:(int [10][20][2])array;

@end
