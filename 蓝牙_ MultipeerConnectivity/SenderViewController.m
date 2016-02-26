//
//  SenderViewController.m
//  蓝牙_ MultipeerConnectivity
//
//  Created by 徐杰 on 16/2/23.
//  Copyright © 2016年 Cer. All rights reserved.
//

/*
 MCAdvertiserAssistant   // 可以接收，并处理用户请求连接的响应。没有回调，会弹出默认的提示框，并处理连接。(功能与MCNearbyServiceAdvertiser类似，只是额外提供了接受邀请时的标准交互接口。)
 MCNearbyServiceAdvertiser //可以接收，并处理用户请求连接的响应。但是，这个类会有回调，告知有用户要与您的设备连接，然后可以自定义提示框，以及自定义连接处理。
 MCNearbyServiceBrowser  //用于搜索附近的用户，并可以对搜索到的用户发出邀请加入某个会话中。
 MCBrowserViewController // 提供标准的接口，让用户能够选择附近的设备加入一个session。
 MCPeerID //这表明是一个用户
 MCSession //启用和管理Multipeer连接会话中的所有人之间的沟通。 通过Sesion，给别人发送数据。
 */

#import "SenderViewController.h"

@interface SenderViewController ()

@property(nonatomic, strong) MCSession *session;
@property(nonatomic, strong) MCAdvertiserAssistant *ad;
@property(nonatomic, strong) UITextField *textField;

@end

@implementation SenderViewController

- (void)dealloc
{
    [[self ad] stop];
    
    return;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTitle:@"发送"];
    [[self view] setBackgroundColor:[UIColor blueColor]];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStyleDone target:self action:@selector(sender)];
    [[self navigationItem] setRightBarButtonItem:item animated:YES];
    
    UITextField *text = [[UITextField alloc] init];
    [text setFrame:CGRectMake(100, 100, 200, 30)];
    [text setBackgroundColor:[UIColor whiteColor]];
    [[self view] addSubview:text];
    [self setTextField:text];
    
    MCPeerID *ID = [[MCPeerID alloc] initWithDisplayName:[[UIDevice currentDevice] name]]; // 唯一的标识设备，并且给它一个名称
    MCSession *session = [[MCSession alloc] initWithPeer:ID securityIdentity:nil encryptionPreference:MCEncryptionOptional]; // 节点，通讯的基础
    /*
     MCEncryptionOptional = 0,    会话更喜欢使用加密,但会接受未加密的连接
     MCEncryptionRequired = 1,    会话需要加密。
     MCEncryptionNone = 2,        会话不应该加密。
     */
    [session setDelegate:self];
    [self setSession:session];
    
    MCAdvertiserAssistant *ad = [[MCAdvertiserAssistant alloc] initWithServiceType:@"ztj-service" discoveryInfo:nil session:session]; // 广播
    [ad setDelegate:self];
    [self setAd:ad];
    [ad start];

    return;
}

- (void)sender
{
    NSLog(@"发送");
    NSError *error = nil;
    NSString *text = [[self textField] text];
    [[self session] sendData:[text dataUsingEncoding:NSUTF8StringEncoding] toPeers:[[self session] connectedPeers] withMode:MCSessionSendDataReliable error:&error];
    /*
      MCSessionSendDataReliable,      安全的
      MCSessionSendDataUnreliable     不安全的
     
     都是UDP发送
     */
    
    if (error != nil)
    {
        NSLog(@"发送出错 = %@", error);
    }
    
    return;
}

#pragma mark - MCSession代理方法
-(void)session:(MCSession *)session peer:(MCPeerID *)peerID didChangeState:(MCSessionState)state // 节点改变状态的时候被调用
{
    NSLog(@"didChangeState");
    switch (state)
    {
        case MCSessionStateConnected:
            NSLog(@"连接成功.");
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

-(void)session:(MCSession *)session didReceiveData:(NSData *)data fromPeer:(MCPeerID *)peerID // 有新数据从节点过来时被调用（接收数据）
{
    NSLog(@"开始接收数据...");
    
    return;
}

- (void)session:(MCSession *)session didReceiveStream:(NSInputStream *)stream withName:(NSString *)streamName fromPeer:(MCPeerID *)peerID // 接收流
{
    NSLog(@"开始接收流...");
    
    return;
}

- (void)session:(MCSession *)session didStartReceivingResourceWithName:(NSString *)resourceName fromPeer:(MCPeerID *)peerID withProgress:(NSProgress *)progress
{
    NSLog(@"3");
    
    return;
}

- (void)session:(MCSession *)session didFinishReceivingResourceWithName:(NSString *)resourceName fromPeer:(MCPeerID *)peerID atURL:(NSURL *)localURL withError:(nullable NSError *)error
{
    NSLog(@"4");
    
    return;
}

- (void)session:(MCSession *)session didReceiveCertificate:(nullable NSArray *)certificate fromPeer:(MCPeerID *)peerID certificateHandler:(void (^)(BOOL accept))certificateHandler
{
    NSLog(@"5");
    certificateHandler(YES); // 一定要设为YES，不然链接失败；这步网上没说到
    
    return;
}

#pragma mark - MCAdvertiserAssistant代理方法
- (void)advertiserAssistantWillPresentInvitation:(MCAdvertiserAssistant *)advertiserAssistant
{
    NSLog(@"1");
    
    return;
}

- (void)advertiserAssistantDidDismissInvitation:(MCAdvertiserAssistant *)advertiserAssistant
{
    NSLog(@"2");
    
    return;
}

@end
