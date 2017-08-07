//
//  XQPopupControllerBase.h
//  xunquan_kit
//
//  Created by xiongxunquan on 16/10/11.
//  Copyright © 2016年 xunquan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XQPopupControllerBase;

@protocol XQPopupControllerDelegate <NSObject>

- (void)controllerWillPopup:(XQPopupControllerBase *)controller;
- (void)controllerDidPopup:(XQPopupControllerBase *)controller;
- (void)controllerWillExit:(XQPopupControllerBase *)controller;
- (void)controllerDidExit:(XQPopupControllerBase *)controller;

@end

@interface XQPopupControllerBase : UIViewController

@property (strong, nonatomic, readonly) UIView *coreView;
@property (assign, nonatomic, readonly) BOOL onbusy;
@property (weak, nonatomic) id<XQPopupControllerDelegate> delegate;

#pragma mark - override
- (CGFloat)coreViewHeight;
- (void)configSubviews __attribute__((objc_requires_super));
- (void)setupSubViews __attribute__((objc_requires_super));

- (void)animatedExit;

@end
