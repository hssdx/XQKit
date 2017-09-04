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
//  CNContactPickerViewController+XQUtils.h
//  XQKit
//
//  Created by quanxiong on 2017/9/4.
//  Copyright © 2017年 com.hssdx. All rights reserved.
//
#import <ContactsUI/ContactsUI.h>

typedef void (^XQCNPickerDidCancelBlock)(CNContactPickerViewController *picker);
typedef void (^XQCNPickerDidSelectContactBlock)(CNContactPickerViewController *picker, CNContact *contact);
typedef void (^XQCNPickerDidSelectContactPropBlock)(CNContactPickerViewController *picker, CNContactProperty *prop);
typedef void (^XQCNPickerDidSelectContactsPropBlock)(CNContactPickerViewController *picker, NSArray<CNContact *> *contacts);
typedef void (^XQCNPickerDidSelectContactPropsBlock)(CNContactPickerViewController *picker, NSArray<CNContactProperty *> *props);

@interface CNContactPickerViewController (XQUtils)

/* If you use this properties, you can not use `delegate` again 
 */
@property (nonatomic, copy) XQCNPickerDidCancelBlock xqDidCancelBlock;
@property (nonatomic, copy) XQCNPickerDidSelectContactBlock xqDidSelectContactBlock;
@property (nonatomic, copy) XQCNPickerDidSelectContactPropBlock xqDidSelectContactPropBlock;
@property (nonatomic, copy) XQCNPickerDidSelectContactsPropBlock xqDidSelectContactsBlock;
@property (nonatomic, copy) XQCNPickerDidSelectContactPropsBlock xqDidSelectContactPropsBlock;

@end
