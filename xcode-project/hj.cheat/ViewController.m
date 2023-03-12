//
//  ViewController.m
//  hj.cheat
//
//  Created by xzz on 2023/3/12.
//

#import "ViewController.h"
#import "WebKit/WebKit.h"

#define JS(...)  [[NSString alloc] initWithCString:#__VA_ARGS__ encoding:NSUTF8StringEncoding]
static NSString * const url_key = @"null";

@interface ViewController ()
@property(nonatomic,strong) IBOutlet WKWebView *webView;
@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    CGRect screen = [[UIScreen mainScreen] bounds];
    self.navigationItem.hidesBackButton = YES;
    // Do any additional setup after loading the view.
    // 创建WebView配置
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
    // 获取JS文件路径
    NSString *jsPath = [[NSBundle mainBundle] pathForResource:@"MessageScript" ofType:@"js"];
    // 获取js数据
    NSData *jsData=[NSData dataWithContentsOfFile:jsPath];
    // 转js字符串类型
    NSString *jsString = [[NSString alloc]initWithData:jsData encoding:NSUTF8StringEncoding];
    NSLog(@"js = %@",jsString);
    // 创建WKUserScript
    WKUserScript *userScript = [[WKUserScript alloc]initWithSource:jsString injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
    // 注入到configuration配置内
    [configuration.userContentController addUserScript:userScript];
    self.webView = [[WKWebView alloc]initWithFrame:CGRectMake(0, 0, screen.size.width, screen.size.height)configuration:configuration];
    self.webView.UIDelegate = self;
    self.webView.navigationDelegate = self;
    self.webView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    
    [self.view addSubview:self.webView];
    NSURL *url=[NSURL URLWithString:@"https://h.api.4399.com/g.php?gameId=100063331"];
    NSURLRequest *request=[NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
  
}

//在网络加载前调用，用于前置拦截一些网络请求，WKNavigationActionPolicyAllow代表允许请求，WKNavigationActionPolicyCancel代表取消请求
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    NSString *url_str =
        @"https://hjstatic.3304399.net/hjczjh/version/rc2302221/index_h5.html";
    NSRange range = [navigationAction.request.URL.absoluteString rangeOfString:url_str];
    NSLog(@"当前url = %@",navigationAction.request.URL.absoluteString);
    if(range.length != 0){
        NSString *new_url = navigationAction.request.URL.absoluteString;
        BOOL doesExist = [url_key isEqualToString:@"null"];
        if(doesExist != 0){
            NSLog(@"找到真实url = %@",new_url);
            NSURL *l_url=[NSURL URLWithString:new_url];
            NSURLRequest *request_n=[NSURLRequest requestWithURL:l_url];
            [self.webView loadRequest:request_n];
            static NSString * const url_key = @"yes";
        }
    }
    decisionHandler(WKNavigationActionPolicyAllow);
}

#pragma mark -- WKUIDelegate

- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:message?:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:([UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        completionHandler();
        NSLog(@"点击了取消按钮==%@",message);
    }])];
    [alertController addAction:([UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler();
        NSLog(@"点击了确定按钮==%@",message);
    }])];

    [self presentViewController:alertController animated:YES completion:nil];

}


- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    NSLog(@"请求结束");
//    [webView evaluateJavaScript:JS(
//           alert('hi');
//        ) completionHandler:nil];
}

////收到301或者302重定向请求的时候调用
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation
{
    NSLog(@"Redirect");
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    NSLog(@"内存告警,要闪退了！");
    // Dispose of any resources that can be recreated.
}


@end
