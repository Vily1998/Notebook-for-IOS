//
//  photo.h
//  XNotebook
//
//  Created by 陈博 on 19/4/22.
//  Copyright © 2019年 yellow. All rights reserved.
//
#import <UIKit/UIKit.h>

@class MXPaper,MXTopic;
@interface MXPhotoController: MXBaseViewController

@property (strong, nonatomic) MXTopic *topic;
@property (strong, nonatomic) MXPaper *paper;
@property (assign, nonatomic) PaperDetailType type;

@end
