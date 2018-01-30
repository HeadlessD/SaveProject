//
//  HMSArticleWebVC.m
//  HealthMonitoringSystem
//
//  Created by gw on 2017/7/27.
//  Copyright © 2017年 mirahome. All rights reserved.
//

#import "HMSArticleWebVC.h"
#import "HMSArticleModel.h"
#import "HMSWebProgressLayer.h"
#import "HMSSharePopView.h"

#define MLArticleBaseUrl @"http://web.cn.mirahome.net/article/index.html"
@interface HMSArticleWebVC ()<UIWebViewDelegate>
@property (nonatomic,strong) UIWebView *webView;
@end

@implementation HMSArticleWebVC
{
    
    HMSWebProgressLayer *_progressLayer; ///< 网页加载进度条
    NSString *_url;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initView];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
}

-(void)setArticleModel:(HMSArticleModel *)articleModel
{
    _articleModel = articleModel;
    
    
}


-(void)initView{
    
    
    _webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    _webView.delegate = self;
    _url =[NSString stringWithFormat:@"%@?article_id=%@",MLArticleBaseUrl,self.articleModel.articleId];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:_url]];
    
    [_webView loadRequest:request];
    
    _webView.backgroundColor = [UIColor whiteColor];
    
    _progressLayer = [HMSWebProgressLayer new];
    _progressLayer.frame = CGRectMake(0, -1, SCREEN_WIDTH, 2);
    
    [_webView.layer addSublayer:_progressLayer];
    [self.view addSubview:_webView];
    
    
    UIButton *backBtn =[[UIButton alloc]initWithFrame:CGRectMake(10, self.view.height -60-10, 60, 60)];
    [backBtn setBackgroundImage:[UIImage imageNamed:@"information_back"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    
    UIButton *shareBtn =[[UIButton alloc]initWithFrame:CGRectMake(KScreenWidth -60 -10, self.view.height -60-10, 60, 60)];
    [shareBtn setBackgroundImage:[UIImage imageNamed:@"information_share"] forState:UIControlStateNormal];
    [shareBtn addTarget:self action:@selector(share) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:shareBtn];
    
  
    
   
}

-(void)back
{
    if(self.webView.canGoBack)
    {
        [self.webView goBack];
    }else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}


-(void)share
{
    HMSSharePopView *sharePopView = [[HMSSharePopView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight)];
    [sharePopView show];
    sharePopView.popViewSelectAction = ^(NSInteger tag){
        
#warning 分享朋友圈点击之后逻辑
    };

}


#pragma mark - UIWebViewDelegate
/// 网页开始加载
- (void)webViewDidStartLoad:(UIWebView *)webView {
    
    [_progressLayer startLoad];
}

/// 网页完成加载
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [_progressLayer finishedLoad];
    
    // 获取h5的标题
    self.title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    
}

/// 网页加载失败
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [_progressLayer finishedLoad];
}

- (void)dealloc {
    
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    [_progressLayer closeTimer];
    [_progressLayer removeFromSuperlayer];
    _progressLayer = nil;
    NSLog(@"i am dealloc");
}



-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}


@end
