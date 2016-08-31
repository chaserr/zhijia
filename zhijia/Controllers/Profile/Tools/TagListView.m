//
//  TagListView.m
//  TagObjc
//
//  Created by Javi Pulido on 16/7/15.
//  Copyright (c) 2015 Javi Pulido. All rights reserved.
//

#import "TagListView.h"
#import "TagView.h"
#import "UIView+Extension.h"
@interface TagListView ()

@property (nonatomic, strong) TagView *addTagBtn;
@property (nonatomic, strong) NSMutableArray *selectArray;
@end

@implementation TagListView

// Required by Interface Builder
#if TARGET_INTERFACE_BUILDER
-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];  
    return self;
}
#endif

- (NSMutableArray *)tagViews {
    if(!_tagViews) {
        [self setTagViews:[[NSMutableArray alloc] init]];
    }
    return _tagViews;
}

- (void)setTextColor:(UIColor *)textColor {
    _textColor = textColor;
    for(TagView *tagView in [self tagViews]) {
        [tagView setTextColor:textColor];
    }
}

- (void)setTagBackgroundColor:(UIColor *)tagBackgroundColor {
    _tagBackgroundColor = tagBackgroundColor;
    for(TagView *tagView in [self tagViews]) {
        [tagView setBackgroundColor:tagBackgroundColor];
    }
}

- (void)setCornerRadius:(CGFloat)cornerRadius {
    _cornerRadius = cornerRadius;
    for(TagView *tagView in [self tagViews]) {
        [tagView setCornerRadius:cornerRadius];
    }
}

- (void)setBorderWidth:(CGFloat)borderWidth {
    _borderWidth = borderWidth;
    for(TagView *tagView in [self tagViews]) {
        [tagView setBorderWidth:borderWidth];
    }
}

- (void)setBorderColor:(UIColor *)borderColor {
    _borderColor = borderColor;
    for(TagView *tagView in [self tagViews]) {
        [tagView setBorderColor:borderColor];
    }
}

- (void)setPaddingY:(CGFloat)paddingY {
    _paddingY = paddingY;
    for(TagView *tagView in [self tagViews]) {
        [tagView setPaddingY:paddingY];
    }
}

- (void)setPaddingX:(CGFloat)paddingX {
    _paddingX = paddingX;
    for(TagView *tagView in [self tagViews]) {
        [tagView setPaddingX:paddingX];
    }
}

- (void)setMarginY:(CGFloat)marginY {
    _marginY = marginY;
    [self rearrangeViews];
}

- (void)setMarginX:(CGFloat)marginX {
    _marginX = marginX;
    [self rearrangeViews];
}

- (void)setTextFont:(UIFont *)textFont{

    _textFont = textFont;
    [self rearrangeViews];
}

- (void)setRows:(int)rows {
    _rows = rows;
    [self invalidateIntrinsicContentSize];
}

- (void)setIsHasCustomTag:(BOOL)isHasCustomTag{

    _isHasCustomTag = isHasCustomTag;
    [self rearrangeViews];
}





# pragma mark - Interface builder

- (void)prepareForInterfaceBuilder {
    [self addTag:@"Thanks"];
    [self addTag:@"for"];
    [self addTag:@"using"];
    [self addTag:@"TagListView"];
    
}

# pragma mark - Layout

- (void)layoutSubviews {
    [super layoutSubviews];
    [self rearrangeViews];
}

- (void)rearrangeViews {
    for(TagView *tagView in [self tagViews]) {
        [tagView removeFromSuperview];
    }
    
    int currentRow = 0;
    int currentRowTagCount = 0;
    CGFloat currentRowWidth = 0;
    CGFloat oneTopMargin = 5;
    for(TagView *tagView in [self tagViews]) {
        tagView.textFont = _textFont;
        CGRect tagViewFrame = [tagView frame];
        tagViewFrame.size = [tagView intrinsicContentSize];
        [tagView setFrame:tagViewFrame];
        self.tagViewHeight = tagViewFrame.size.height;
        if (currentRowTagCount == 0 || (currentRowWidth + tagView.frame.size.width + [self marginX]) > self.frame.size.width) {
            currentRow += 1;
            CGRect tempFrame = [tagView frame];
            tempFrame.origin.x = 10;
            tempFrame.origin.y = (currentRow - 1) * ([self tagViewHeight] + [self marginY]) + oneTopMargin;
            [tagView setFrame:tempFrame];
            
            currentRowTagCount = 1;
            currentRowWidth = tagView.frame.size.width + [self marginX];
            
        }
        else {
            
            CGRect tempFrame = [tagView frame];
            tempFrame.origin.x = currentRowWidth + 10;
            tempFrame.origin.y = (currentRow - 1) * ([self tagViewHeight] + [self marginY]) + oneTopMargin;
            [tagView setFrame:tempFrame];
            
            currentRowTagCount += 1;
            currentRowWidth += tagView.frame.size.width + [self marginX];
        }
        if (_isHasCustomTag) {
            
            if ([tagView isEqual:[_tagViews lastObject]]) {
                // 如果是最后一个标签
                [tagView setTextColor: [self textColor]];
                [tagView setBackgroundColor: [UIColor clearColor]];
                [tagView setBackgroundImage:[UIImage imageNamed:@"customTag_bg"] forState:(UIControlStateNormal)];
                
            }
        }

        
        [self addSubview:tagView];
    }
    
    self.rows = currentRow;
}

# pragma mark - Manage tags

- (CGSize) intrinsicContentSize {
    CGFloat height = [self rows] * ([self tagViewHeight] + [self marginY]);
    if([self rows] > 0) {
        height -= [self marginY];
    }
    return CGSizeMake(self.frame.size.width, height);
}

- (TagView *)addTag:(NSString *)title {
    
    TagView *tagView = [[TagView alloc] initWithTitle:title];
    
    [tagView setTextColor: [self textColor]];
    [tagView setBackgroundColor: [self tagBackgroundColor]];
    [tagView setCornerRadius: [self cornerRadius]];
    [tagView setBorderWidth: [self borderWidth]];
    [tagView setBorderColor: [self borderColor]];
    [tagView setPaddingY: [self paddingY]];
    [tagView setPaddingX: [self paddingX]];
    [tagView setTextFont: [self textFont]];
    
    [tagView addTarget:self action:@selector(tagPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addTagView: tagView];
    
    return tagView;
}

- (void )addTagWithArray:(NSArray *)titleArray withHasCustomTag:(BOOL)isHasCustomTag{
    self.isHasCustomTag = isHasCustomTag;
    NSMutableArray *array = [NSMutableArray array];
    [titleArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        TagView *tagView = [[TagView alloc] initWithTitle:[titleArray objectAtIndex:idx]];
        [tagView setTextColor: [self textColor]];
        [tagView setBackgroundColor: [self tagBackgroundColor]];
        [tagView setCornerRadius: [self cornerRadius]];
        [tagView setBorderWidth: [self borderWidth]];
        [tagView setBorderColor: [self borderColor]];
        [tagView setPaddingY: [self paddingY]];
        [tagView setPaddingX: [self paddingX]];
        [tagView setTextFont: [self textFont]];
        
        [tagView addTarget:self action:@selector(tagPressed:) forControlEvents:UIControlEventTouchUpInside];
        
        [array addObject: tagView];
    }];
    
    [self.tagViews addObjectsFromArray:array];
    [self rearrangeViews];

    
}

- (void) addTagView:(TagView *)tagView {
    [[self tagViews] insertObject:tagView atIndex:[self.tagViews count] - 1];
    [self rearrangeViews];
}

- (void)removeTag:(NSString *)title {
    // Author's note: Loop the array in reversed order to remove items during loop
    for(int index = (int)[[self tagViews] count] - 1 ; index <= 0; index--) {
        TagView *tagView = [[self tagViews] objectAtIndex:index];
        if([[tagView currentTitle] isEqualToString:title]) {
            [tagView removeFromSuperview];
            [[self tagViews] removeObjectAtIndex:index];
        }
    }
}

- (void)removeAllTags {
    for(TagView *tagView in [self tagViews]) {
        [tagView removeFromSuperview];
    }
    [self setTagViews:[[NSMutableArray alloc] init]];
    [self rearrangeViews];
}

- (void)tagPressed:(TagView *)sender {
    if (sender.onTap) {
        sender.onTap(sender);
        
    }
}




- (NSMutableArray *)selectArray{
    
    if (_selectArray == nil) {
        _selectArray = [NSMutableArray array];
    }
    return  _selectArray;
}

@end
