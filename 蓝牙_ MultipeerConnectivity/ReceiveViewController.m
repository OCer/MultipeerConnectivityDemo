//
//  ReceiveViewController.m
//  蓝牙_ MultipeerConnectivity
//
//  Created by 徐杰 on 16/2/23.
//  Copyright © 2016年 Cer. All rights reserved.
//

#import "ReceiveViewController.h"

@interface ReceiveViewController ()

@property(strong, nonatomic) MCSession *session;
@property(strong, nonatomic) MCBrowserViewController *browserController;
@property(strong, nonatomic) UILabel *label;

@end

@implementation ReceiveViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTitle:@"接收"];

    [[self view] setBackgroundColor:[UIColor purpleColor]];
    
    UILabel *label = [[UILabel alloc] init];
    [label setFrame:CGRectMake(100, 100, 200, 30)];
    [label setBackgroundColor:[UIColor whiteColor]];
    [label setTextColor:[UIColor redColor]];
    [label setText:@"111"];
    [label setTextAlignment:NSTextAlignmentCenter];
    [[self view] addSubview:label];
    [self setLabel:label];
    
    MCPeerID *ID = [[MCPeerID alloc] initWithDisplayName:[[UIDevice currentDevice] name]];
    MCSession *session = [[MCSession alloc] initWithPeer:ID securityIdentity:nil encryptionPreference:MCEncryptionOptional];
    [session setDelegate:self];
    [self setSession:session];
    
    MCBrowserViewController *browserController = [[MCBrowserViewController alloc] initWithServiceType:@"ztj-service" session:session];
    [browserController setDelegate:self];
    [self setBrowserController:browserController];
    [self presentViewController:browserController animated:YES completion:NULL];
    
    return;
}

#pragma mark - MCBrowserViewController代理方法
- (void)browserViewControllerDidFinish:(MCBrowserViewController *)browserViewController
{
    NSLog(@"已选择");
    [[self browserController] dismissViewControllerAnimated:YES completion:NULL];
    
    return;
}

- (void)browserViewControllerWasCancelled:(MCBrowserViewController *)browserViewController
{
    NSLog(@"取消浏览.");
    [[self browserController] dismissViewControllerAnimated:YES completion:NULL];
    
    return;
}

#pragma mark - MCSession代理方法
- (void)session:(MCSession *)session peer:(MCPeerID *)peerID didChangeState:(MCSessionState)state
{
    NSLog(@"didChangeState");
    switch (state)
    {
        case MCSessionStateConnected:
            NSLog(@"连接成功.");
            [self.browserController dismissViewControllerAnimated:YES completion:nil];
            break;
            
        case MCSessionStateConnecting:
            NSLog(@"正在连接...");
            break;
            
        case MCSessionStateNotConnected:
            NSLog(@"连接失败");
            break;
            
        default:
            NSLog(@"未知.");
            break;
    }
    
    return;
}

- (void)session:(MCSession *)session didReceiveData:(NSData *)data fromPeer:(MCPeerID *)peerID // 接收数据（异步）
{
    NSLog(@"开始接收数据...");
    NSString *text = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    // 回归主线程更新UI
    dispatch_sync(dispatch_get_main_queue(), ^(){
        // 这里的代码会在主线程执行
        [[self label] setText:text];
    });
    
    return;
}

- (void)session:(MCSession *)session didReceiveStream:(NSInputStream *)stream withName:(NSString *)streamName fromPeer:(MCPeerID *)peerID // 接收流
{
    return;
}

- (void)session:(MCSession *)session didStartReceivingResourceWithName:(NSString *)resourceName fromPeer:(MCPeerID *)peerID withProgress:(NSProgress *)progress
{
    NSLog(@"33");
    
    return;
}

- (void)session:(MCSession *)session didFinishReceivingResourceWithName:(NSString *)resourceName fromPeer:(MCPeerID *)peerID atURL:(NSURL *)localURL withError:(nullable NSError *)error
{
    NSLog(@"44");
    
    return;
}

- (void)session:(MCSession *)session didReceiveCertificate:(nullable NSArray *)certificate fromPeer:(MCPeerID *)peerID certificateHandler:(void (^)(BOOL accept))certificateHandler
{
    NSLog(@"55");
    certificateHandler(YES); // 一定要设为YES，不然链接失败；这步网上没说到
    
    return;
}

@end
