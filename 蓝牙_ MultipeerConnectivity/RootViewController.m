//
//  RootViewController.m
//  蓝牙_ MultipeerConnectivity
//
//  Created by 徐杰 on 16/2/23.
//  Copyright © 2016年 Cer. All rights reserved.
//

#import "RootViewController.h"
#import "SenderViewController.h"
#import "ReceiveViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTitle:@"WIFI/蓝牙"];
    
    UIBarButtonItem *sender = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStyleDone target:self action:@selector(sender:)];
    [[self navigationItem] setRightBarButtonItem:sender animated:YES];
    UIBarButtonItem *receive = [[UIBarButtonItem alloc] initWithTitle:@"接受" style:UIBarButtonItemStyleDone target:self action:@selector(receive:)];
    [[self navigationItem] setLeftBarButtonItem:receive animated:YES];

    return;
}

- (void)sender:(id)temp
{
    SenderViewController *sender = [[SenderViewController alloc] init];
    [[self navigationController] pushViewController:sender animated:YES];
    
    return;
}

- (void)receive:(id)temp
{
    ReceiveViewController *receive = [[ReceiveViewController alloc] init];
    [[self navigationController] pushViewController:receive animated:YES];
    
    return;
}

@end
