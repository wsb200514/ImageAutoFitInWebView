# ImageAutoFitInWebView
结合JS解决用webVIew加载图片时图片自动适配屏幕的问题

### 1、在标哥的博客中[WebView图片自适应屏幕](http://www.henishuo.com/webview-img-auto-fit/)中，标哥提供了一种解决方案，然后我就试验了一下。
```
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
  // 1、只对本地html资源的图片有效果
  NSString *js = @"function imgAutoFit() { \
  var imgs = document.getElementsByTagName('img'); \
  for (var i = 0; i < imgs.length; ++i) {\
  var img = imgs[i];   \
  img.style.maxWidth = %f;   \
  } \
  }";
  js = [NSString stringWithFormat:js, [UIScreen mainScreen].bounds.size.width - 20];
  [webView stringByEvaluatingJavaScriptFromString:js];
  [webView stringByEvaluatingJavaScriptFromString:@"imgAutoFit()"];
}
```

### 2、结论就在上述代码中：只对本地的html资源有效，我换了一个图片网站的URL地址，就没用了。

但是很明显解决思路就是标哥文章中所述，问题在哪里？可能还是在JS代码规范方面吧。

### 3、百度了一下，做了如下修改。测试结果如下所述：都有效果。
```
- (void)webViewDidFinishLoad:(UIWebView *)webView {
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
```

### 4、备注
* 自己用Django写了个大图片排版的html，然后在本地部署起来，用http://127.0.0.1:8000访问来测试。但是上传上来比较提供给其他人测试时就比较麻烦，不是所有人都安装了Django环境。
* 所以我就用了标哥的文件test.html，感谢标哥，哈哈。
