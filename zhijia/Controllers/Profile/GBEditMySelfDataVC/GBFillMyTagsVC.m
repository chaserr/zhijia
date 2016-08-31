//
//  GBFillMyTagsVC.m
//  zhijia
//
//  Created by 童星 on 16/3/31.
//  Copyright © 2016年 Beijing Jianjian Technology Development Co., Ltd. All rights reserved.
//

#import "GBFillMyTagsVC.h"
#import "JRMessageView.h"
#import "TagView.h"
#import "TagListView.h"
#import "STAlertView.h"
@interface GBFillMyTagsVC ()<TagListViewDelegate>

@property (nonatomic, strong) JRMessageView *messageTips;
@property (strong, nonatomic) TagListView *tagListView;
@property (nonatomic, strong) STAlertView *stAlertView;
@property (nonatomic, strong) NSMutableArray *selectArray;


@end

@implementation GBFillMyTagsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self customlizeNavigationBarBackBtn];
    self.navigationTitleLabel.text = @"职业方向";
    self.navigationItem.rightBarButtonItem =({
        UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(saveMyTags)];
        rightItem;
    });
    
    [self createAddIndustry];
    
    [self createTipMsg];
    
    [self createMyTagsView];
}


- (void)createAddIndustry{

    UIButton *button = [UIButton buttonWithType:(UIButtonTypeSystem)];
    button.frame = CGRectMake(10, 64+10, SCREEN_WIDTH - 20, 40);
    button.backgroundColor = [UIColor whiteColor];
    [button setTitle:@"选择其他行业" forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"add"] forState:(UIControlStateNormal)];
    [self.view addSubview:button];
}

- (void)saveMyTags{

    DLog(@"save data");
    if (self.messageTips.isShow) {
        [self.messageTips hidedMessageView];
    } else {
        [self.messageTips showMessageView];
    }
}


- (void)createMyTagsView{
    self.tagListView = [[TagListView alloc] initWithFrame:CGRectMake(0, 64*2, SCREEN_WIDTH, 300)];
    self.tagListView.delegate = self;
    self.tagListView.backgroundColor = [UIColor whiteColor];
    [self.tagListView addTagWithArray:@[@"运营", @"管理", @"商务", @"后天技术", @"UI设计", @"iOS",@"WEB前端",@"安卓", @"+ 自定义"] withHasCustomTag:YES];
    _tagListView.tagBackgroundColor = [UIColor colorWithWhite:0.964 alpha:1.000];
    _tagListView.cornerRadius = 15;
    _tagListView.borderWidth = 0;
    _tagListView.paddingY = 8;
    _tagListView.paddingX = 15;
    _tagListView.marginX = 15;
    _tagListView.marginY = 15;
//    _tagListView.textFont = GBSystemFont(12);
    _tagListView.textColor = [UIColor colorWithWhite:0.648 alpha:1.000];
    
    [self.view addSubview:_tagListView];
    
    [_tagListView.subviews enumerateObjectsUsingBlock:^( TagView * tagView, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if ([[tagView currentTitle] isEqualToString:@"+ 自定义"]) {
            
            [tagView setOnTap:^(TagView *tagView) {
                
                self.stAlertView = [[STAlertView alloc] initWithTitle:@"自定义标签"
                                                              message:nil
                                                        textFieldHint:@"自定义标签"
                                                       textFieldValue:nil
                                                    cancelButtonTitle:@"取消"
                                                    otherButtonTitles:@"确定"
                                                    cancelButtonBlock:^{
                                                        NSLog(@"Please, give me some feedback!");
                                                    } otherButtonBlock:^(NSString * result){
                                                        [_tagListView addTag:result];
                                                        
                                                        [self resetTagViewFrameWithLastTag:tagView];

                                                    }];
                
            }];
        }else{
            
            [tagView setOnTap:^(TagView *tagView) {
                [self changeSelectTagViewState:tagView];
                
            }];
        }
        
        if (idx == _tagListView.subviews.count - 1) {
                        

            [self resetTagViewFrameWithLastTag:tagView];
        }
        
        
    }];

}
- (void)createTipMsg{

    self.messageTips = [[JRMessageView alloc] initWithTitle:@"至少选择3个标签" subTitle:nil iconName:nil messageType:JRMessageViewTypeMessage messagePosition:JRMessagePositionTop superVC:self duration:2];
}

- (NSMutableArray *)selectArray{
    
    if (_selectArray == nil) {
        _selectArray = [NSMutableArray array];
    }
    return  _selectArray;
}

- (void)resetTagViewFrameWithLastTag:(TagView *)tagView{

    CGRect frame = CGRectMake(0, 64*2, SCREEN_WIDTH, tagView.y + tagView.height + 20);
    _tagListView.frame = frame;
}

- (void)changeSelectTagViewState:(TagView *)tagView{

    if (!tagView.selected) {
        if (self.selectArray.count >= 3 ) {
            
            if (self.messageTips.isShow) {
                [self.messageTips hidedMessageView];
            }
            else {
                [self.messageTips showMessageView];
            }
            
        }
        else{
            if ([_selectArray indexOfObject:tagView] == NSNotFound) {
                tagView.backgroundColor = [UIColor colorWithRed:1.0 green:0.8093 blue:0.186 alpha:1.0];
                tagView.selected = !tagView.selected;
                
                [self.selectArray addObject:tagView];
            }
            
        }
        
    }
    else{
        
        tagView.backgroundColor = _tagListView.tagBackgroundColor;
        [self.selectArray removeObject:tagView];
        tagView.selected = !tagView.selected;
        
    }
}


#pragma mark TagListViewDelegate Method
- (void)selectTagsArray:(NSArray *)tagArray{

    if (self.messageTips.isShow) {
        [self.messageTips hidedMessageView];
    } else {
        [self.messageTips showMessageView];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
