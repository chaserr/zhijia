//
//  GBMessageVC.m
//  zhijia
//
//  Created by admin on 15/7/30.
//  Copyright (c) 2015年 Beijing Hahu Technology Development Co., Ltd. All rights reserved.
//

#import "GBMessageVC.h"
#import "GBNotificationTC.h"
#import "GBPrivateLettersTC.h"
#import "UIViewController+MSLayoutSupport.h"

@interface GBMessageVC ()

@property(nonatomic,strong)UISegmentedControl *segmentedControl;

@property(nonatomic,strong)NSMutableArray *controllers;

@property(nonatomic,strong)NSMutableArray *titles;

@end

@implementation GBMessageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view
    
    
    if ([self.view respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
        self.view.preservesSuperviewLayoutMargins = YES;
    }
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.navigationItem.titleView = self.segmentedControl;
    
    
    GBNotificationTC *notificationVC=[[GBNotificationTC alloc] init];
    notificationVC.title = @"通知";
    
    GBPrivateLettersTC *privateLettersVC = [[GBPrivateLettersTC alloc] init];
    privateLettersVC.title = @"私信";
    
    self.controllers = [[NSMutableArray alloc] initWithArray:@[notificationVC,privateLettersVC]];
    
    [self setViewControllers:self.controllers];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)setViewControllers:(NSMutableArray *)viewControllers
{
//    [viewControllers enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
//        [self pushViewController:(UIViewController *)obj title:key];
//    }];
    [viewControllers enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [self pushViewController:(UIViewController *)obj title:((UIViewController *)obj).title];
    }];
    self.segmentedControl.selectedSegmentIndex=0;
    //self.selectedViewControllerIndex = 0;
    
    //defaut at index 0
    UIViewController<GBSegmentControllerDelegate> *controller = self.controllers[0];
    //controller.view.frame = self.view.bounds;
    [controller willMoveToParentViewController:self];
    
    [self addChildViewController:controller];
    
    [self.view insertSubview:controller.view atIndex:0];
    [controller didMoveToParentViewController:self];
    
    [self layoutControllerWithController:controller];
    
    self.selectedViewController = self.childViewControllers[self.segmentedControl.selectedSegmentIndex];
}
-(void)pushViewController:(UIViewController *)viewController title:(NSString *)title
{
    [self.segmentedControl insertSegmentWithTitle:title atIndex:self.segmentedControl.numberOfSegments animated:NO];
    
    [self.segmentedControl sizeToFit];
}
#pragma mark    - Property

-(UISegmentedControl *)segmentedControl
{
    if (!_segmentedControl) {
        _segmentedControl = [[UISegmentedControl alloc] init];
        [_segmentedControl addTarget:self action:@selector(segmentedControlSelected:) forControlEvents:UIControlEventValueChanged];
    }
    return _segmentedControl;
}

#pragma mark - Action

-(void)segmentedControlSelected:(UISegmentedControl *)sender
{
    NSInteger index = sender.selectedSegmentIndex;
    UIViewController<GBSegmentControllerDelegate> *descViewController=self.controllers[index];
    
    //descViewController.view.frame = self.view.bounds;
    
    [self.selectedViewController didMoveToParentViewController:nil];
    [self addChildViewController:descViewController];
    [self layoutControllerWithController:descViewController];
    
    [self transitionFromViewController:self.selectedViewController toViewController:descViewController duration:0 options:UIViewAnimationOptionTransitionNone
                            animations:^{
                            } completion:^(BOOL finished) {
                                if (finished) {
                                    
                                    [self.selectedViewController removeFromParentViewController];
                                    
                                    [descViewController didMoveToParentViewController:self];
                                    
                                    self.selectedViewController = descViewController;
                                    
                                }
                            }];
}

#pragma mark - function
-(void)layoutControllerWithController:(UIViewController<GBSegmentControllerDelegate> *)controller
{
    controller.view.frame = self.view.frame;
    
    UIScrollView *scrollView = [self scrollViewInPageController:controller];
    if (scrollView) {
//        CGFloat topInset = self.topLayoutGuide.length?self.topLayoutGuide.length:TOP_LAYOUT_LENGTH;
//        CGFloat bottomInset = self.bottomLayoutGuide.length?self.bottomLayoutGuide.length:BOTTOM_LAYOUT_LENGTH;
        
        CGFloat topInset = controller.ms_navigationBarTopLayoutGuide.length?controller.ms_navigationBarTopLayoutGuide.length:TOP_LAYOUT_LENGTH;
        CGFloat bottomInset = controller.ms_navigationBarBottomLayoutGuide.length?controller.ms_navigationBarBottomLayoutGuide.length:BOTTOM_LAYOUT_LENGTH;
        [scrollView setContentInset:UIEdgeInsetsMake(topInset, 0, bottomInset, 0)];
        [scrollView setScrollIndicatorInsets:UIEdgeInsetsMake(topInset, 0, bottomInset, 0)];
    
        [scrollView setContentOffset:CGPointMake(0, 0 - scrollView.contentInset.top) animated:NO];
//        UIEdgeInsets insets = UIEdgeInsetsMake(controller.ms_navigationBarTopLayoutGuide.length,
//                                                                                             0.0,
//                                               controller.ms_navigationBarBottomLayoutGuide.length,
//                                                                                             0.0) ;
        
//        scrollView.contentInset = scrollView.scrollIndicatorInsets = insets ;
//        
//        if (scrollView.contentOffset.y >= -(insets.top)) {
//            [scrollView setContentOffset:CGPointMake(0, -insets.top)];
//        }
    }


}

-(void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
}

-(UIScrollView *)scrollViewInPageController:(UIViewController <GBSegmentControllerDelegate> *)controller
{
    if ([controller respondsToSelector:@selector(streachScrollView)]) {
        return [controller streachScrollView];
    }else if ([controller.view isKindOfClass:[UIScrollView class]]){
        return (UIScrollView *)controller.view;
    }else{
        return nil;
    }
}

@end
