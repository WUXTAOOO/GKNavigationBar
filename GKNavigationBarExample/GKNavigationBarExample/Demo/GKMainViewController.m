//
//  GKMainViewController.m
//  GKNavigationBar
//
//  Created by gaokun on 2019/11/1.
//  Copyright © 2019 QuintGao. All rights reserved.
//

#import "GKMainViewController.h"
#import "GKToutiaoViewController.h"
#import "GKWYMusicViewController.h"
#import "GKWYNewsViewController.h"
#import "GKDouyinHomeViewController.h"
#import "GKWXViewController.h"
#import "UINavigationController+GKGestureHandle.h"
#import "GKPresentViewController.h"

@interface GKMainViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *dataSource;

@end

@implementation GKMainViewController

- (NSArray *)dataSource {
    if (!_dataSource) {
        _dataSource = @[@"导航功能测试",
                        @"UIScrollView使用（手势冲突）",
                        @"TZImagePickerController使用",
                        @"系统导航",
                        @"UITableViewController",
                        @"WKWebView",
                        @"抖音左右滑动",
                        @"今日头条",
                        @"网易云音乐",
                        @"网易新闻",
                        @"微信(自定义push，pop)",
                        @"present非全屏"];
    }
    return _dataSource;
}

- (instancetype)init {
    if (self = [super init]) {
        self.gk_statusBarStyle = UIStatusBarStyleLightContent;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.gk_navigationItem.title = @"MainVC";
    self.gk_statusBarStyle = UIStatusBarStyleLightContent;
    self.gk_navTitleFont = [UIFont systemFontOfSize:18.0f];
    
    if (@available(iOS 13.0, *)) {
        self.gk_navTitleColor = [UIColor colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull traitCollection) {
            if (traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) {
                return UIColor.blackColor;
            }else {
                return UIColor.whiteColor;
            }
        }];
    }else {
        self.gk_navTitleColor = [UIColor whiteColor];
    }
    
    if (@available(iOS 13.0, *)) {
        self.gk_navBackgroundColor = [UIColor colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull traitCollection) {
            if (traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) {
                return UIColor.whiteColor;
            }else {
                return UIColor.redColor;
            }
        }];
    } else {
        // Fallback on earlier versions
        self.gk_navBackgroundColor = UIColor.redColor;
    }
    
    [self setupTableView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.tableView reloadData];
}

- (void)setupTableView {
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate   = self;
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    [self.view addSubview:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.gk_navigationBar.mas_bottom);
    }];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
}

- (BOOL)shouldAutorotate {
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAll;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    cell.textLabel.text = self.dataSource[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *className = [[NSString alloc] initWithFormat:@"GKDemo0%02zdViewController", indexPath.row];
    
    Class class = NSClassFromString(className);
    
    UIViewController *vc = [[class alloc] init];
    
    if (vc) {
        [self.navigationController pushViewController:vc animated:YES];
    }else {
        if (indexPath.row == 6) {
            UINavigationController *nav = [UINavigationController rootVC:[GKDouyinHomeViewController new]];
            nav.gk_openScrollLeftPush = YES;
            nav.modalPresentationStyle = UIModalPresentationFullScreen;
            [self presentViewController:nav animated:YES completion:nil];
        }else if (indexPath.row == 7) {
            GKToutiaoViewController *toutiaoVC = [GKToutiaoViewController new];
            toutiaoVC.modalPresentationStyle = UIModalPresentationFullScreen;
            [self presentViewController:toutiaoVC animated:YES completion:nil];
        }else if (indexPath.row == 8) {
            GKWYMusicViewController *musicVC = [GKWYMusicViewController new];
            musicVC.modalPresentationStyle = UIModalPresentationFullScreen;
            [self presentViewController:musicVC animated:YES completion:nil];
        }else if (indexPath.row == 9) {
            GKWYNewsViewController *newsVC = [GKWYNewsViewController new];
            newsVC.modalPresentationStyle = UIModalPresentationFullScreen;
            [self presentViewController:newsVC animated:YES completion:nil];
        }else if (indexPath.row == 10) {
            GKWXViewController *wxVC = [GKWXViewController new];
            wxVC.modalPresentationStyle = UIModalPresentationFullScreen;
            [self presentViewController:wxVC animated:YES completion:nil];
        }else if (indexPath.row == 11) {
            GKPresentViewController *presentVC = [GKPresentViewController new];
            presentVC.gk_navTitle = @"presentVC";
            
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:presentVC];
            
            [self presentViewController:nav animated:YES completion:nil];
        }
    }
}

@end
