//
//  Mo9BaseWebViewController.h
//  Mo9Mokredit
//
//  Created by ChenJian on 1/17/15.
//  Copyright (c) 2015 Mo9. All rights reserved.
//

#import "BaseViewController.h"
#import "Mo9WebLoadingView.h"

@interface Mo9BaseWebViewController : BaseViewController
@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, assign, getter=isNeedWebBack) BOOL needWebBack;
@property (nonatomic, assign) BOOL needBackHome;

@property (nonatomic, strong) NSURL *baseUrl;

- (void)loadUrl:(NSURL *)url;

- (void)baseWebViewDidFinishLoad:(UIWebView *)webView; //代替 WebViewDidFinishLoad:(UIWebView *)webView

@end
