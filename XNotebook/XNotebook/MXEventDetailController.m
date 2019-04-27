//
//  MXPaperDetailViewController.m
//  MXNotebook
//
//  Created by yellow on 2017/8/2.
//  Copyright © 2017年 yellow. All rights reserved.
//

#import "MXEventDetailController.h"
#import "MXPaper.h"
#import "MXTopic.h"
#import "MXRealmManager.h"
#import "EventDetailViewCell.h"
#import "MXPhotoController.h"
#import "MXAlert.h"
#import <objc/runtime.h>

@interface MXEventDetailController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,EventDetailViewCellDelegate>
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) UIView *buttonView;
@property (assign, nonatomic) BOOL popMark;
@property (strong, nonatomic) UIView *tableViewBackgroundView;
// 记事本具体内容
@property (strong, nonatomic)UITextView *editDetailTextField;
@end

@implementation MXEventDetailController

- (instancetype)init {
    if (self = [super init]) {
        self.hideNavBar = YES;
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:NO];
             self.editDetailTextField.text = self.paper.Text;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.barStyle = @"Default";
    [self.view addSubview:self.tableView];
    NSLog(@"10086");
    if (!_editDetailTextField) {
        NSLog(@"%@ 1", self.paper.Text);
        _editDetailTextField = [[UITextView alloc]initWithFrame:CGRectMake(10, 70, [UIScreen mainScreen].bounds.size.width - 20, [UIScreen mainScreen].bounds.size.height - (110))];
        _editDetailTextField.backgroundColor = [UIColor colorWithRed:200 / 255.0 green:244 / 255.0 blue:211 / 255.0 alpha:1];
    }
    [self.view addSubview:_editDetailTextField];
    UIButton *editBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [editBtn setFrame:CGRectMake(240, 40, 70, 25)];
    [editBtn addTarget:self action:@selector(AddPhoto) forControlEvents:UIControlEventTouchUpInside];
    [editBtn setTitle:@"图片" forState:UIControlStateNormal];
    [self.view addSubview:editBtn];
}

- (void)save {
    [self.view endEditing:YES];
    if (self.type == PaperAdd) {
     [[NSNotificationCenter defaultCenter] postNotificationName:@"NewPaper" object:nil];
     MXPaper *paper = [[MXPaper alloc]init];
     paper.topicID = self.paper.topicID;
     paper.name = self.paper.name;
     paper.date = self.paper.date;
     paper.Text = self.editDetailTextField.text;
     paper.filePath=self.newfilePath;
        
        NSLog(@"%@", paper.name);
        NSLog(@"%@", paper.Text);
     [MXRealmManager update:^(RLMRealm *realm) {
     [self.topic.papers addObject:paper];
     }];
     
     [MXAlert hud:@"添加成功"];
     } else if (self.type == PaperUpdate) {
     [[NSNotificationCenter defaultCenter] postNotificationName:@"UpdatePaper" object:nil];
     [MXRealmManager update:^(RLMRealm *realm) {
     self.paper.Text = self.editDetailTextField.text;
     self.paper.filePath=self.newfilePath;
     }];
     [MXAlert hud:@"修改成功"];
     }
     [self.navigationController popViewControllerAnimated:YES];
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)AddPhoto{
    MXPaper *paper = [[MXPaper alloc]init];
    paper.topicID = self.paper.topicID;
    paper.name = self.paper.name;
    paper.date = self.paper.date;
    paper.Text = self.editDetailTextField.text;
    //NSLog(@"%@", self.newfilePath);
    paper.filePath =self.newfilePath;
    MXPhotoController *vc = [[MXPhotoController alloc]init];
    vc.type = self.type;
    vc.topic = self.topic;
    vc.paper = paper;
    vc.hideNavBar = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - ScrollView Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == self.tableView) {
        if (scrollView.contentOffset.y < -100) {
            self.popMark = YES;
        }
    }
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    if (self.popMark) {
        [self backAction];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [UIScreen mainScreen].bounds.size.height - (100);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    EventDetailViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.delegate = self;
    [cell setType:self.type Topic:self.topic andPaper:self.paper];
    return cell;
}

#pragma mark - Cell代理
- (void)textFieldFinishContent:(NSString *)content {
}


#pragma mark - Getter

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, [UIDevice statusBarHeight], [UIDevice deviceWidth], [UIDevice screenHeight]-[UIDevice statusBarHeight]) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerNib:[UINib nibWithNibName:@"EventDetailViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundView = self.tableViewBackgroundView;
        
        _tableView.tableFooterView = self.buttonView;
    }
    return _tableView;
}

- (UIView *)tableViewBackgroundView {
    if (!_tableViewBackgroundView) {
        _tableViewBackgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.tableView.backgroundView.bounds.size.width, self.tableView.backgroundView.bounds.size.height)];
        UILabel *label = [[UILabel alloc]init];
        label.backgroundColor = self.topic.topicColor;
        label.text = @"下拉V";
        label.numberOfLines = 0;
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor whiteColor];
        label.font = [UIFont systemFontOfSize:13];
        label.layer.cornerRadius = 5;
        label.layer.masksToBounds = YES;
        [_tableViewBackgroundView addSubview:label];
        
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(_tableViewBackgroundView);
            make.top.equalTo(_tableViewBackgroundView).offset(20);
            make.width.equalTo(@(20));
        }];
    }
    return _tableViewBackgroundView;
}

- (UIView *)buttonView {
    if (!_buttonView) {
        _buttonView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIDevice deviceWidth], 100)];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        if(self.type == PaperAdd)
        [button setTitle:@ "添加事件" forState:UIControlStateNormal];
        else
        [button setTitle:@ "修改事件" forState:UIControlStateNormal];
        button.backgroundColor = ThemeColor;
        button.titleLabel.textColor = [UIColor whiteColor];
        button.titleLabel.font = [UIFont systemFontOfSize:17];
        button.layer.cornerRadius = 5;
        button.layer.masksToBounds = YES;
        [button addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside];
        [_buttonView addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(_buttonView).insets(UIEdgeInsetsMake(30, 10, 25, 10));
        }];
    }
    return _buttonView;
}

@end
