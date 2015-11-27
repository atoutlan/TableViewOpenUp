//
//  HeaderView.m
//  TableView展开
//
//  Created by 咖啡邦-2 on 15/11/27.
//  Copyright © 2015年 Kafeibang. All rights reserved.
//

#import "HeaderView.h"

@implementation HeaderView

/** 重写init方法 */
- (instancetype)init {
    self = [super init];
    if (self) {
        self.isOpen = NO;
        self = [[[NSBundle mainBundle] loadNibNamed:@"HeaderView" owner:self options:nil] objectAtIndex:0];
        [self.headerButton addTarget:self action:@selector(doSelected) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

/** Button点击事件，执行代理方法 */
-(void)doSelected {
    if (_delegate && [_delegate respondsToSelector:@selector(didSelectedWith:)]) {
        [_delegate didSelectedWith:self];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
