//
//  CtlViewController.h
//  block-game
//
//  Created by li shuai on 12-10-30.
//  Copyright (c) 2012年 li shuai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GameKit/GameKit.h>

@interface CtlViewController : UIViewController <GKPeerPickerControllerDelegate, GKSessionDelegate>

@property(nonatomic, strong) GKSession * currentSession;

@end
