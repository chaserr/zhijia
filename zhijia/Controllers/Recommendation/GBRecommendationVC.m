//
//  GBRecommendationVC.m
//  zhijia
//
//  Created by admin on 15/8/3.
//  Copyright (c) 2015年 Beijing Hahu Technology Development Co., Ltd. All rights reserved.
//
#define kTimeLineTableViewCellId @"SDTimeLineCell"

#import "GBRecommendationVC.h"
#import "GBReleaseJobDynamicVC.h"


#import "GBRecommendCell.h"
#import "GBRecommendCellModel.h"
#import "UITableView+SDAutoTableViewCellHeight.h"
#import "UIView+SDAutoLayout.h"

#import "HCInputBar.h"

#import "IQKeyboardManager.h"
#import "UMSocial.h"
#import "YYShareToolViewConroller.h"
@interface GBRecommendationVC ()<GBRecommendCellDelegate, UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate, UMSocialUIDelegate>
{
    CGFloat _lastScrollViewOffsetY;
    CGFloat _totalKeybordHeight;
    NSIndexPath *_currentEditingIndexthPath;
    BOOL _wasKeyboardManagerEnabled;
    BOOL _isKeyboardVisible;
    CGFloat keyBoardOffset;

}
@property (nonatomic, strong) UITableView    *tableview;
@property (nonatomic, strong) NSMutableArray *dataArray;

@property (strong, nonatomic) CALayer        *animationLayer;

/** 评论输入框 */
@property (strong, nonatomic) HCInputBar     *inputBar;

@end

@implementation GBRecommendationVC

//- (void)loadView{
//
//    [super loadView];
//    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
//    self.view = scrollView;
//}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationTitleLabel.text = @"工作圈";
    [self createReleseDynamicBtn];

    [self createTableView];
    [self requestData];
    
    self.edgesForExtendedLayout = UIRectEdgeTop;
    
    [self.dataArray addObjectsFromArray:[self creatModelsWithCount:10]];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardNotification:) name:UIKeyboardWillChangeFrameNotification object:nil];
    

}

#pragma mark -- RequestData
- (void)requestData{

    
    NSString *url = GB_CONFIG.messageListUrl;
    // 由于这里有两套基础路径，用时就需要更新
    [GBNetworking postWithUrl:url params:nil success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseDict) {
        DLog(@"%@", responseDict);
    } fail:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        
    }];
    
}


#pragma mark -- UITableViewDelegate/DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    // >>>>>>>>>>>>>>>>>>>>> * cell自适应 * >>>>>>>>>>>>>>>>>>>>>>>>
    id model = self.dataArray[indexPath.row];
    // 根据不同的identifer获取不同的cell类型
//    NSString * identifier = [GBRecommendBaseCell cellIdentifierForRow:model];
//    Class mClass =  NSClassFromString(identifier);
    return [self.tableview cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[GBRecommendCell class] contentViewWidth:[self cellContentViewWith]];
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    GBRecommendCell *cell = [tableView dequeueReusableCellWithIdentifier:kTimeLineTableViewCellId];
    cell.indexPath = indexPath;
    cell.delegate = self;

    __weak typeof(self) weakSelf = self;
    if (!cell.moreButtonClickedBlock) {
        [cell setMoreButtonClickedBlock:^(NSIndexPath *indexPath) {
            GBRecommendCellModel *model = weakSelf.dataArray[indexPath.row];
            model.isOpening = !model.isOpening;
            [weakSelf.tableview reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        }];
    }
    if (!cell.addFlowerCountBlock) {
        cell.addFlowerCountBlock = ^(NSIndexPath *indexPath){
        
            [self alert:@"让这个模型的flowerCount + 1"];
        };
    }
    
    
    ////// 此步设置用于实现cell的frame缓存，可以让tableview滑动更加流畅 //////
    
    [cell useCellFrameCacheWithIndexPath:indexPath tableView:tableView];
    
    ///////////////////////////////////////////////////////////////////////
    
    cell.model = self.dataArray[indexPath.row];
    return cell;
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    [self textViewResignFirstResponder];
    return indexPath;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{

    
    if([tableView respondsToSelector:@selector(setCellLayoutMarginsFollowReadableWidth:)])
    {
        tableView.cellLayoutMarginsFollowReadableWidth = NO;
    }
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
    }
}

#pragma UIScrollerviewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{

        [self textViewResignFirstResponder];

}
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
//
//    [self textViewResignFirstResponder];
//
//}

#pragma mark - GBRecommendCellDelegate

- (void)didClickcCommentButtonInCell:(UITableViewCell *)cell
{
    _currentEditingIndexthPath = [self.tableview indexPathForCell:cell];
    [self.view.superview.superview addSubview:self.inputBar];
    [_inputBar.inputView becomeFirstResponder];
    [_inputBar showInputViewContents:^(NSString *contentStr) {

        if (contentStr.length) {
            GBRecommendCellModel *model = self.dataArray[_currentEditingIndexthPath.row];
            NSMutableArray *temp = [NSMutableArray new];
            [temp addObjectsFromArray:model.commentItemsArray];
            SDTimeLineCellCommentItemModel *commentItemModel = [SDTimeLineCellCommentItemModel new];
            commentItemModel.firstUserName = @"GSD_iOS";
            commentItemModel.commentString = contentStr;
            commentItemModel.firstUserId = @"GSD_iOS";
            [temp addObject:commentItemModel];
            model.commentItemsArray = [temp copy];
            [self.tableview reloadRowsAtIndexPaths:@[_currentEditingIndexthPath] withRowAnimation:UITableViewRowAnimationNone];
        }
    
    }];
 
}

- (void)didClickShareButtonInCell:(UITableViewCell *)cell
{
    
    [self shareToWeiXin];

//    [_inputBar.inputView resignFirstResponder];
//    [UMSocialQQHandler setQQWithAppId:kQQAppID appKey:kQQAppKey url:@"http://www.umeng.com/social"];
//
//    [UMSocialData defaultData].extConfig.title = @"分享的title";
//    [UMSocialData defaultData].extConfig.wechatSessionData.url = @"http://baidu.com";
//    [UMSocialSnsService presentSnsIconSheetView:self
//                                         appKey:kUMAppKey
//                                      shareText:@"友盟社会化分享让您快速实现分享等社会化功能，http://umeng.com/social"
//                                     shareImage:[UIImage imageNamed:@"icon"]
//                                shareToSnsNames:@[UMShareToWechatSession,UMShareToWechatTimeline,UMShareToSina,UMShareToQzone]
//                                       delegate:self];

    
}

- (void)didClickFlowerButtonInCell:(UITableViewCell *)cell
{
//    [self alert:@"送花"];
    NSIndexPath *indexPath = [self.tableview indexPathForCell:cell];
    GBRecommendCell *recommendCell = (GBRecommendCell *)cell;
    
    
    //组动画之修改透明度
    CABasicAnimation * alphaBaseAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    alphaBaseAnimation.fillMode = kCAFillModeBackwards;
    alphaBaseAnimation.duration = 1.0;
    alphaBaseAnimation.removedOnCompletion = NO;
    [alphaBaseAnimation setToValue:[NSNumber numberWithFloat:0.1]];
    alphaBaseAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];//决定动画的变化节奏
    //组动画之缩放动画
    CABasicAnimation * scaleBaseAnimation = [CABasicAnimation animation];
    scaleBaseAnimation.removedOnCompletion = NO;
    scaleBaseAnimation.fillMode = kCAFillModeBackwards;
    scaleBaseAnimation.duration = 1.0;
    scaleBaseAnimation.keyPath = @"transform.scale";
    scaleBaseAnimation.toValue = @2.0;
    
    CAAnimationGroup *animGroup = [CAAnimationGroup animation];
    animGroup.animations = @[alphaBaseAnimation,scaleBaseAnimation];
    animGroup.duration = 1.0;
    animGroup.fillMode = kCAFillModeBackwards;//不恢复原态
    animGroup.removedOnCompletion = NO;
    [recommendCell.flowerCountView.layer addAnimation:animGroup forKey:@"scaleAnimation"];

    recommendCell.addFlowerCountBlock(indexPath);
    
}

- (void)didClickLikeButtonInCell:(UITableViewCell *)cell
{
    NSIndexPath *index = [self.tableview indexPathForCell:cell];
    GBRecommendCellModel *model = self.dataArray[index.row];
    NSMutableArray *temp = [NSMutableArray arrayWithArray:model.likeItemsArray];
    
    if (!model.isLiked) {
        SDTimeLineCellLikeItemModel *likeModel = [SDTimeLineCellLikeItemModel new];
        likeModel.userName = @"GSD_iOS";
        likeModel.userId = @"gsdios";
        [temp addObject:likeModel];
        model.liked = YES;
    } else {
        SDTimeLineCellLikeItemModel *tempLikeModel = nil;
        for (SDTimeLineCellLikeItemModel *likeModel in model.likeItemsArray) {
            if ([likeModel.userId isEqualToString:@"gsdios"]) {
                tempLikeModel = likeModel;
                break;
            }
        }
        [temp removeObject:tempLikeModel];
        model.liked = NO;
    }
    model.likeItemsArray = [temp copy];
    
    [self.tableview reloadRowsAtIndexPaths:@[index] withRowAnimation:UITableViewRowAnimationNone];
}

#pragma mark -- UMSocialUIDelegate
/**
 各个页面执行授权完成、分享完成、或者评论完成时的回调函数
 
 @param response 返回`UMSocialResponseEntity`对象，`UMSocialResponseEntity`里面的viewControllerType属性可以获得页面类型
 */
-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
{
    //根据`responseCode`得到发送结果,如果分享成功
    if(response.responseCode == UMSResponseCodeSuccess)
    {
        //得到分享到的平台名
        NSLog(@"share to sns name is %@",[[response.data allKeys] objectAtIndex:0]);
    }
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField.text.length) {
        
        GBRecommendCellModel *model = self.dataArray[_currentEditingIndexthPath.row];
        NSMutableArray *temp = [NSMutableArray new];
        [temp addObjectsFromArray:model.commentItemsArray];
        
        SDTimeLineCellCommentItemModel *commentItemModel = [SDTimeLineCellCommentItemModel new];
        commentItemModel.firstUserName = @"GSD_iOS";
        commentItemModel.commentString = textField.text;
        commentItemModel.firstUserId = @"GSD_iOS";
        [temp addObject:commentItemModel];
        
        model.commentItemsArray = [temp copy];
        
        [self.tableview reloadRowsAtIndexPaths:@[_currentEditingIndexthPath] withRowAnimation:UITableViewRowAnimationNone];
        
        return YES;
    }
    return NO;
}


#pragma mark -- TestData
- (NSArray *)creatModelsWithCount:(NSInteger)count
{
    NSArray *iconImageNamesArray = @[@"icon0.jpg",
                                     @"icon1.jpg",
                                     @"icon2.jpg",
                                     @"icon3.jpg",
                                     @"icon4.jpg",
                                     ];
    
    NSArray *namesArray = @[@"GSD_iOS",
                            @"风口上的猪",
                            @"当今世界网名都不好起了",
                            @"我叫郭德纲",
                            @"Hello Kitty"];
    
    NSArray *textArray = @[@"当你的 app 没有提供 3x 的 LaunchImage 时，系统默认进入兼容模式，https://github.com/gsdios/SDAutoLayout大屏幕一切按照 320 宽度渲染，屏幕宽度返回 320；然后等比例拉伸到大屏。这种情况下对界面不会产生任何影响，等于把小屏完全拉伸。",
                           @"然后等比例拉伸到大屏。这种情况下对界面不会产生任何影响，https://github.com/gsdios/SDAutoLayout等于把小屏完全拉伸。",
                           @"当你的 app 没有提供 3x 的 LaunchImage 时屏幕宽度返回 320；然后等比例拉伸到大屏。这种情况下对界面不会产生任何影响，等于把小屏完全拉伸。但是建议不要长期处于这种模式下。屏幕宽度返回 320；https://github.com/gsdios/SDAutoLayout然后等比例拉伸到大屏。这种情况下对界面不会产生任何影响，等于把小屏完全拉伸。但是建议不要长期处于这种模式下。屏幕宽度返回 320；然后等比例拉伸到大屏。这种情况下对界面不会产生任何影响，等于把小屏完全拉伸。但是建议不要长期处于这种模式下。",
                           @"但是建议不要长期处于这种模式下，否则在大屏上会显得字大，内容少，容易遭到用户投诉。",
                           @"屏幕宽度返回 320；https://github.com/gsdios/SDAutoLayout然后等比例拉伸到大屏。这种情况下对界面不会产生任何影响，等于把小屏完全拉伸。但是建议不要长期处于这种模式下。"
                           ];
    
    NSArray *commentsArray = @[@"社会主义好！👌👌👌👌",
                               @"正宗好凉茶，正宗好声音。。。",
                               @"你好，我好，大家好才是真的好",
                               @"有意思",
                               @"你瞅啥？",
                               @"瞅你咋地？？？！！！",
                               @"hello，看我",
                               @"曾经在幽幽暗暗反反复复中追问，才知道平平淡淡从从容容才是真",
                               @"人艰不拆",
                               @"咯咯哒",
                               @"呵呵~~~~~~~~",
                               @"我勒个去，啥世道啊",
                               @"真有意思啊你💢💢💢"];
    
    NSArray *picImageNamesArray = @[ @"pic0.jpg",
                                     @"pic1.jpg",
                                     @"pic2.jpg",
                                     @"pic3.jpg",
                                     @"pic4.jpg",
                                     @"pic5.jpg",
                                     @"pic6.jpg",
                                     @"pic7.jpg",
                                     @"pic8.jpg"
                                     ];
    NSMutableArray *resArr = [NSMutableArray new];
    
    for (int i = 0; i < count; i++) {
        int iconRandomIndex = arc4random_uniform(5);
        int nameRandomIndex = arc4random_uniform(5);
        int contentRandomIndex = arc4random_uniform(5);
        
        GBRecommendCellModel *model = [GBRecommendCellModel new];
        model.iconName = iconImageNamesArray[iconRandomIndex];
        model.name = namesArray[nameRandomIndex];
        model.msgContent = textArray[contentRandomIndex];
        
        
        // 模拟“随机图片”
        int random = arc4random_uniform(6);
        
        NSMutableArray *temp = [NSMutableArray new];
        for (int i = 0; i < random; i++) {
            int randomIndex = arc4random_uniform(9);
            [temp addObject:picImageNamesArray[randomIndex]];
        }
        if (temp.count) {
            model.picNamesArray = [temp copy];
        }
        
        // 模拟随机评论数据
        int commentRandom = arc4random_uniform(3);
        NSMutableArray *tempComments = [NSMutableArray new];
        for (int i = 0; i < commentRandom; i++) {
            SDTimeLineCellCommentItemModel *commentItemModel = [SDTimeLineCellCommentItemModel new];
            int index = arc4random_uniform((int)namesArray.count);
            commentItemModel.firstUserName = namesArray[index];
            commentItemModel.firstUserId = @"666";
            if (arc4random_uniform(10) < 5) {
                commentItemModel.secondUserName = namesArray[arc4random_uniform((int)namesArray.count)];
                commentItemModel.secondUserId = @"888";
            }
            commentItemModel.commentString = commentsArray[arc4random_uniform((int)commentsArray.count)];
            [tempComments addObject:commentItemModel];
        }
        model.commentItemsArray = [tempComments copy];
        
        // 模拟随机点赞数据
        int likeRandom = arc4random_uniform(3);
        NSMutableArray *tempLikes = [NSMutableArray new];
        for (int i = 0; i < likeRandom; i++) {
            SDTimeLineCellLikeItemModel *model = [SDTimeLineCellLikeItemModel new];
            int index = arc4random_uniform((int)namesArray.count);
            model.userName = namesArray[index];
            model.userId = namesArray[index];
            [tempLikes addObject:model];
        }
        
        model.likeItemsArray = [tempLikes copy];
        
        
        
        [resArr addObject:model];
    }
    return [resArr copy];
}


#pragma mark -- Action

- (void)shareToWeiXin{
    
//    NSString *imageUrl =@"http://pic1.nipic.com/2008-09-12/20089129255891_2.jpg";
//    NSString *title=@"Pocket League Story";
//    NSString *detailInfo=@"找对象,上有缘网";
    YYShareToolViewConroller *shareVC = [[YYShareToolViewConroller alloc] init];
    [self addChildViewController:shareVC];
//    [shareVC initWhithTitle:title detailInfo:detailInfo image:nil imageUrl:imageUrl];
    [self.view addSubview:shareVC.view];
}

- (HCInputBar *)inputBar {
    if (!_inputBar) {
        _inputBar = [[HCInputBar alloc]initWithStyle:DefaultInputBarStyle];

        _inputBar.keyboard.showAddBtn = NO;
        [_inputBar.keyboard addBtnClicked:^{
            NSLog(@"我点击了添加按钮");
        }];
        _inputBar.placeHolder = @"评论";
    }
    return _inputBar;
}

- (void)createTableView{
    
    self.tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 49) style:UITableViewStylePlain];
    _tableview.delegate = self;
    _tableview.dataSource = self;
    _tableview.backgroundColor = RGBCOLOR(240, 240, 240);
//    _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableview];
    
    _tableview.tableFooterView = [UIView new];
    
    [self.tableview registerClass:[GBRecommendCell class] forCellReuseIdentifier:kTimeLineTableViewCellId];
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

- (void)viewDidAppear:(BOOL)animated{

    [super viewDidAppear:animated];
    _wasKeyboardManagerEnabled = [[IQKeyboardManager sharedManager] isEnabled];
    [[IQKeyboardManager sharedManager] setEnable:NO];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [[IQKeyboardManager sharedManager] setEnable:_wasKeyboardManagerEnabled];
    [self textViewResignFirstResponder];
}

- (void)viewDidLayoutSubviews{

    [super viewDidLayoutSubviews];
    if ([self.tableview respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableview setSeparatorInset:UIEdgeInsetsZero];
        
    }
    if ([self.tableview respondsToSelector:@selector(setLayoutMargins:)])  {
        [self.tableview setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (CGFloat)cellContentViewWith
{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    
    // 适配ios7
    if ([UIApplication sharedApplication].statusBarOrientation != UIInterfaceOrientationPortrait && [[UIDevice currentDevice].systemVersion floatValue] < 8) {
        width = [UIScreen mainScreen].bounds.size.height;
    }
    return width;
}

- (void)keyboardNotification:(NSNotification *)notification
{
    NSDictionary* info = [notification userInfo];
    CGRect rect = [info[@"UIKeyboardFrameEndUserInfoKey"] CGRectValue];
    if (rect.origin.y == SCREEN_HEIGHT) {
        // 键盘回收
        _isKeyboardVisible = YES;
    }else{
    
        _isKeyboardVisible = NO;
        keyBoardOffset = 0;


    }
    
    CGFloat h = rect.size.height + _inputBar.height;
        _totalKeybordHeight = h;
    [self adjustTableViewToFitKeyboardWithInfo:info];

}

- (void)adjustTableViewToFitKeyboardWithInfo:(NSDictionary *)info
{
    CGPoint offset = self.tableview.contentOffset;

    if (_isKeyboardVisible && keyBoardOffset) {
        
        offset.y -= keyBoardOffset;

    }else{
    
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        UITableViewCell *cell = [self.tableview cellForRowAtIndexPath:_currentEditingIndexthPath];
        CGRect rect = [cell.superview convertRect:cell.frame toView:window];
        CGFloat delta = CGRectGetMaxY(rect) - (window.bounds.size.height - _totalKeybordHeight);
        keyBoardOffset = delta;
        
        offset.y += _isKeyboardVisible? -delta : delta;
        if (offset.y < 0) {
            offset.y = 0;
        }
    }

    [UIView animateWithDuration:[info[UIKeyboardAnimationDurationUserInfoKey] doubleValue]
                          delay:0
                        options:([info[UIKeyboardAnimationCurveUserInfoKey] integerValue]<<16)
                     animations:^{
                         [self.tableview setContentOffset:offset animated:NO];

                     }
                     completion:nil];
}

- (void)textViewResignFirstResponder{

    [_inputBar.inputView resignFirstResponder];
}

- (void)dealloc
{
    
    [_inputBar removeFromSuperview];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray new];
    }
    return _dataArray;
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
