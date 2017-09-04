/* 
MIT License

Copyright (c) 2017 xunquan

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
 */
//
//  CNContactPickerViewController+XQUtils.m
//  XQKit
//
//  Created by quanxiong on 2017/9/4.
//  Copyright © 2017年 com.hssdx. All rights reserved.
//

#import "CNContactPickerViewController+XQUtils.h"
#import <objc/runtime.h>

static const int target_key;

#pragma mark - Delegate

@interface xqContactPickerNavigationControllerDelegate : NSObject <CNContactPickerDelegate>
@property (nonatomic, copy) XQCNPickerDidCancelBlock didCancelBlock;
@property (nonatomic, copy) XQCNPickerDidSelectContactBlock didSelectContactBlock;
@property (nonatomic, copy) XQCNPickerDidSelectContactPropBlock didSelectContactPropBlock;
@property (nonatomic, copy) XQCNPickerDidSelectContactsPropBlock didSelectContactsBlock;
@property (nonatomic, copy) XQCNPickerDidSelectContactPropsBlock didSelectContactPropsBlock;
@end

@implementation xqContactPickerNavigationControllerDelegate

- (void)contactPickerDidCancel:(CNContactPickerViewController *)picker
{
    if (self.didCancelBlock) {
        self.didCancelBlock(picker);
    }
}

- (void)contactPicker:(CNContactPickerViewController *)picker didSelectContact:(CNContact *)contact
{
    if (self.didSelectContactBlock) {
        self.didSelectContactBlock(picker, contact);
    }
}

- (void)contactPicker:(CNContactPickerViewController *)picker didSelectContactProperty:(CNContactProperty *)contactProperty
{
    if (self.didSelectContactPropBlock) {
        self.didSelectContactPropBlock(picker, contactProperty);
    }
}

- (void)contactPicker:(CNContactPickerViewController *)picker didSelectContacts:(NSArray<CNContact*> *)contacts
{
    if (self.didSelectContactsBlock) {
        self.didSelectContactsBlock(picker, contacts);
    }
}

- (void)contactPicker:(CNContactPickerViewController *)picker didSelectContactProperties:(NSArray<CNContactProperty*> *)contactProperties
{
    if (self.didSelectContactPropsBlock) {
        self.didSelectContactPropsBlock(picker, contactProperties);
    }
}

@end

@implementation CNContactPickerViewController (XQUtils)

@dynamic xqDidCancelBlock, xqDidSelectContactBlock, xqDidSelectContactPropBlock, xqDidSelectContactsBlock, xqDidSelectContactPropsBlock;

- (xqContactPickerNavigationControllerDelegate *)_xq_delegate {
    xqContactPickerNavigationControllerDelegate *delegate = objc_getAssociatedObject(self, &target_key);
    if (!delegate) {
        delegate = [xqContactPickerNavigationControllerDelegate new];
        objc_setAssociatedObject(self, &target_key, delegate, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        self.delegate = delegate;
    }
    return delegate;
}

- (void)setXqDidCancelBlock:(XQCNPickerDidCancelBlock)block {
    [self _xq_delegate].didCancelBlock = block;
}

- (void)setXqDidSelectContactBlock:(XQCNPickerDidSelectContactBlock)block {
    [self _xq_delegate].didSelectContactBlock = block;
}

- (void)setXqDidSelectContactPropBlock:(XQCNPickerDidSelectContactPropBlock)block {
    [self _xq_delegate].didSelectContactPropBlock = block;
}

- (void)setXqDidSelectContactsBlock:(XQCNPickerDidSelectContactsPropBlock)block {
    [self _xq_delegate].didSelectContactsBlock = block;
}

- (void)setXqDidSelectContactPropsBlock:(XQCNPickerDidSelectContactPropsBlock)block {
    [self _xq_delegate].didSelectContactPropsBlock = block;
}

@end
