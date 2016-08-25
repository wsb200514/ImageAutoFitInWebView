//
//  ViewController.m
//  LoadImgSizeWithWebView
//
//  Created by 魏素宝 on 16/3/8.
//  Copyright © 2016年 SUBAOWEI. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIWebViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//  设置webView
    UIWebView *webView=[[UIWebView alloc]initWithFrame:self.view.bounds];
  
//  1、本地html资源测试
//  NSString *path=[[NSBundle mainBundle]pathForResource:@"test" ofType:@"html"];
//  [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:path]]];
    
//  2、URL网址资源测试
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://gb.wallpapersking.com/top/class108/15041/14eec4d8b4bf1fe0.htm"]]];
    
    [self.view addSubview:webView];
    webView.delegate=self;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
//    1、只对本地html资源的图片有效果
//    NSString *js = @"function imgAutoFit() { \
//    var imgs = document.getElementsByTagName('img'); \
//    for (var i = 0; i < imgs.length; ++i) {\
//    var img = imgs[i];   \
//    img.style.maxWidth = %f;   \
//    } \
//    }";
//    js = [NSString stringWithFormat:js, [UIScreen mainScreen].bounds.size.width - 20];
//    [webView stringByEvaluatingJavaScriptFromString:js];
//    [webView stringByEvaluatingJavaScriptFromString:@"imgAutoFit()"];
    
//    2、都有效果
    NSString *js=@"var script = document.createElement('script');"
    "script.type = 'text/javascript';"
    "script.text = \"function ResizeImages() { "
    "var myimg,oldwidth;"
    "var maxwidth = %f;"
    "for(i=0;i <document.images.length;i++){"
    "myimg = document.images[i];"
    "if(myimg.width > maxwidth){"
    "oldwidth = myimg.width;"
    "myimg.width = %f;"
    "}"
    "}"
    "}\";"
    "document.getElementsByTagName('head')[0].appendChild(script);";
    js=[NSString stringWithFormat:js,[UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.width-15];
    [webView stringByEvaluatingJavaScriptFromString:js];
    [webView stringByEvaluatingJavaScriptFromString:@"ResizeImages();"];
    
}
@end
