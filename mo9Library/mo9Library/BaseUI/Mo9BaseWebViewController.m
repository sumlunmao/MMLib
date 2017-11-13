//
//  Mo9BaseWebViewController.m
//  Mo9Mokredit
//
//  Created by ChenJian on 1/17/15.
//  Copyright (c) 2015 Mo9. All rights reserved.
//

#import "Mo9BaseWebViewController.h"
#import "UIBarButtonItemAdditions.h"


@interface Mo9BaseWebViewController ()<UIWebViewDelegate>
{
    BOOL hasAdded;
}
@end

@implementation Mo9BaseWebViewController

+ (void)initialize {
#pragma mark ---修改webview的user-agent--
    //写到这里 解决第一次进入webview还是默认的userAgent问题
    UIWebView * webview = [[UIWebView alloc] initWithFrame:CGRectZero];
    //获取webview原始的user-agent
    NSString * oldAgent = [webview stringByEvaluatingJavaScriptFromString:@"navigator.userAgent"];

    NSString * appName = [[Infrastructure getConfigManager] appName];
    NSString * appVersion = [[Infrastructure getConfigManager] appVersion];
    NSString * tempAgent = [NSString stringWithFormat:@" mo9(%@/%@)",appName,appVersion];
    NSRange range = [oldAgent rangeOfString:tempAgent options:NSBackwardsSearch];
    if (range.location == NSNotFound) {//没有找到
        NSString * newAgent = [oldAgent stringByAppendingString:tempAgent];
        //regist the new agent
        NSDictionary *dictionnary = [[NSDictionary alloc] initWithObjectsAndKeys:newAgent, @"UserAgent", nil];
        [[NSUserDefaults standardUserDefaults] registerDefaults:dictionnary];
    }
}
- (void)initData {
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.webView = [[UIWebView alloc] initWithFrame:CGRectZero];
    self.webView.delegate = self;
    self.webView.scalesPageToFit = YES;
    [self.view addSubview:self.webView];
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    hasAdded = NO;
    self.needWebBack = NO;
}

- (void)loadUrl:(NSURL *)url {
    self.baseUrl = url;
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    [self.webView loadRequest:request];
}

- (void)backAction {
    if (self.needWebBack) {
        if (self.webView.canGoBack) {
            if (self.needBackHome == YES) {
                self.needBackHome = NO;
                [self.webView loadRequest:[NSURLRequest requestWithURL:self.baseUrl]];
            }else {
                if ([[[self.webView request]URL] isEqual:self.baseUrl]) {
                    [super backAction];
                }else{
                    [self.webView goBack];
                }
            }
            
            if (!hasAdded) {
                hasAdded = YES;
                self.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"ico_home"] target:self selector:@selector(goBack)];
            }
        }else {
            [super backAction];
        }
    }else {
        [super backAction];
    }
}

- (void)goBack {
    [super backAction];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    Log(@"weburl:%@",request.URL);
    [Mo9WebLoadingView startLoadingWithView:self.view animate:true];
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [Mo9WebLoadingView finishLoadingWithView:self.view animate:true];
    self.navigationItem.title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    NSString *backhome = [webView stringByEvaluatingJavaScriptFromString:@"document.getElementById('cashhome').innerHTML"];
    if (backhome.length>0) {
        self.needBackHome = YES;
    }else
        self.needBackHome = NO;
    
    [self baseWebViewDidFinishLoad:webView];
    
}

- (void)baseWebViewDidFinishLoad:(UIWebView *)webView {
    
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [Mo9WebLoadingView finishLoadingWithView:self.view animate:true];
    if (error.code == NSURLErrorNotConnectedToInternet || error.code == NSURLErrorNetworkConnectionLost) {//没有网络
        [SVProgressHUD showErrorWithStatus:error.localizedDescription];
    }else{
        [SVProgressHUD showErrorWithStatus:Error_Mo9_LoadFailed];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
