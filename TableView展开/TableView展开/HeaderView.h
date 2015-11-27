//
//  HeaderView.h
//  TableView展开
//
//  Created by 咖啡邦-2 on 15/11/27.
//  Copyright © 2015年 Kafeibang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HeaderView;

/** 协议 */
@protocol HeaderViewDelegate <NSObject>

/**
 *  协议方法
 *
 *  @param view 选中的Section头部View
 */
- (void)didSelectedWith:(HeaderView *)view;

@end

@interface HeaderView : UIView

/** 头部Button */
@property (strong, nonatomic) IBOutlet UIButton *headerButton;
/** 设置代理 */
@property(nonatomic, assign) id<HeaderViewDelegate> delegate;
/** 当前section */
@property(nonatomic, assign) NSInteger section;
/** 是否展开 */
@property(nonatomic, assign) BOOL isOpen;

@end
