//
//  GBHomeViewController.m
//  zhijia
//
//  Created by 童星 on 16/6/7.
//  Copyright © 2016年 Beijing tongxing Technology Development Co., Ltd. All rights reserved.
//

#import "GBHomeViewController.h"
#import "GBSegumentController.h"
#import "GBReleaseJobDynamicVC.h"
#import "IQKeyboardManager.h"
@interface GBHomeViewController ()<GBSegmentViewDelegate,UIScrollViewDelegate,UIGestureRecognizerDelegate>
@property (nonatomic, strong) GBSegumentController *segumentControl;
@property (nonatomic, strong) UIScrollView * scrollView;
@property (nonatomic, assign) NSInteger currentPage;
@end

@implementation GBHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self createSegumentControl];
    self.automaticallyAdjustsScrollViewInsets = NO;

    _recommendationVC = [[GBRecommendationVC alloc] init];
    _qaViewController = [[GBQAViewController alloc] init];
    [self addChildViewController:_recommendationVC];
    [self addChildViewController:_qaViewController];
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 49)];
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.pagingEnabled = YES;
    _scrollView.delegate = self;
    _scrollView.bounces = NO;
    _scrollView.scrollEnabled = YES;
    _scrollView.contentSize = CGSizeMake([UIDevice screenWidth]*_segumentControl.titles.count, CGRectGetHeight(_scrollView.bounds));
    [self.view addSubview:_scrollView];

    _recommendationVC.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 49);
    _qaViewController.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 49);
    [self scrollViewAddView:_recommendationVC.view index:0];
    [self scrollViewAddView:_qaViewController.view index:1];
    _currentPage = 0;

    
    [self createReleseDynamicBtn];


}


#pragma mark -- GBSegumentControllerDelegate
- (void)segmentView:(GBSegumentController * __nullable)segmentView didSelectedIndex:(NSUInteger)selectedIndex{

        DLog(@"代理回调view:%@ selectedIndex: %ld",segmentView,selectedIndex);
    [self scrollToPage:selectedIndex];

}

#pragma mark -- ScrollerViewDelegte
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    if (_currentPage == scrollView.contentOffset.x /[UIDevice screenWidth]) {
        return;
    }else{
        NSInteger page = scrollView.contentOffset.x/[UIDevice screenWidth];
        
        [self setSegmentViewBtnWithPage:page];
        _currentPage = page;
    }
}

- (void) setSegmentViewBtnWithPage:(NSInteger) page
{
    if (_currentPage == page) {
        return;
    }else{
        self.segumentControl.selectedIndex = page;
    }
    
}

#pragma mark -- Action

- (void) scrollToPage:(NSInteger) page
{
    [_scrollView scrollRectToVisible:CGRectMake(page * [UIDevice screenWidth], 0, CGRectGetWidth(_scrollView.bounds), CGRectGetHeight(_scrollView.bounds)) animated:YES];

}

- (void) scrollViewAddView:(UIView *) view index:(NSInteger) index
{
    CGRect rect = _scrollView.bounds;
    view.frame = CGRectMake(index * CGRectGetWidth(rect) , 0, CGRectGetWidth(rect), CGRectGetHeight(rect));
    [self.scrollView addSubview:view];
    
}

- (void)createSegumentControl{

    self.segumentControl = [[GBSegumentController alloc] initWithFrame:CGRectMake(0, 0, 176, 46) items:@[@"工作圈",@"问答"]];
    
    _segumentControl.tintColor = [UIColor colorWithWhite:0.733 alpha:1.000];
    _segumentControl.layer.borderColor = [UIColor clearColor].CGColor;
    _segumentControl.delegate = self;
    _segumentControl.itemHeight = 30;
    _segumentControl.selectedIndex = 0;
    _segumentControl.handlder = ^ (GBSegumentController * __nullable view, NSInteger selectedIndex) {
        NSLog(@"Block回调view:%@ selectedIndex: %ld",view,selectedIndex);
    };
    self.navigationItem.titleView = _segumentControl;
    
}
- (void)createReleseDynamicBtn
{
    UIImage * image = [UIImage imageNamed:@"iconwrite"];
    self.navigationItem.rightBarButtonItem =({
        UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(releaseDynamic)];
        rightItem;
    });
}

- (void)releaseDynamic{
    
    GBReleaseJobDynamicVC *releaseJobDynamic = [[GBReleaseJobDynamicVC alloc] init];
    [self.navigationController pushViewController:releaseJobDynamic animated:YES];
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
