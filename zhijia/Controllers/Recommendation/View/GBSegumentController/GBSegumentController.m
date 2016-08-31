//
//  GBSegumentController.m
//  zhijia
//
//  Created by 童星 on 16/6/7.
//  Copyright © 2016年 Beijing tongxing Technology Development Co., Ltd. All rights reserved.
//
#define RGBA(r,g,b,a) ([UIColor colorWithRed:r/255 green:g/255 blue:b/255 alpha:a])
#define RGB(r,g,b)    RGBA(r,g,b,1)

#define kDefaultTintColor       RGB(3, 116, 255)
#define KDefaultCornerRadius    3.f
#define kLeftRightMargin        0
#define kItemHeight             30
#define kBorderLineWidth        0
#define kTitleSize              ([UIFont systemFontOfSize:18])

#import "GBSegumentController.h"

@class GBSegmentItem;
;
@protocol GBSegmentItemDelegate

- (void)ItemStateChanged:(GBSegmentItem *)item index:(NSInteger)index isSelected:(BOOL)isSelected;
@end

@interface GBSegmentItem : UIView

@property (nonatomic, strong) UIColor   *norColor;
@property (nonatomic, strong) UIColor   *selColor;
@property (nonatomic, strong) UILabel   *titleLabel;
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, assign) BOOL      isSelected;
@property (nonatomic, assign) id        delegate;


@end



@implementation GBSegmentItem

- (id)initWithFrame:(CGRect)frame
              index:(NSInteger)index
              title:(NSString *)title
           norColor:(UIColor *)norColor
           selColor:(UIColor *)selColor
         isSelected:(BOOL)isSelected;
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        _titleLabel.textAlignment   = NSTextAlignmentCenter;
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.font            = kTitleSize;
        [self addSubview:_titleLabel];
        
        _norColor        = norColor;
        _selColor        = selColor;
        _titleLabel.text = title;
        _index           = index;
        _isSelected      = isSelected;
    }
    return self;
}

- (void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    
    self.titleLabel.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
}

- (void)setSelColor:(UIColor *)selColor
{
    if (_selColor != selColor) {
        _selColor = selColor;
        
        if (_isSelected) {
            self.titleLabel.textColor = self.norColor;
//            self.backgroundColor      = self.selColor;
        }else{
            self.titleLabel.textColor = self.selColor;
//            self.backgroundColor      = self.norColor;
        }
        
    }
}

- (void)setIsSelected:(BOOL)isSelected
{
    _isSelected = isSelected;
    
    if (_isSelected) {
        self.titleLabel.textColor = self.norColor;
//        self.backgroundColor      = self.selColor;
    }else{
        self.titleLabel.textColor = self.selColor;
//        self.backgroundColor      = self.norColor;
    }
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    self.isSelected = !_isSelected;
    
    if (_delegate) {
        [_delegate ItemStateChanged:self index:self.index isSelected:self.isSelected];
    }
}

@end

@interface GBSegumentController()

@property (nonatomic, strong) UIView         *bgView;
@property (nonatomic, strong) NSMutableArray *items;
@property (nonatomic, strong) NSMutableArray *lines;
@property (nonatomic,assign) NSInteger currentPage;


@end

@implementation GBSegumentController

- (instancetype)initWithFrame:(CGRect)frame items:(NSArray<NSString *> * _Nonnull)items
{
    self = [super initWithFrame:frame];
    if (self) {
        
        NSAssert(items.count >= 2, @"items's cout at least 2!please check!");
        _titles              = items;
        _selectedIndex       = 0;
        self.backgroundColor = [UIColor clearColor];

        
        CGFloat viewWidth     = CGRectGetWidth(self.frame);
        CGFloat viewHeight    = CGRectGetHeight(self.frame);
        
        NSInteger count         = self.titles.count;
        CGFloat itemY       = (viewHeight - self.itemHeight? self.itemHeight:kItemHeight)/2;
        CGFloat leftRightMargin = self.leftRightMargin?self.leftRightMargin:kLeftRightMargin;
        
        //configure bgView
        
        _bgView = [[UIView alloc] initWithFrame:CGRectMake(leftRightMargin, itemY, viewWidth - 2*leftRightMargin, self.itemHeight? self.itemHeight:kItemHeight)];
        _bgView.backgroundColor    = [UIColor whiteColor];
        _bgView.clipsToBounds      = YES;
        _bgView.layer.cornerRadius = KDefaultCornerRadius;
        _bgView.layer.borderWidth  = kBorderLineWidth;
        _bgView.layer.borderColor  = kDefaultTintColor.CGColor;
        
        [self addSubview:_bgView];
        
        CGFloat itemWidth = (viewWidth - 2*leftRightMargin)/count;
        for (NSInteger i = 0; i < count; i++) {
            GBSegmentItem *item = [[GBSegmentItem alloc] initWithFrame:CGRectMake(itemWidth*count, 0, itemWidth, CGRectGetHeight(_bgView.frame))
                                                                 index:i
                                                                 title:items[i]
                                                              norColor:[UIColor colorWithWhite:0.200 alpha:1.000]
                                                              selColor:[UIColor colorWithWhite:0.733 alpha:1.000]
                                                            isSelected:(i == 0)? YES: NO];
            item.tag = 3000+i;
            [_bgView addSubview:item];
            item.delegate = self;
            
            //save all items
            if (!self.items) {
                self.items = [[NSMutableArray alloc] initWithCapacity:count];
            }
            [_items addObject:item];
        }
        _currentPage = 3000;

        //add Ver lines
        for (NSInteger i = 0; i < count - 1; i++) {
            UIView *lineView = [[UIView alloc] initWithFrame:CGRectZero];
            lineView.backgroundColor = kDefaultTintColor;
            
            [_bgView addSubview:lineView];
            
            //save all lines
            if (!self.lines) {
                self.lines = [[NSMutableArray alloc] initWithCapacity:count];
            }
            [_lines addObject:lineView];
        }
        
    }
    
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat viewWidth     = CGRectGetWidth(self.frame);
    CGFloat viewHeight    = CGRectGetHeight(self.frame);
    __block CGFloat initX = 0;
    CGFloat initY         = 0;
    
    NSInteger count         = self.titles.count;
    CGFloat itemWidth       = CGRectGetWidth(self.bgView.frame)/count;
    CGFloat itemHeight      = CGRectGetHeight(self.bgView.frame);
    CGFloat leftRightMargin = self.leftRightMargin?self.leftRightMargin:kLeftRightMargin;
    
    //configure bgView
    self.bgView.frame = CGRectMake(leftRightMargin, (viewHeight - self.itemHeight?:kItemHeight)/2, viewWidth - 2*leftRightMargin, self.itemHeight?:kItemHeight);
    
    //configure items
    [self.items enumerateObjectsUsingBlock:^(GBSegmentItem * _Nonnull item, NSUInteger idx, BOOL * _Nonnull stop) {
        item.frame = CGRectMake(initX, initY, itemWidth, itemHeight);
        initX += itemWidth;
    }];
    
    initX = 0;
    //configure lines
    [self.lines enumerateObjectsUsingBlock:^(UIView *  _Nonnull lineView, NSUInteger idx, BOOL * _Nonnull stop) {
        initX += itemWidth;
        lineView.frame = CGRectMake(initX, 0, kBorderLineWidth, itemHeight);
    }];
    
}

- (void)setCornerRadius:(CGFloat)cornerRadius{
    
    NSAssert(cornerRadius > 0, @"cornerRadius must be above 0");
    
    _cornerRadius = cornerRadius;
    _bgView.layer.cornerRadius  = cornerRadius;
    
    [self setNeedsLayout];
}

- (void)setTintColor:(UIColor *)tintColor{
    
    if (_tintColor != tintColor) {
        _tintColor = tintColor;
        
        self.bgView.layer.borderColor  = tintColor.CGColor;
        
        for (NSInteger i = 0; i<self.items.count; i++) {
            GBSegmentItem *item = self.items[i];
//            item.selColor = tintColor;
        }
        
        for (NSInteger i = 0; i<self.lines.count; i++) {
            UIView *lineView = self.lines[i];
            lineView.backgroundColor = tintColor;
        }
        
        [self setNeedsLayout];
    }
}

- (void)setSelectedIndex:(NSUInteger)index
{
    _selectedIndex = index;
    
    if (index<self.items.count) {
        for (int i = 0; i<self.items.count; i++) {
            GBSegmentItem *item=self.items[i];
            
            if (i==index) {
                [item setIsSelected:YES];
            } else {
                [item setIsSelected:NO];
            }
        }
    }
}

#pragma mark - GBSegmentItemDelegate
- (void)ItemStateChanged:(GBSegmentItem *)currentItem index:(NSInteger)index isSelected:(BOOL)isSelected
{
    
    // diselect all items
    for (int i = 0; i < self.items.count; i++) {
        GBSegmentItem *item = self.items[i];
        item.isSelected = NO;
    }
    currentItem.isSelected = YES;
    
    // notify delegate
    if (_delegate && [_delegate respondsToSelector:@selector(segmentView:didSelectedIndex:)])
    {
        [_delegate segmentView:self didSelectedIndex:index];
    }
    
    // notify block handler
    if (_handlder) {
        _handlder(self, index);
    }
}

@end

