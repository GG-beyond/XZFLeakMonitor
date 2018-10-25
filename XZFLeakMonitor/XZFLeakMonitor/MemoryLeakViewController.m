//
//  MemoryLeakViewController.m
//  XZFLeakMonitor
//
//  Created by 58 on 2018/10/24.
//  Copyright © 2018年 58. All rights reserved.
//

#import "MemoryLeakViewController.h"
#import "ZFLeakMonitorManager.h"
#import "FloatView.h"

@interface MemoryLeakViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *leakTableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@end

@implementation MemoryLeakViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self.view addSubview:self.leakTableView];
    self.title = @"内存泄漏的Controller";
    [[ZFLeakMonitorManager sharedInstance] addObserver:self forKeyPath:@"leakViewControllersArr" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    
    self.dataSource = [[ZFLeakMonitorManager sharedInstance] getItems];
    [self.leakTableView reloadData];
}
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *indentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentifier];
    }
    cell.textLabel.text = [self.dataSource[indexPath.row] description];
    return cell;
}
#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 60.0f;
}
#pragma mark - Setter && Getter
- (UITableView *)leakTableView{
    
    if (!_leakTableView) {
        
        _leakTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _leakTableView.dataSource = self;
        _leakTableView.delegate = self;
    }
    return _leakTableView;
}
- (NSMutableArray *)dataSource{
    
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
        [_dataSource addObjectsFromArray:[[ZFLeakMonitorManager sharedInstance] getItems]];
    }
    return _dataSource;
}
- (void)dealloc{
    
    [[FloatView instance] reShow];
    [[ZFLeakMonitorManager sharedInstance] removeObserver:self forKeyPath:@"leakViewControllersArr"];
}

@end
