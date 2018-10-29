//
//  SYRootViewController.m
//  SYStickHeaderWaterFall
//
//  Created by Mac on 16/3/21.
//  Copyright © 2016年 suya. All rights reserved.
//

#import "SYRootViewController.h"
#import "MulitipleSectionViewController.h"
@interface SYRootViewController ()
@property (nonatomic, strong) NSMutableArray *titles;
@property (nonatomic, strong) NSMutableArray *classNames;
@end

@implementation SYRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"SYStickHeaderWaterFall Example";
    self.titles = @[].mutableCopy;
    self.classNames = @[].mutableCopy;
    [self addCell:@"NoHeaderNoFooter" class:@"NoHeaderNoFooterViewController"];
    [self addCell:@"一个section不带top和bottom（仿模咖首页）" class:@"HomeThreeViewController"];
    [self addCell:@"两个section带top和bottom" class:@"MulitipleSectionViewController"];
    [self addCell:@"多个section停留位置不加top距离" class:@"MulitipleSectionNoTopHeightViewController"];
    [self addCell:@"任意设置header停留位置" class:@"MulitipleSectionHeaderToTopViewController"];
    [self addCell:@"header和footer停留" class:@"MulitipleSectionHeaderFooterViewController"];
    [self.tableView reloadData];

    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)addCell:(NSString *)title class:(NSString *)className {
    [self.titles addObject:title];
    [self.classNames addObject:className];
    
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _titles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YY"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YY"];
    }
    cell.textLabel.text = _titles[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *className = self.classNames[indexPath.row];
    Class class = NSClassFromString(className);
    if (class) {
        UIViewController *ctrl = class.new;
        ctrl.title = _titles[indexPath.row];
        [self.navigationController pushViewController:ctrl animated:YES];
    }
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}



@end
