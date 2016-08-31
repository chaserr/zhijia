//
//  YHCPickerView.m
//  TestDB
//
//  Created by Yashesh Chauhan on 01/10/12.
//  Copyright (c) 2012 Yashesh Chauhan. All rights reserved.
//

#import "YHCPickerView.h"

@implementation YHCPickerView
@synthesize arrRecords,delegate;


-(id)initWithFrame:(CGRect)frame withNSArray:(NSArray *)arrValues{

    self = [super initWithFrame:frame];
    if (self) {
        
        self.arrRecords = arrValues;
    }
    return self;

}
-(void)showPicker{
    
    
    self.userInteractionEnabled = TRUE;
    self.backgroundColor = [UIColor colorWithWhite:1.000 alpha:0.000];
    
    [UIView animateWithDuration:0.5 animations:^{
        self.backgroundColor = [UIColor colorWithWhite:1.000 alpha:0.500];
    } completion:nil];
    
    copyListOfItems = [[NSMutableArray alloc] init];
    picketToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.frame) - 244, SCREEN_WIDTH, 44)];

    pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0.0, CGRectGetMaxY(picketToolbar.frame), SCREEN_WIDTH, 200)];
    
    //[picketView addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
    
    pickerView.showsSelectionIndicator = YES;
    pickerView.delegate = self;
    pickerView.dataSource = self;
    pickerView.backgroundColor = [UIColor whiteColor];
    picketToolbar.barStyle = UIBarStyleDefault;
    [picketToolbar sizeToFit];
    
    txtSearch = [[UISearchBar alloc] initWithFrame:CGRectMake(15, 7, 240, 31)];
    txtSearch.tag = 1;
    txtSearch.barStyle = UIBarStyleBlackTranslucent;
    txtSearch.keyboardType = UIKeyboardTypeDefault;
    txtSearch.backgroundColor = [UIColor whiteColor];

    txtSearch.delegate = self;
    txtSearch.userInteractionEnabled = TRUE;
    [self setSearchTextFieldBackgroundColor:[UIColor whiteColor]];
    
    for (UIView *subview in txtSearch.subviews) {
        if ([subview isKindOfClass:NSClassFromString(@"UISearchBarBackground")]) {
            [subview removeFromSuperview];
            break;
        }
    } 
    
    UIBarButtonItem *flexible = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    UIBarButtonItem *btnDone = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(btnDoneClick)];
    [picketToolbar addSubview:txtSearch];
    NSArray *arrBarButtoniTems = [[NSArray alloc] initWithObjects:flexible,btnDone, nil];
    [picketToolbar setItems:arrBarButtoniTems];
    [self addSubview:pickerView];
    [self addSubview:picketToolbar];
    
}

- (void) searchBarTextDidBeginEditing:(UISearchBar *)theSearchBar {
 
    searching = NO;
	letUserSelectRow = NO;
////    if (pickerView) {
////        [pickerView removeFromSuperview];
////    }
//    pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, 320, 120)];
//    pickerView.showsSelectionIndicator = YES;
//    pickerView.delegate = self;
//    pickerView.dataSource = self;
}

- (void)searchBar:(UISearchBar *)theSearchBar textDidChange:(NSString *)searchText {
    
	//Remove all objects first.
	[copyListOfItems removeAllObjects];
	
	if([searchText length] > 0) {
    
		searching = YES;
		letUserSelectRow = YES;
    
		[self searchTableView];
	}
	else {
		
		searching = NO;
		letUserSelectRow = NO;

	}
	
	[pickerView reloadAllComponents];
}


- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
    [self btnDoneClick];
}

- (void) searchTableView {
	
	NSString *searchText = txtSearch.text;
	NSMutableArray *searchArray = [[NSMutableArray alloc] init];

	
	for (NSString *sTemp in self.arrRecords)
	{
		NSRange titleResultsRange = [sTemp rangeOfString:searchText options:NSCaseInsensitiveSearch];
		
		if (titleResultsRange.length > 0){
			[copyListOfItems addObject:sTemp];
        }
	}
    [pickerView reloadAllComponents];
	
	searchArray = nil;
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
}

-(void)btnDoneClick{
    
    NSString *strSelectedValue;
    
    if (searching ) {
        
        if (copyListOfItems.count > 0) {
            
            strSelectedValue = [copyListOfItems objectAtIndex:[pickerView selectedRowInComponent:0]];
            int selectedIndex = (int)[self.arrRecords indexOfObject:strSelectedValue];
            
            if (self.delegate && [self.delegate respondsToSelector:@selector(selectedRow:withString:)]) {
                [self.delegate selectedRow:selectedIndex withString:strSelectedValue];
            }
            
        }else{
            
            if (self.delegate && [self.delegate respondsToSelector:@selector(selectedRow:withString:)]) {
                [self.delegate selectedRow:-1 withString:@"选择学校"];
            }
        }
        
    }else{
        
        strSelectedValue = [arrRecords objectAtIndex:[pickerView selectedRowInComponent:0]];
        int selectedIndex = (int)[self.arrRecords indexOfObject:strSelectedValue];
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(selectedRow:withString:)]) {
            [self.delegate selectedRow:selectedIndex withString:strSelectedValue];
        }
    }
    
    [self removeFromSuperview];

}

// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    if (searching) {
        return copyListOfItems.count;
    }else{
        return self.arrRecords.count;
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    if (searching) {
        return [copyListOfItems objectAtIndex:row];
    }else{
        return [self.arrRecords objectAtIndex:row];
    }
    
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
           
}

 - (void)setSearchTextFieldBackgroundColor:(UIColor *)backgroundColor
{
        UIView *searchTextField = nil;
//        if (IsiOS7OrLater) {
//                // 经测试, 需要设置barTintColor后, 才能拿到UISearchBarTextField对象
                txtSearch.barTintColor = [UIColor whiteColor];
                searchTextField = [[[txtSearch.subviews firstObject] subviews] lastObject];
//            } else { // iOS6以下版本searchBar内部子视图的结构不一样
//                    for (UIView *subView in txtSearch.subviews) {
//                             if ([subView isKindOfClass:NSClassFromString(@"UISearchBarTextFieldBackGroundView")]) {
//                                     searchTextField = subView;
//                                 }
//                         }
//                 }
    
         searchTextField.backgroundColor = backgroundColor;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    [self endEditing:YES];
}

- (void)layoutSubviews{

    picketToolbar.frame = CGRectMake(0, CGRectGetMaxY(self.frame) - 244, SCREEN_WIDTH, 44);
    
    pickerView.frame = CGRectMake(0.0, CGRectGetMaxY(picketToolbar.frame), SCREEN_WIDTH, 200);
}
@end
