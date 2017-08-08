//
//  XQShareController.m
//  IKSarahah
//
//  Created by quanxiong on 2017/7/30.
//  Copyright © 2017年 com.xq. All rights reserved.
//

#import "XQShareController.h"
#import "XQGridlineView.h"
#import "UIColor+XQUtils.h"
#import "UIView+XQUtils.h"
#import <Masonry.h>
#import <YYKit.h>

static const CGFloat kTitleHeight = 40;

@implementation WXShareAction

+ (instancetype)actionWithTitle:(NSString *)title
                           icon:(NSString *)icon
                         handle:(void(^)(UIView *action))handle {
    WXShareAction *action = [WXShareAction new];
    action.title = title;
    action.icon = icon;
    action.handle = handle;
    return action;
}

@end


@interface WXShareItemView : UIView

@property (strong, nonatomic) UIButton *button;
@property (strong, nonatomic) UILabel *label;
@property (copy, nonatomic) void(^handle)(UIView *actionView);

@end

@implementation WXShareItemView

- (instancetype)init {
    if (self = [super init]) {
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        _label = [UILabel new];
        [self addSubview:_button];
        [self addSubview:_label];
        
        [_button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.centerY.equalTo(self).offset(-10);
            make.size.equalTo(@40);
        }];
        [_label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.top.equalTo(_button.mas_bottom).offset(0);
            make.width.equalTo(self).offset(-8);
        }];
        _label.font = [UIFont boldSystemFontOfSize:12];
        _label.textColor = [UIColor lightGrayColor];
        _label.textAlignment = NSTextAlignmentCenter;
        _label.text = @"item";
        [_button setImage:[UIImage imageNamed:@"wechat"] forState:UIControlStateNormal];
        
        @weakify(self);
        [_button setBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
            @strongify(self);
            if (self.handle) {
                self.handle(self);
            }
        }];
    }
    return self;
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    if ([self pointInside:point withEvent:event]) {
        return _button;
    }
    return [super hitTest:point withEvent:event];
}

@end

@interface XQShareController ()

@property (copy, nonatomic) NSString *topic;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) XQGridlineView *gridlineView;
@property (strong, nonatomic) NSMutableArray<WXShareAction *> *actions;
@property (strong, nonatomic) NSMutableArray<WXShareItemView *> *itemViews;

@end

@implementation XQShareController

+ (instancetype)controllerWithTopic:(NSString *)topic {
    XQShareController *controller = [XQShareController new];
    controller.topic = topic;
    return controller;
}

- (NSMutableArray<WXShareAction *> *)actions {
    if (!_actions) {
        _actions = [NSMutableArray array];
    }
    return _actions;
}

- (NSMutableArray<WXShareItemView *> *)itemViews {
    if (!_itemViews) {
        _itemViews = [NSMutableArray array];
    }
    return _itemViews;
}

- (void)addAction:(WXShareAction *)action {
    [self.actions addObject:action];
}

- (void)configSubviews {
    [super configSubviews];
    
    _titleLabel.font = [UIFont boldSystemFontOfSize:17];
    _titleLabel.textColor = [UIColor xqThemeTextColor];
    if (self.topic.length) {
        _titleLabel.text = self.topic;
    } else {
        _titleLabel.text = @"分享到";
    }
    _titleLabel.textAlignment = NSTextAlignmentCenter;
}

- (void)setupSubViews {
    [super setupSubViews];
    
    _titleLabel = [UILabel new];
    _gridlineView = [XQGridlineView new];
    
    [self.actions enumerateObjectsUsingBlock:^(WXShareAction * action, NSUInteger idx, BOOL * stop) {
        WXShareItemView *itemView = [WXShareItemView new];
        itemView.label.text = action.title;
        [itemView.button setImage:[UIImage imageNamed:action.icon] forState:UIControlStateNormal];
        itemView.handle = action.handle;
        [self.itemViews addObject:itemView];
        [self.coreView addSubview:itemView];
    }];
    
    [self.coreView addSubview:_titleLabel];
    [self.coreView addSubview:_gridlineView];
    
    [_gridlineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.coreView);
    }];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.coreView);
        make.height.equalTo(@(kTitleHeight));
    }];
    switch (self.itemViews.count) {
        case 1:
        {
            [self.itemViews[0] mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.bottom.equalTo(self.coreView);
                make.top.equalTo(_titleLabel.mas_bottom);
            }];
        }
            break;
        case 2:
        {
            [self.itemViews[0] mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(_titleLabel.mas_bottom);
                make.bottom.equalTo(self.coreView);
                make.left.equalTo(self.coreView);
            }];
            [self.itemViews[1] mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.itemViews[0]);
                make.bottom.equalTo(self.itemViews[0]);
                make.left.equalTo(self.itemViews[0].mas_right);
                make.right.equalTo(self.coreView); //!!
                make.width.equalTo(self.itemViews[0]); //!!
            }];
        }
            break;
        case 3:
        {
            [self.itemViews[0] mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(_titleLabel.mas_bottom);
                make.bottom.equalTo(self.coreView);
                make.left.equalTo(self.coreView);
            }];
            [self.itemViews[1] mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.itemViews[0]);
                make.bottom.equalTo(self.itemViews[0]);
                make.left.equalTo(self.itemViews[0].mas_right);
                make.width.equalTo(self.itemViews[0]);
            }];
            [self.itemViews[2] mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.itemViews[0]);
                make.bottom.equalTo(self.itemViews[0]);
                make.left.equalTo(self.itemViews[1].mas_right);
                make.right.equalTo(self.coreView);
                make.width.equalTo(self.itemViews[0]);
            }];
        }
            break;
        case 4:
        {
            [self.itemViews[0] mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(_titleLabel.mas_bottom);
                make.left.equalTo(self.coreView);
            }];
            [self.itemViews[1] mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.itemViews[0]);
                make.bottom.equalTo(self.itemViews[0]);
                make.right.equalTo(self.coreView);
                make.left.equalTo(self.itemViews[0].mas_right);
                make.width.equalTo(self.itemViews[0]);
            }];
            [self.itemViews[2] mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.itemViews[0].mas_bottom);
                make.bottom.equalTo(self.coreView);
                make.left.equalTo(self.itemViews[0]);
                make.right.equalTo(self.itemViews[0]);
                make.height.equalTo(self.itemViews[0]); //!!
            }];
            [self.itemViews[3] mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.itemViews[2]);
                make.bottom.equalTo(self.itemViews[2]);
                make.left.equalTo(self.itemViews[1]);
                make.right.equalTo(self.itemViews[1]);
            }];
        }
            break;
        default:
            break;
    }
}

- (CGFloat)coreViewHeight {
    return 140;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    [_gridlineView clearPaths];
    [_gridlineView moveTo:CGPointMake(self.coreView.left, kTitleHeight)
                   lineTo:CGPointMake(self.coreView.right, kTitleHeight)];
}

@end
