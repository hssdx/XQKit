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
//  XQUtilities.m
//  XQ
//
//  Created by quanxiong on 16/6/8.
//  Copyright © 2016年 xunquan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XQUtilities.h"
#import <YYKit.h>

extern xq_force_inline void xq_dispatch_main_sync_safe(dispatch_block_t block) {
    if (!block) {
        return;
    }
    if ([NSThread isMainThread]) {
        block();
    } else {
        dispatch_sync(dispatch_get_main_queue(), block);
    }
}

extern xq_force_inline void xq_dispatch_main_async_safe(dispatch_block_t block) {
    if (!block) {
        return;
    }
    if ([NSThread isMainThread]) {
        block();
    } else {
        dispatch_async(dispatch_get_main_queue(), block);
    }
}

extern xq_force_inline void xq_dispatch_global_async_if_need(dispatch_block_t block) {
    if (!block) {
        return;
    }
    if ([NSThread isMainThread]) {
        dispatch_async(YYDispatchQueueGetForQOS(NSQualityOfServiceUtility), block);
    } else {
        block();
    }
}

extern xq_force_inline void xq_dispatch_global_then_dispatch_main_queue(dispatch_block_t global_block, dispatch_block_t main_block) {
    if (!global_block || !main_block) {
        return;
    }
    xq_dispatch_global_async_if_need(^{
        global_block();
        xq_dispatch_main_async_safe(main_block);
    });
}

#if 0
NSInteger xq_find_section_by_index_with_row_sum(NSArray<NSNumber *> *rowSumDatas, NSInteger index) {
    // 2 分法找出 section 所在的位置
    NSInteger iCount = index + 1;
    NSInteger start = 0;
    NSInteger end = rowSumDatas.count - 1;
    while (rowSumDatas[start].integerValue < iCount && start < end) {
        if (start == end - 1) {
            start = end;
            break;
        }
        NSInteger mid = (start + end) / 2;
        if (rowSumDatas[mid].integerValue < iCount) {
            start = mid;
        } else if (rowSumDatas[mid].integerValue > iCount) {
            end = mid;
        } else {
            start = mid;
            break;
        }
    }
    XQAssert(rowSumDatas[start].integerValue >= iCount
             && (start == 0 || rowSumDatas[start-1].integerValue < iCount));
    NSInteger section = start;
    return section;
}

extern xq_force_inline NSIndexPath *xq_index_path_by_index_with_row_sum(NSArray<NSNumber *> *rowSumDatas, NSInteger index) {
    if (rowSumDatas.count == 0) {
        XQAssert(false);
        return nil;
    }
    NSInteger section = xq_find_section_by_index_with_row_sum(rowSumDatas, index);
    NSInteger row = section == 0 ? index : (index - rowSumDatas[section-1].integerValue);
    return [NSIndexPath indexPathForRow:row inSection:section];
}

extern xq_force_inline NSInteger xq_index_by_index_path_with_row_sum(NSArray<NSNumber *> *rowSumDatas, NSIndexPath *indexPath) {
    if (rowSumDatas.count == 0) {
        XQAssert(false);
        return 0;
    }
    NSInteger index;
    if (indexPath.section < 1) {
        index = indexPath.row;
    } else {
        index = rowSumDatas[indexPath.section - 1].integerValue + indexPath.row;
    }
    return index;
}
extern xq_force_inline id xq_obj_for_class(id _id, Class cls) {
    if (nil == _id) {
        return nil;
    }
    XQAssert([_id isKindOfClass:cls]);
    if ([_id isKindOfClass:cls]) {
        return _id;
    }
    return nil;
}
#endif

