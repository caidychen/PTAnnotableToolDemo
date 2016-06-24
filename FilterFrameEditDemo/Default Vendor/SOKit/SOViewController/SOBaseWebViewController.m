//
//  SOBaseWebViewController.m
//  SOKit
//
//  Created by soso on 15/6/4.
//  Copyright (c) 2015年 com.. All rights reserved.
//

#import "SOBaseWebViewController.h"
#import "SOGlobal.h"

@interface SOBaseWebViewController () <UIWebViewDelegate>
@property (strong, nonatomic) UIWebView *webView;
@property (strong, nonatomic) UIActivityIndicatorView *activityView;
@end

@implementation SOBaseWebViewController
@synthesize webView = _webView;
@synthesize activityView = _activityView;

- (void)dealloc {
    [_webView cleanMemory];
    SORELEASE(_webView);
    SORELEASE(_activityView);
    SORELEASE(_url);
    SOSUPERDEALLOC();
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(self) {
        _autoShowWebTitle = YES;
        _timeoutInterval = 15.0f;
    }
    return (self);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.webView];
    [self.view addSubview:self.activityView];
    
    [self.view bringSubviewToFront:self.activityView];
    
    [self webViewLoadURL:self.url];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.webView.frame = self.view.bounds;
    self.activityView.center = self.view.center;
}

#pragma mark - setter
- (void)setUrl:(NSURL *)url {
    NSURL *cpURL = [url copy];
    SORELEASE(_url);
    _url = cpURL;
    if(_webView) {
        [self webViewLoadURL:_url];
    }
}
#pragma mark -

#pragma mark - getter
- (UIWebView *)webView {
    if(!_webView) {
        _webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
        _webView.backgroundColor = _webView.scrollView.backgroundColor = [UIColor whiteColor];
        _webView.scalesPageToFit = YES;
        _webView.delegate = self;
        _webView.scrollView.scrollEnabled = NO;
    }
    return (_webView);
}

- (UIActivityIndicatorView *)activityView {
    if(!_activityView) {
        _activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        _activityView.hidesWhenStopped = YES;
        _activityView.center = self.view.center;
    }
    return (_activityView);
}
#pragma mark -

#pragma mark - actions
- (void)webViewLoadURL:(NSURL *)url {
    if(!url) {
        return;
    }
    [self.webView loadRequest:[NSURLRequest requestWithURL:self.url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:self.timeoutInterval]];
}
#pragma mark -

#pragma mark - UIWebViewDelegate
- (void)webViewDidStartLoad:(UIWebView *)webView {
    [self.activityView startAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self.activityView stopAnimating];
    self.webView.scrollView.scrollEnabled = YES;
    if(self.autoShowWebTitle) {
        NSString *docTitle = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
        if(docTitle && [docTitle length] > 0) {
            self.title = docTitle;
        }
    }
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [self.activityView stopAnimating];
}
#pragma mark -

@end
