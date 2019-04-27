//
//  MXPaperDetailViewController.m
//  MXNotebook
//
//  Created by yellow on 2017/8/2.
//  Copyright © 2017年 yellow. All rights reserved.
//

#import "MXPaper.h"
#import "MXTopic.h"
#import "MXRealmManager.h"
#import "MXAlert.h"
#import "MXPhotoController.h"
#import "MXEventDetailController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <objc/runtime.h>

@interface MXPhotoController ()<UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (strong, nonatomic)NSData *fileData;
@property (strong, nonatomic)UIImage *image;
/** 占位文字 */
@end

@implementation MXPhotoController

- (instancetype)init {
    if (self = [super init]) {
        self.hideNavBar = YES;
    }
    return self;
}
- (void)viewWillAppear:(BOOL)animated{
    if(self.fileData!=nil){
        self.image = [UIImage imageWithData:self.fileData];
    }
    
    UIImageView  *imageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 70, 320, 300)];
    imageView.backgroundColor = [UIColor colorWithRed:200 / 255.0 green:244 / 255.0 blue:211 / 255.0 alpha:1];
    [self.view addSubview:imageView];
    
    [imageView setImage:self.image];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImage *img=[[UIImage alloc]initWithContentsOfFile:self.paper.filePath];
        self.fileData=UIImagePNGRepresentation(img);;
    self.barStyle = @"Default";
    NSLog(@"10086");
    UIButton *editBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [editBtn setFrame:CGRectMake(240, 40, 70, 25)];
    [editBtn addTarget:self action:@selector(AddPhoto) forControlEvents:UIControlEventTouchUpInside];
    [editBtn setTitle:@"添加图片" forState:UIControlStateNormal];
    [self.view addSubview:editBtn];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button setFrame:CGRectMake(60, 400, 200, 40)];
    button.backgroundColor = ThemeColor;
    button.titleLabel.font = [UIFont systemFontOfSize:17];
    button.layer.cornerRadius = 5;
    button.titleLabel.textColor = [UIColor whiteColor];
    button.layer.masksToBounds = YES;
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"完成" forState:UIControlStateNormal];
    [self.view addSubview:button];
    

}
-(void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSLog(@"info--->成功：%@", info);
    UIImage* chosenImage = info[UIImagePickerControllerEditedImage];
    self.fileData = UIImagePNGRepresentation(chosenImage);
    [picker dismissViewControllerAnimated:YES completion:nil];
}
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

-(void)back{
    NSArray *dirArray = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *path = [dirArray firstObject];
    path = [path stringByAppendingPathComponent:[NSString stringWithFormat:@"/%@",self.paper.name]];
    [self.fileData writeToFile:path atomically:YES];
    
    MXEventDetailController *vc = [[MXEventDetailController alloc]init];
    vc.type = self.type;
    vc.topic = self.topic;
    vc.paper = self.paper;
    vc.newfilePath=path;
    NSLog(@"p:%@", vc.newfilePath);
    vc.hideNavBar = YES;
    [self.navigationController popViewControllerAnimated:YES];
    [self.navigationController popViewControllerAnimated:YES];
    [self.navigationController pushViewController:vc animated:true];
}

-(void)AddPhoto{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    // 打开控制器
    [self presentViewController:picker animated:YES completion:nil];
}

@end
