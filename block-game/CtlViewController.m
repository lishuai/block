//
//  CtlViewController.m
//  block-game
//
//  Created by li shuai on 12-10-30.
//  Copyright (c) 2012年 li shuai. All rights reserved.
//

#import "CtlViewController.h"

@interface CtlViewController ()

@end

@implementation CtlViewController

@synthesize currentSession;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown ||
            interfaceOrientation != UIInterfaceOrientationPortrait);
}

- (void)mySendDataToPeers:(NSString *)data
{
    if (self.currentSession) {
        NSData *d = [data dataUsingEncoding:NSASCIIStringEncoding];
        [self.currentSession sendDataToAllPeers:d withDataMode:GKSendDataReliable error:nil];
    }
}

- (IBAction)left:(UIButton *)sender
{
    [self mySendDataToPeers:sender.titleLabel.text];
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

-(void)session:(GKSession *)session didFailWithError:(NSError *)error
{
    NSLog(@"error %@", error);
}

@end
