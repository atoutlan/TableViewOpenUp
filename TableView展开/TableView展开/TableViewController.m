//
//  TableViewController.m
//  TableView展开
//
//  Created by 咖啡邦-2 on 15/11/27.
//  Copyright © 2015年 Kafeibang. All rights reserved.
//

#import "TableViewController.h"
#import "HeaderView.h"

@interface TableViewController () <HeaderViewDelegate>

/** 存放HeaderView的数组 */
@property(nonatomic, retain) NSMutableArray* headerViewArray;
/** 当前分组 */
@property(nonatomic, assign) NSInteger currentSection;
/** 当前cell */
@property(nonatomic, assign) NSInteger currentRow;

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 注册cell
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    // 加载HeaderView
    [self loadHeaderView];
}

// 加载HeaderView
- (void)loadHeaderView {
    for (int i = 0; i < 5; i++) {
        self.currentRow = -1;
        HeaderView *headerView = [[HeaderView alloc] init];
        headerView.frame = CGRectMake(0, 0, 200, 40);
        headerView.delegate = self;
        [headerView.headerButton setTitle:[NSString stringWithFormat:@"第%d个分组", i] forState:UIControlStateNormal];
        headerView.section = i;
        [self.headerViewArray addObject:headerView];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return self.headerViewArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    HeaderView *view = [self.headerViewArray objectAtIndex:section];
    return view.isOpen ? 1 : 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%ld-%ld",indexPath.section,indexPath.row];
    self.currentSection = indexPath.section;
    
    HeaderView *view = [self.headerViewArray objectAtIndex:indexPath.section];
    if (view.isOpen) {
        if (indexPath.row == self.currentRow) {
            NSLog(@"没事");
        }
    }
    
    return cell;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    return [self.headerViewArray objectAtIndex:section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 80;
}

#pragma mark - 懒加载
- (NSMutableArray *)headerViewArray {
    if (!_headerViewArray) {
        self.headerViewArray = [NSMutableArray new];
    }
    return _headerViewArray;
}


#pragma mark - HeadViewdelegate
- (void)didSelectedWith:(HeaderView *)view {
    self.currentRow = -1;
    if (view.isOpen) {

        for (int i = 0; i < self.headerViewArray.count; i++) {
            HeaderView *head = [self.headerViewArray objectAtIndex:i];
            head.isOpen = NO;
        }
        
        [self.tableView reloadData];
        return;
    }
    self.currentSection = view.section;
    [self reset];
    
}

//界面重置
- (void)reset
{
    
    for (int i = 0; i < [self.headerViewArray count]; i++) {
        HeaderView *head = [self.headerViewArray objectAtIndex:i];
        if(head.section == self.currentSection) {
            head.isOpen = YES;
            
        } else {
            
            head.isOpen = NO;
        }
    }
    
    [self.tableView reloadData];
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
