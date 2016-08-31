//
//  CYLSearchMainViewController.m
//  CYLSearchViewController
//
//  Created by http://weibo.com/luohanchenyilong/ on 15/4/29.
//  Copyright (c) 2015年 https://github.com/ChenYilong/CYLSearchViewController . All rights reserved.
//

//View Controllers
#import "CYLSearchMainViewController.h"
#import "CYLSearchController.h"
//Views
#import "CYLSearchBar.h"
#import "TagListView.h"
#import "TagView.h"
@interface CYLSearchMainViewController ()<CYLSearchControllerDelegate,UISearchBarDelegate,TagListViewDelegate>

@property (nonatomic, strong) UINavigationController *searchController;
@property (nonatomic, strong) CYLSearchBar *searchBar;
@property (strong, nonatomic) TagListView *tagListView;
@property (nonatomic, strong) UILabel *tagTitleLabel;

@end

@implementation CYLSearchMainViewController

#pragma mark - 💤 LazyLoad Method

/**
 *  懒加载_searchBar
 *
 *  @return UISearchBar
 */
- (CYLSearchBar *)searchBar
{
    if (_searchBar == nil) {
        _searchBar = [[CYLSearchBar alloc] initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, 44)];
        _searchBar.delegate = self;
    }
    return _searchBar;
}

#pragma mark - ♻️ LifeCycle Method

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.searchBar resignFirstResponder];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self customlizeNavigationBarBackBtn];
    [self.view addSubview:self.searchBar];
    self.navigationTitleLabel.text = @"搜索";
    [self createMyTagsView];

}

#pragma mark - 🔌 CYLSearchHeaderViewDelegate Method

- (void)searchHeaderViewClicked:(id)sender {
    CYLSearchController *controller = [[CYLSearchController alloc] initWithNibName:@"CYLSearchController" bundle:nil];
    controller.delegate = self;
    self.searchController = [[UINavigationController alloc] initWithRootViewController:controller];
    [controller showInViewController:self];
}

#pragma mark - 🔌 CYLSearchControllerDelegate Method

- (void)questionSearchCancelButtonClicked:(CYLSearchController *)controller
{

    [controller hide:^{

        NSLog(@"questionSearchCancelButtonClicked");
        self.searchBar.hidden = NO;
        self.tagTitleLabel.frame = CGRectMake(10, 64 + 44 + 10, SCREEN_WIDTH - 20, 20);
        self.tagListView.frame =  CGRectMake(0,  CGRectGetMaxY(_tagTitleLabel.frame) + 10, SCREEN_WIDTH, 300);

    }];
    
}

#pragma mark - 🔌 UISearchBarDelegate Method

/**
 *  开始编辑
 */
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    [self searchHeaderViewClicked:nil];
    self.searchBar.hidden = YES;
    [UIView animateWithDuration:0.5 animations:^{
        self.tagTitleLabel.frame = CGRectMake(10, 64 + 10, SCREEN_WIDTH - 20, 20);
        self.tagListView.frame =  CGRectMake(0,  CGRectGetMaxY(_tagTitleLabel.frame) + 10, SCREEN_WIDTH, 300);
        
    } completion:nil];
}

#pragma mark TagListViewDelegate Method
- (void)selectTagsArray:(NSArray *)tagArray{
    

}

#pragma mark -- Action
- (void)createMyTagsView{
    
    self.tagTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 64 + 44 + 10, SCREEN_WIDTH - 20, 20)];
    _tagTitleLabel.text = @"和我相同行业的人";
    _tagTitleLabel.textAlignment = NSTextAlignmentLeft;
    _tagTitleLabel.font = [UIFont systemFontOfSize:17];
    _tagTitleLabel.textColor = [UIColor colorWithWhite:0.777 alpha:1.000];
    [self.view addSubview:_tagTitleLabel];
    [self.view layoutIfNeeded];
    self.tagListView = [[TagListView alloc] initWithFrame:CGRectMake(0,  CGRectGetMaxY(_tagTitleLabel.frame) + 10, SCREEN_WIDTH, 300)];
    self.tagListView.delegate = self;
    self.tagListView.backgroundColor = [UIColor whiteColor];
    [self.tagListView addTagWithArray:@[@"平面设计", @"交互设计", @"网页设计", @"创意", @"UI设计", @"产品经理",@"广告设计",@"专题设计", @"VI设计", @"店铺设计"] withHasCustomTag:NO];
    _tagListView.tagBackgroundColor = [UIColor colorWithWhite:0.964 alpha:1.000];
    _tagListView.cornerRadius = 15;
    _tagListView.borderWidth = 0;
    _tagListView.paddingY = 8;
    _tagListView.paddingX = 15;
    _tagListView.marginX = 15;
    _tagListView.marginY = 15;
    _tagListView.textColor = [UIColor colorWithWhite:0.648 alpha:1.000];
    
    [self.view addSubview:_tagListView];
    
    [_tagListView.subviews enumerateObjectsUsingBlock:^( TagView * tagView, NSUInteger idx, BOOL * _Nonnull stop) {
        
            [tagView setOnTap:^(TagView *tagView) {

                /**
                 *  tag点击事件  code
                 */
                
            }];
        
        if (idx == _tagListView.subviews.count - 1) {
            
            
            [self resetTagViewFrameWithLastTag:tagView];
        }
    }];
    
}

- (void)resetTagViewFrameWithLastTag:(TagView *)tagView{
    
    CGRect frame = CGRectMake(0, CGRectGetMaxY(_tagTitleLabel.frame) + 10, SCREEN_WIDTH, tagView.y + tagView.height + 20);
    _tagListView.frame = frame;
}


@end
