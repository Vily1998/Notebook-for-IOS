//
//  EventDetailView.m
//  XNotebook
//
//  Created by 陈博 on 19/4/17.
//  Copyright © 2019年 yellow. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EventDetailView.h"
#import "MXTopic.h"
#import "MXPaper.h"

@interface EventDetailViewCell()
@property (weak, nonatomic) IBOutlet UIView *baseView;
@property (weak, nonatomic) IBOutlet UILabel *GroupLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UITextField *Title;
@property (weak, nonatomic) IBOutlet UITextField *amountTf;
@property (strong, nonatomic) NSDateFormatter *format;
@property (strong, nonatomic) UITapGestureRecognizer *tapGes;
@property (weak, nonatomic) IBOutlet UIImageView *cellArrowImageView;
@end

@implementation EventDetailViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

@end
