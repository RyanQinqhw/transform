//
//  ViewController.m
//  transform
//
//  Created by 秦宏伟 on 2018/3/14.
//  Copyright © 2018年 明镜止水. All rights reserved.
//

#import "ViewController.h"
#import "AffineTransformationViewController.h"
#import "3DViewController.h"
#import "SolidViewController.h"
static NSString *ID = @"CELL";
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

    @property (nonatomic, strong) UITableView *tableview;
    @property (nonatomic, strong) NSArray *dataArr;
    
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"首页";
    self.dataArr = @[@"仿射变换", @"3D变换", @"固体对象"];
    [self.view addSubview:self.tableview];
}
    
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
    
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}
    
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    cell.textLabel.text = self.dataArr[indexPath.row];
    
    return cell;
}
    
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *title = self.dataArr[indexPath.row];
    if(indexPath.row == 0){
        AffineTransformationViewController *affineVC = [AffineTransformationViewController new];
        affineVC.title = title;
        [self.navigationController pushViewController:affineVC animated:YES];
    }else if (indexPath.row == 1){
        _DViewController  *DVC = [_DViewController new];
        DVC.title = title;
        [self.navigationController pushViewController:DVC animated:YES];
    }else if (indexPath.row == 2){
        SolidViewController *solidVC = [SolidViewController new];
        solidVC.title = title;
        [self.navigationController pushViewController:solidVC animated:YES];
    }
}

-(UITableView *)tableview{
    if(!_tableview){
        _tableview = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.tableFooterView = [UIView new];
    }
    return _tableview;
}


@end
