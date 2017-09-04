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
//  ABPeoplePickerNavigationController+XQUtils.m
//  XQKit
//
//  Created by quanxiong on 2017/8/29.
//  Copyright © 2017年 xun.quan. All rights reserved.
//

#import "ABPeoplePickerNavigationController+XQUtils.h"
#import <objc/runtime.h>
#import <XQKit/XQKit.h>

#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wdeprecated-declarations"

static const int block_key;
static const int target_key;

#pragma mark - Delegate

@interface xqABPeoplePickerNavigationControllerDelegate : NSObject <ABPeoplePickerNavigationControllerDelegate>

@property (nonatomic, copy) XQPeoplePickerBlock delegateBlock;
@end

@implementation xqABPeoplePickerNavigationControllerDelegate

- (void)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker didSelectPerson:(ABRecordRef)person
{
    if (self.delegateBlock) {
        //获取联系人姓名
        CFStringRef nameRef = ABRecordCopyCompositeName(person);
        NSString *name = [(__bridge NSString *)nameRef copy];
        XQCFRelease(nameRef);
        
        //获取联系人电话
        ABMutableMultiValueRef phoneMulti = ABRecordCopyValue(person, kABPersonPhoneProperty);
        NSMutableArray<NSString *> *phones = [NSMutableArray array];
        for (CFIndex idx = 0; idx < ABMultiValueGetCount(phoneMulti); ++idx) {
            CFTypeRef phoneRef = ABMultiValueCopyValueAtIndex(phoneMulti, idx);
            NSString *aPhone = [(__bridge NSString *)phoneRef copy];
            CFStringRef labelRef = ABMultiValueCopyLabelAtIndex(phoneMulti, idx);
#if DEBUG
            NSString *aLabel = [(__bridge NSString *)labelRef copy];
            XQLog(@"--> PhoneLabel:%@ Phone:%@", aLabel, aPhone);
#endif
            if(aPhone.length > 0) {
                [phones addObject:aPhone];
            }
            XQCFRelease(phoneRef);
            XQCFRelease(labelRef);
        }
        XQCFRelease(phoneMulti);
        self.delegateBlock(peoplePicker, @{@"name":name,
                                           @"phones":phones});
    }
}

@end


@implementation ABPeoplePickerNavigationController (XQUtils)

- (xqABPeoplePickerNavigationControllerDelegate *)_xq_delegate {
    xqABPeoplePickerNavigationControllerDelegate *delegate = objc_getAssociatedObject(self, &target_key);
    if (!delegate) {
        delegate = [xqABPeoplePickerNavigationControllerDelegate new];
        objc_setAssociatedObject(self, &target_key, delegate, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return delegate;
}

- (void)setXqPickerDidSelectPersonBlock:(XQPeoplePickerBlock)block {
    objc_setAssociatedObject(self, &block_key, block, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    self.peoplePickerDelegate = [self _xq_delegate];
    [self _xq_delegate].delegateBlock = block;
}

- (XQPeoplePickerBlock)xqPickerDidSelectPersonBlock {
    return objc_getAssociatedObject(self, &block_key);
}

@end

#pragma clang diagnostic pop
