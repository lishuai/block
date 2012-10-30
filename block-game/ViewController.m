//
//  ViewController.m
//  block-game
//
//  Created by li shuai on 12-10-26.
//  Copyright (c) 2012年 li shuai. All rights reserved.
//

#import "ViewController.h"
#import "MainView.h"
#import "NextView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    currBlock = arc4random() % 6;
    nextBlock = arc4random() % 6;
    
    for(int i = 0; i < 10; i ++) {
        for(int j = 0; j < 20; j ++) {
            for(int k = 0; k < 2; k ++) {
                n[i][j][k] = 0;
            }
        }
    }
    
    isPause = NO;
    
    diyici = YES;
    sudu = 500;
    
    mainView = [[MainView alloc] initWithFrame:CGRectMake(10, 10, 400, 800)];
    [self.view addSubview:mainView];
    
    nextView = [[NextView alloc] initWithFrame:CGRectMake(450, 10, 160, 160)];
    [self.view addSubview:nextView];
    
    [nextView paint:currBlock];
}

- (void)newFangKuai:(int)k {
    [nextView paint:nextBlock];
    switch (k) {
        case 0 :
            n[4][0][0] = 2;
            n[4][1][0] = 2;
            n[4][2][0] = 2;
            n[4][3][0] = 2;
            n[4][0][1] = 0;
            n[4][1][1] = 0;
            n[4][2][1] = 0;
            n[4][3][1] = 0;
            break;
        case 1 :
            n[4][0][0] = 2;
            n[5][0][0] = 2;
            n[4][1][0] = 2;
            n[5][1][0] = 2;
            n[4][0][1] = 1;
            n[5][0][1] = 1;
            n[4][1][1] = 1;
            n[5][1][1] = 1;
            break;
        case 2 :
            n[3][0][0] = 2;
            n[4][0][0] = 2;
            n[4][1][0] = 2;
            n[5][1][0] = 2;
            n[3][0][1] = 2;
            n[4][0][1] = 2;
            n[4][1][1] = 2;
            n[5][1][1] = 2;
            break;
        case 3 :
            n[3][1][0] = 2;
            n[4][0][0] = 2;
            n[4][1][0] = 2;
            n[5][0][0] = 2;
            n[3][1][1] = 3;
            n[4][0][1] = 3;
            n[4][1][1] = 3;
            n[5][0][1] = 3;
            break;
        case 4 :
            n[3][0][0] = 2;
            n[3][1][0] = 2;
            n[4][1][0] = 2;
            n[5][1][0] = 2;
            n[3][0][1] = 4;
            n[3][1][1] = 4;
            n[4][1][1] = 4;
            n[5][1][1] = 4;
            break;
        case 5 :
            n[5][0][0] = 2;
            n[3][1][0] = 2;
            n[4][1][0] = 2;
            n[5][1][0] = 2;
            n[5][0][1] = 5;
            n[3][1][1] = 5;
            n[4][1][1] = 5;
            n[5][1][1] = 5;
            break;
        case 6 :
            n[4][0][0] = 2;
            n[3][1][0] = 2;
            n[4][1][0] = 2;
            n[5][1][0] = 2;
            n[4][0][1] = 6;
            n[3][1][1] = 6;
            n[4][1][1] = 6;
            n[5][1][1] = 6;
            break;
    }
    zhuangtai = 0;
}

- (BOOL)xia {
    if ([self isXia]) {
        for (int i = 0; i < 10; i ++ ) {
            for (int j = 19; j > 0; j -- ) {
                if (n[i][j][0] != 1 && n[i][j - 1][0] == 2) {
                    n[i][j][0] = 2;
                    n[i][j - 1][0] = 0;
                    n[i][j][1] = n[i][j - 1][1];
                }
            }
        }
        return NO;
    } else {
        for (int i = 0; i < 10; i ++ ) {
            for (int j = 0; j < 20; j ++ ) {
                if (n[i][j][0] == 2) {
                    n[i][j][0] = 1;
                }
            }
        }
        return YES;
    }
}

- (BOOL) isXia {
    int c = 0;
    for (int i = 0; i < 10; i ++ ) {
        for (int j = 19; j > 0; j -- ) {
            if (n[i][j][0] != 1 && n[i][j - 1][0] == 2) {
                c ++ ;
            }
        }
    }
    return c == 4;
}

- (BOOL) isJian:(int)c {
    for (int i = 0; i < 10; i ++ ) {
        if (n[i][c][0] != 1) {
            return NO;
        }
    }
    return YES;
}

- (int)jianCeng {
    int c = 0;
    for (int j = 0; j < 20; j ++ ) {
        if ([self isJian:j]) {
            for (int i = 0; i < 10; i ++ ) {
                for (int k = j; k > 0; k -- ) {
                    n[i][k][0] = n[i][k - 1][0];
                    n[i][k][1] = n[i][k - 1][1];
                }
            }
            j -- ;
            c ++ ;
        }
    }
    return c;
}

- (IBAction)reStart {
    for (int i = 0; i < 10; i ++ ) {
        for (int j = 0; j < 20; j ++ ) {
            n[i][j][0] = 0;
        }
    }
    zhuangtai = 0;
    fenshu = 0;
}

- (BOOL)isGameOver:(int)k {
    switch (k) {
        case 0 :
            if (n[4][0][0] != 0 || n[4][1][0] != 0 || n[4][2][0] != 0 ||
                n[4][3][0] != 0) {
                return YES;
            }
            break;
        case 1 :
            if (n[4][0][0] != 0 || n[5][0][0] != 0 || n[4][1][0] != 0 ||
                n[5][1][0] != 0) {
                return YES;
            }
            break;
        case 2 :
            if (n[3][0][0] != 0 || n[4][0][0] != 0 || n[4][1][0] != 0 ||
                n[5][1][0] != 0) {
                return YES;
            }
            break;
        case 3 :
            if (n[3][1][0] != 0 || n[4][0][0] != 0 || n[4][1][0] != 0 ||
                n[5][0][0] != 0) {
                return YES;
            }
            break;
        case 4 :
            if (n[3][0][0] != 0 || n[3][1][0] != 0 || n[4][1][0] != 0 ||
                n[5][1][0] != 0) {
                return YES;
            }
            break;
        case 5 :
            if (n[5][0][0] != 0 || n[3][1][0] != 0 || n[4][1][0] != 0 ||
                n[5][1][0] != 0) {
                return YES;
            }
            break;
        case 6 :
            if (n[4][0][0] != 0 || n[3][1][0] != 0 || n[4][1][0] != 0 ||
                n[5][1][0] != 0) {
                return YES;
            }
            break;
    }
    return NO;
}

- (void)yunxing {
    if (!isPause) {
        if ([self xia]) {
            fenshu += [self jianCeng] * 100;
            //更新分数
            sudu = 500;
            currBlock = nextBlock;
            nextBlock = arc4random() % 6;
            if ([self isGameOver:currBlock]) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                                message:@"GAME OVER"
                                                               delegate:nil
                                                      cancelButtonTitle:@"确定"
                                                      otherButtonTitles:nil];
                [alert show];
                [self reStart];
            }
            [self newFangKuai:currBlock];
        }
        
        [mainView paint:n];
    }
    
    [NSTimer scheduledTimerWithTimeInterval:sudu/1000.0 target:self selector:@selector(yunxing) userInfo:nil repeats:NO];
}

- (IBAction) kaishi {
    if(isPause){
        isPause = NO;
    } else {
        if(diyici){
            [self newFangKuai:currBlock];
            [self yunxing];
            diyici = NO;
        }
    }
}

- (IBAction)zuo {
    if (!isPause && [self isZuo]) {
        for (int i = 0; i < 9; i ++ ) {
            for (int j = 0; j < 20; j ++ ) {
                if (n[i][j][0] != 1 && n[i + 1][j][0] == 2) {
                    n[i][j][0] = 2;
                    n[i + 1][j][0] = 0;
                    n[i][j][1] = n[i + 1][j][1];
                }
            }
        }
        [mainView paint:n];
    }
}

- (IBAction)you {
    if (!isPause && [self isYou]) {
        for (int i = 9; i > 0; i -- ) {
            for (int j = 0; j < 20; j ++ ) {
                if (n[i][j][0] != 1 && n[i - 1][j][0] == 2) {
                    n[i][j][0] = 2;
                    n[i - 1][j][0] = 0;
                    n[i][j][1] = n[i - 1][j][1];
                }
            }
        }
        [mainView paint:n];
    }
}

- (BOOL)isZuo {
    int c = 0;
    for (int i = 0; i < 9; i ++ ) {
        for (int j = 0; j < 20; j ++ ) {
            if (n[i][j][0] != 1 && n[i + 1][j][0] == 2) {
                c ++ ;
            }
        }
    }
    return c == 4;
}

- (BOOL)isYou {
    int c = 0;
    for (int i = 9; i > 0; i -- ) {
        for (int j = 0; j < 20; j ++ ) {
            if (n[i][j][0] != 1 && n[i - 1][j][0] == 2) {
                c ++ ;
            }
        }
    }
    return c == 4;
}

- (void)zhaoZuoBiao {
    for (int j = 0; j < 20; j ++ ) {
        for (int i = 0; i < 10; i ++ ) {
            if (n[i][j][0] == 2) {
                x = i;
                y = j;
                return;
            }
        }
    }
}

- (BOOL)isXuanZhuan:(int)k {
    switch (k) {
        case 0 :
            if (zhuangtai == 0) {
                return x < 7 && n[x + 1][y][0] == 0 && n[x + 2][y][0] == 0 && n[x + 3][y][0] == 0;
            } else {
                return y < 17 && n[x][y + 1][0] == 0 && n[x][y + 2][0] == 0 && n[x][y + 3][0] == 0;
            }
        case 1 :
        case 2 :
            if (zhuangtai == 0) {
                return y < 18 && n[x][y + 1][0] == 0 && n[x][y + 2][0] == 0;
            } else {
                return x < 9 && n[x - 1][y][0] == 0 && n[x + 1][y + 1][0] == 0;
            }
        case 3 :
            if (zhuangtai == 0) {
                return y < 18 && n[x + 1][y + 1][0] == 0 && n[x + 1][y + 2][0] == 0;
            } else {
                return x > 0 && n[x - 1][y + 1][0] == 0 && n[x + 1][y][0] == 0;
            }
        case 4 :
            if (zhuangtai == 0) {
                return y < 18 && n[x + 1][y][0] == 0 && n[x][y + 2][0] == 0;
            } else if (zhuangtai == 1) {
                return x < 8 && n[x + 2][y][0] == 0 && n[x + 2][y + 1][0] == 0;
            } else if (zhuangtai == 2) {
                return y < 18 && n[x + 1][y + 1][0] == 0 &&
                n[x + 1][y + 2][0] == 0 && n[x][y + 2][0] == 0;
            } else {
                return x < 9 && n[x - 1][y][0] == 0 && n[x - 1][y + 1][0] == 0 && n[x + 1][y + 1][0] == 0;
            }
        case 5 :
            if (zhuangtai == 0) {
                return y < 18 && n[x - 2][y][0] == 0 && n[x - 2][y + 2][0] == 0 && n[x - 1][y + 2][0] == 0;
            } else if (zhuangtai == 1) {
                return x < 8 && n[x + 1][y][0] == 0 && n[x + 2][y][0] == 0;
            } else if (zhuangtai == 2) {
                return y < 18 && n[x + 1][y + 1][0] == 0 && n[x + 1][y + 2][0] == 0;
            } else {
                return x < 8 && n[x + 2][y][0] == 0 && n[x + 2][y + 1][0] == 0 && n[x][y + 1][0] == 0;
            }
        case 6 :
            if (zhuangtai == 0) {
                return y < 18 && n[x][y + 2][0] == 0;
            } else if (zhuangtai == 1) {
                return x > 0 && n[x - 1][y + 1][0] == 0;
            } else if (zhuangtai == 2) {
                return y < 18 && n[x + 1][y - 1][0] == 0;
            } else {
                return x < 9 && n[x + 1][y + 1][0] == 0;
            }
    }
    return true;
}

- (IBAction)xuanZhuan {
    [self zhaoZuoBiao];
    int k = currBlock;
    if (!isPause && [self isXuanZhuan:k]) {
        switch (k) {
            case 0 :
                if (zhuangtai == 0) {
                    zhuangtai = 1;
                    n[x + 1][y][0] = 2;
                    n[x + 2][y][0] = 2;
                    n[x + 3][y][0] = 2;
                    n[x][y + 1][0] = 0;
                    n[x][y + 2][0] = 0;
                    n[x][y + 3][0] = 0;
                    n[x + 1][y][1] = 0;
                    n[x + 2][y][1] = 0;
                    n[x + 3][y][1] = 0;
                }
                else {
                    zhuangtai = 0;
                    n[x][y + 1][0] = 2;
                    n[x][y + 2][0] = 2;
                    n[x][y + 3][0] = 2;
                    n[x + 1][y][0] = 0;
                    n[x + 2][y][0] = 0;
                    n[x + 3][y][0] = 0;
                    n[x][y + 1][1] = 0;
                    n[x][y + 2][1] = 0;
                    n[x][y + 3][1] = 0;
                }
                break;
            case 1 :
                break;
            case 2 :
                if (zhuangtai == 0) {
                    zhuangtai = 1;
                    n[x][y + 1][0] = 2;
                    n[x][y + 2][0] = 2;
                    n[x][y][0] = 0;
                    n[x + 2][y + 1][0] = 0;
                    n[x][y + 1][1] = 2;
                    n[x][y + 2][1] = 2;
                }
                else {
                    zhuangtai = 0;
                    n[x - 1][y][0] = 2;
                    n[x + 1][y + 1][0] = 2;
                    n[x - 1][y + 1][0] = 0;
                    n[x - 1][y + 2][0] = 0;
                    n[x - 1][y][1] = 2;
                    n[x + 1][y + 1][1] = 2;
                }
                break;
            case 3 :
                if (zhuangtai == 0) {
                    zhuangtai = 1;
                    n[x + 1][y + 1][0] = 2;
                    n[x + 1][y + 2][0] = 2;
                    n[x - 1][y + 1][0] = 0;
                    n[x + 1][y][0] = 0;
                    n[x + 1][y + 1][1] = 3;
                    n[x + 1][y + 2][1] = 3;
                }
                else {
                    zhuangtai = 0;
                    n[x - 1][y + 1][0] = 2;
                    n[x + 1][y][0] = 2;
                    n[x + 1][y + 1][0] = 0;
                    n[x + 1][y + 2][0] = 0;
                    n[x - 1][y + 1][1] = 3;
                    n[x + 1][y][1] = 3;
                }
                break;
            case 4 :
                if (zhuangtai == 0) {
                    zhuangtai = 1;
                    n[x + 1][y][0] = 2;
                    n[x][y + 2][0] = 2;
                    n[x + 1][y + 1][0] = 0;
                    n[x + 2][y + 1][0] = 0;
                    n[x + 1][y][1] = 4;
                    n[x][y + 2][1] = 4;
                }
                else if (zhuangtai == 1) {
                    zhuangtai = 2;
                    n[x + 2][y][0] = 2;
                    n[x + 2][y + 1][0] = 2;
                    n[x][y + 1][0] = 0;
                    n[x][y + 2][0] = 0;
                    n[x + 2][y][1] = 4;
                    n[x + 2][y + 1][1] = 4;
                }
                else if (zhuangtai == 2) {
                    zhuangtai = 3;
                    n[x + 1][y + 1][0] = 2;
                    n[x + 1][y + 2][0] = 2;
                    n[x][y + 2][0] = 2;
                    n[x][y][0] = 0;
                    n[x + 2][y][0] = 0;
                    n[x + 2][y + 1][0] = 0;
                    n[x + 1][y + 1][1] = 4;
                    n[x + 1][y + 2][1] = 4;
                    n[x][y + 2][1] = 4;
                }
                else {
                    zhuangtai = 0;
                    n[x - 1][y][0] = 2;
                    n[x - 1][y + 1][0] = 2;
                    n[x + 1][y + 1][0] = 2;
                    n[x - 1][y + 2][0] = 0;
                    n[x][y + 2][0] = 0;
                    n[x][y][0] = 0;
                    n[x - 1][y][1] = 4;
                    n[x - 1][y + 1][1] = 4;
                    n[x + 1][y + 1][1] = 4;
                }
                break;
            case 5 :
                if (zhuangtai == 0) {
                    zhuangtai = 1;
                    n[x - 2][y][0] = 2;
                    n[x - 2][y + 2][0] = 2;
                    n[x - 1][y + 2][0] = 2;
                    n[x][y][0] = 0;
                    n[x - 1][y + 1][0] = 0;
                    n[x][y + 1][0] = 0;
                    n[x - 2][y][1] = 5;
                    n[x - 2][y + 2][1] = 5;
                    n[x - 1][y + 2][1] = 5;
                }
                else if (zhuangtai == 1) {
                    zhuangtai = 2;
                    n[x + 1][y][0] = 2;
                    n[x + 2][y][0] = 2;
                    n[x][y + 2][0] = 0;
                    n[x + 1][y + 2][0] = 0;
                    n[x + 1][y][1] = 5;
                    n[x + 2][y][1] = 5;
                }
                else if (zhuangtai == 2) {
                    zhuangtai = 3;
                    n[x + 1][y + 1][0] = 2;
                    n[x + 1][y + 2][0] = 2;
                    n[x + 2][y][0] = 0;
                    n[x][y + 1][0] = 0;
                    n[x + 1][y + 1][1] = 5;
                    n[x + 1][y + 2][1] = 5;
                }
                else {
                    zhuangtai = 0;
                    n[x + 2][y][0] = 2;
                    n[x + 2][y + 1][0] = 2;
                    n[x][y + 1][0] = 2;
                    n[x][y][0] = 0;
                    n[x + 1][y][0] = 0;
                    n[x + 1][y + 2][0] = 0;
                    n[x + 2][y][1] = 5;
                    n[x + 2][y + 1][1] = 5;
                    n[x][y + 1][1] = 5;
                }
                break;
            case 6 :
                if (zhuangtai == 0) {
                    zhuangtai = 1;
                    n[x][y + 2][0] = 2;
                    n[x - 1][y + 1][0] = 0;
                    n[x][y + 2][1] = 6;
                }
                else if (zhuangtai == 1) {
                    zhuangtai = 2;
                    n[x - 1][y + 1][0] = 2;
                    n[x][y][0] = 0;
                    n[x - 1][y + 1][1] = 6;
                }
                else if (zhuangtai == 2) {
                    zhuangtai = 3;
                    n[x + 1][y - 1][0] = 2;
                    n[x + 2][y][0] = 0;
                    n[x + 1][y - 1][1] = 6;
                }
                else {
                    zhuangtai = 0;
                    n[x + 1][y + 1][0] = 2;
                    n[x][y + 2][0] = 0;
                    n[x + 1][y + 1][1] = 6;
                }
        }
    }
    [mainView paint:n];
}

- (IBAction)quickDown {
    if (!isPause) {
        sudu = 10;
    }
}

- (IBAction)zanting {
    if (!isPause) {
        isPause = YES;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction) btnConnect:(id) sender
{
    GKPeerPickerController * picker = [[GKPeerPickerController alloc] init];
    picker.delegate = self;
    picker.connectionTypesMask = GKPeerPickerConnectionTypeNearby;
    [picker show];
}

- (void)peerPickerController:(GKPeerPickerController *)picker didConnectPeer:(NSString *)peerID toSession:(GKSession *)session
{
    self.currentSession = session;
    session.delegate = self;
    [session setDataReceiveHandler:self withContext:nil];
    picker.delegate = nil;
    [picker dismiss];
}

- (void) receiveData:(NSData *)data fromPeer: (NSString *)peer inSession:(GKSession *)session context:(void *)context
{
    NSString *s = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
    if ([s isEqualToString:@"left"]) {
        [self zuo];
    } else if ([s isEqualToString:@"right"]) {
        [self you];
    } else if ([s isEqualToString:@"start"]) {
        [self kaishi];
    } else if ([s isEqualToString:@"a"]) {
        [self xuanZhuan];
    } else if ([s isEqualToString:@"b"]) {
        [self quickDown];
    }
}

@end
