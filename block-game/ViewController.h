//
//  ViewController.h
//  block-game
//
//  Created by li shuai on 12-10-26.
//  Copyright (c) 2012年 li shuai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GameKit/GameKit.h>

@class MainView, NextView;

@interface ViewController : UIViewController <GKPeerPickerControllerDelegate, GKSessionDelegate>
{
    int x;
    int y;
    
    BOOL diyici;
    int zhuangtai;
    int sudu;
    
    BOOL isPause;
    int fenshu;
    
    int currBlock;
    int nextBlock;
    
    int n[10][20][2];
    
    MainView *mainView;
    NextView *nextView;
}

@property(nonatomic, retain) GKSession * currentSession;

@end
