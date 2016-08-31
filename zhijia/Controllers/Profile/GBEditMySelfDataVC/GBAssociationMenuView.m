//
//  SkyAssociationMenuView.m
//
//  Created by skytoup on 14-10-24.
//  Copyright (c) 2014年 skytoup. All rights reserved.
//

#import "GBAssociationMenuView.h"

NSString *const IDENTIFIER = @"CELL";

@interface GBAssociationMenuView () <UITableViewDataSource, UITableViewDelegate, UIGestureRecognizerDelegate>
{
    NSArray *tables;
    UIView *bgView;
    /** 记录选中的cell */
    NSInteger _index;
    
}
@property (nonatomic, strong) UIViewController *viewController;
@property (nonatomic, assign) NSInteger selectCell;
@end

@implementation GBAssociationMenuView

- (instancetype)init
{
    self = [super init];
    if (self) {
        // 初始化选择项
        for(int i=0; i!=3; ++i) {
            sels[i] = -1;
        }
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        self.userInteractionEnabled = YES;
        UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        cancelBtn.frame = self.frame;
        [cancelBtn addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:cancelBtn];
        // 初始化菜单
        tables = @[[[UITableView alloc] init], [[UITableView alloc] init], [[UITableView alloc] init] ];
        [tables enumerateObjectsUsingBlock:^(UITableView *table, NSUInteger idx, BOOL *stop) {
            [table registerClass:[UITableViewCell class] forCellReuseIdentifier:IDENTIFIER ];
            table.dataSource = self;
            table.delegate = self;
            table.frame = CGRectMake(0, 0, 0, 0);
            table.backgroundColor = [UIColor clearColor];
            table.tableFooterView = [UIView new];

        }];
        bgView = [[UIView alloc] init];
        bgView.backgroundColor = [UIColor whiteColor];
        bgView.userInteractionEnabled = YES;
        [bgView addSubview:[tables objectAtIndex:0] ];
        _index = -1;

    }
    return self;
}

#pragma mark private
/**
 *  调整表视图的位置、大小
 */
- (void)adjustTableViews{
    int w = SCREEN_WIDTH;
    int __block showTableCount = 0;
    [tables enumerateObjectsUsingBlock:^(UITableView *t, NSUInteger idx, BOOL *stop) {
        CGRect rect = t.frame;
        rect.size.height = SCREEN_HEIGHT - bgView.frame.origin.y;
        t.frame = rect;
        if(t.superview)
            ++showTableCount;
    }];
    
    for(int i=0; i!=showTableCount; ++i){
        UITableView *t = [tables objectAtIndex:i];
        CGRect f = t.frame;
        f.size.width = w / showTableCount;
        f.origin.x = f.size.width * i;
        t.frame = f;
    }
}
/**
 *  取消选择
 */
- (void)cancel{
    [self dismiss];
    if([self.delegate respondsToSelector:@selector(assciationMenuViewCancel)]) {
        [self.delegate assciationMenuViewCancel];
    }
}

/**
 *  保存table选中项
 */
- (void)saveSels{
    [tables enumerateObjectsUsingBlock:^(UITableView *t, NSUInteger idx, BOOL *stop) {
        sels[idx] = t.superview ? t.indexPathForSelectedRow.row : -1;
    }];
}

/**
 *  加载保存的选中项
 */
- (void)loadSels{
    [tables enumerateObjectsUsingBlock:^(UITableView *t, NSUInteger i, BOOL *stop) {
        if (sels[i] == -1 && (i == 0 || i == 1)) {
            // 默认选中第一个
            sels[i] = 0;
        }
        [t selectRowAtIndexPath:[NSIndexPath indexPathForRow:sels[i] inSection:0] animated:NO scrollPosition:UITableViewScrollPositionNone];

        if((sels[i] != -1 && !t.superview) || !i) {
            [bgView addSubview:t];
        }
    }];
}

#pragma mark public
- (void)setSelectIndexForClass1:(NSInteger)idx_1 class2:(NSInteger)idx_2 class3:(NSInteger)idx_3 {
    sels[0] = idx_1;
    sels[1] = idx_2;
    sels[2] = idx_3;
}

- (void)showAsDrawDownView:(UIViewController *)viewController {
    CGFloat x = 0.f;
    CGFloat y = 64.0f;
    CGFloat w = SCREEN_WIDTH;
    CGFloat h = CONTENT_HEIGHT;
    bgView.frame = CGRectMake(x, y, w, h);
    if(!bgView.superview) {
        [self addSubview:bgView];
    }
    [self loadSels];
    [self adjustTableViews];
    self.viewController = viewController;
    [viewController.view addSubview:self];
//    if(!self.superview) {
//        [[[UIApplication sharedApplication] keyWindow] addSubview:self];
//        self.alpha = .0f;
//        [UIView animateWithDuration:.25f animations:^{
//            self.alpha = 1.0f;
//        }];
//    }
//    [[[UIApplication sharedApplication] keyWindow] bringSubviewToFront:self];
}

- (void)dismiss{
    if(self.superview) {
        [UIView animateWithDuration:.25f animations:^{
            self.alpha = .0f;
        } completion:^(BOOL finished) {
            [bgView.subviews enumerateObjectsUsingBlock:^(UIView *obj, NSUInteger idx, BOOL *stop) {
                [obj removeFromSuperview];
            }];
            
            [_viewController.navigationController popViewControllerAnimated:YES];

            [self removeFromSuperview];
        }];
    }
}

#pragma mark UITableViewDateSourceDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableView *t0 = [tables objectAtIndex:0];
    UITableView *t1 = [tables objectAtIndex:1];
    UITableView *t2 = [tables objectAtIndex:2];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:IDENTIFIER];
    if(tableView == t0){
        cell.textLabel.text = [_delegate assciationMenuView:self titleForClass_1:indexPath.row];
        cell.selectedBackgroundView = [[UIImageView alloc] initWithImage:[UIImage imageWithColor:[UIColor colorWithWhite:0.932 alpha:1.000]]];

        
    }else if(tableView == t1){
        cell.textLabel.text = [_delegate assciationMenuView:self titleForClass_1:((UITableView*)tables[0]).indexPathForSelectedRow.row class_2:indexPath.row];
        cell.backgroundColor = [UIColor colorWithWhite:0.932 alpha:1.000];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.selectedBackgroundView = [[UIImageView alloc] initWithImage:[UIImage imageWithColor:[UIColor colorWithWhite:0.932 alpha:1.000]]];
        if (t0.indexPathForSelectedRow.row == sels[0] && _index == indexPath.row) {
            
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }else{
            
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        
        // 恢复之前点击状态

    }else if(tableView == t2){
        cell.textLabel.text = [_delegate assciationMenuView:self titleForClass_1:((UITableView*)tables[0]).indexPathForSelectedRow.row class_2:((UITableView*)tables[1]).indexPathForSelectedRow.row class_3:indexPath.row];
    }

    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger __block count;
    [tables enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if(obj == tableView) {
            count = [_delegate assciationMenuView:self countForClass:idx withUpCell:_selectCell];
            *stop = YES;
        }
    }];
    return count;
}

#pragma mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableView *t0 = [tables objectAtIndex:0];
    UITableView *t1 = [tables objectAtIndex:1];
    UITableView *t2 = [tables objectAtIndex:2];
    BOOL isNexClass = true;
    if(tableView == t0){
        if([self.delegate respondsToSelector:@selector(assciationMenuView:idxChooseInClass1:)]) {
            isNexClass = [_delegate assciationMenuView:self idxChooseInClass1:indexPath.row];
        }
        if(isNexClass) {
            self.selectCell = indexPath.row;
            [t1 reloadData];
            
            if(!t1.superview) {
                [bgView addSubview:t1];
            }
            if(t2.superview) {
                [t2 removeFromSuperview];
            }
            [self adjustTableViews];
        }
        else{
            if(t1.superview) {
                [t1 removeFromSuperview];
            }
            if(t2.superview) {
                [t2 removeFromSuperview];
            }
            [self saveSels];
            [self dismiss];
        }
    }
    else if(tableView == t1) {
        if([self.delegate respondsToSelector:@selector(assciationMenuView:idxChooseInClass1:class2:)]) {
            isNexClass = [_delegate assciationMenuView:self idxChooseInClass1:t0.indexPathForSelectedRow.row class2:indexPath.row];
        }
        if(isNexClass){
            [t2 reloadData];
            if(!t2.superview) {
                [bgView addSubview:t2];
            }
            [self adjustTableViews];
        }else{
            if(t2.superview) {
                [t2 removeFromSuperview];
            }
            [self saveSels];

            NSIndexPath *lastIndex = [NSIndexPath indexPathForRow:_index inSection:0];
            UITableViewCell *lastCell = (UITableViewCell *)[t1 cellForRowAtIndexPath:lastIndex];
            lastCell.accessoryType = UITableViewCellAccessoryNone;
            [t1 deselectRowAtIndexPath:indexPath animated:YES];
            [[t1 visibleCells] enumerateObjectsUsingBlock:^(UITableViewCell *obj, NSUInteger idx, BOOL *stop) {
                if ([t1 indexPathForCell:obj].section == indexPath.section) {
                    obj.accessoryType = UITableViewCellAccessoryNone;
                    //            [obj setAccessoryType:UITableViewCellAccessoryNone];
                }
            }];
            
            UITableViewCell *cell = (UITableViewCell *)[t1 cellForRowAtIndexPath:indexPath];
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
            // 记录本次点击的cell位置解决重用问题
            _index = indexPath.row;
    
            BOOL isDismiss;
            if (_delegate && [_delegate respondsToSelector:@selector(idx_2ChooseInClassShouldDismiss)]) {
                isDismiss = [_delegate idx_2ChooseInClassShouldDismiss];
            }
            if (isDismiss) {
                [self dismiss];
            }
        }
    }else if(tableView == t2) {
        if([self.delegate respondsToSelector:@selector(assciationMenuView:idxChooseInClass1:class2:class3:)]) {
            isNexClass = [_delegate assciationMenuView:self idxChooseInClass1:t0.indexPathForSelectedRow.row class2:t1.indexPathForSelectedRow.row class3:indexPath.row];
        }
        if(isNexClass) {
            [self saveSels];
            [self dismiss];
        }
    }
}

@end
