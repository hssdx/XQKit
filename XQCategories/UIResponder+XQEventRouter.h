//
//  UIResponder+XQEventRouter.h
//  IKSarahah
//
//  Created by quanxiong on 2017/8/3.
//  Copyright © 2017年 com.inke. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIResponder (XQEventRouter)

- (void)routEvent:(NSString *)eventName;
- (void)routEvent:(NSString *)eventName info:(NSDictionary *)info;
- (void)routEvent:(NSString *)eventName info:(NSDictionary *)info sender:(id)sender;

@end
