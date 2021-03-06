//
//  MXPaperDetailTableViewCell.m
//  MXNotebook
//
//  Created by yellow on 2017/8/9.
//  Copyright © 2017年 yellow. All rights reserved.
//

#import "MXPaperDetailTableViewCell.h"
#import "MXTopic.h"
#import "MXPaper.h"

@interface MXPaperDetailTableViewCell ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIView *baseView;
@property (weak, nonatomic) IBOutlet UILabel *GroupLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UITextField *Title;
@property (strong, nonatomic) NSDateFormatter *format;
@property (strong, nonatomic) UITapGestureRecognizer *tapGes;
@property (weak, nonatomic) IBOutlet UIImageView *cellArrowImageView;
@end

@implementation MXPaperDetailTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    NSLog(@"P");
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.Title.delegate = self;
    self.baseView.layer.cornerRadius = 5;
    self.baseView.layer.borderWidth = 1.5;
    self.tapGes = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction)];
    [self addGestureRecognizer:self.tapGes];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dateChangeed:) name:@"NewDate" object:nil];
}

- (void)setType:(PaperDetailType)type Topic:(MXTopic*)topic andPaper:(MXPaper*)paper {
    //self.cellArrowImageView.hidden = type == PaperAdd ? NO : YES;
    self.baseView.layer.borderColor = [topic.topicColor colorWithAlphaComponent:0.8].CGColor;
    self.GroupLabel.text = topic.name;
    if (type == PaperAdd) {
        self.timeLabel.text = [self.format stringFromDate:[NSDate date]];
    } else if (type == PaperUpdate) {
        self.timeLabel.text = [self.format stringFromDate:paper.date];
        self.Title.text = paper.name;
    }
}

- (void)dateChangeed:(NSNotification*)noti {
    NSDate *date = noti.object;
    self.timeLabel.text = [self.format stringFromDate:date];
}

- (void)setChooseDate:(NSDate *)chooseDate {
    _chooseDate = chooseDate;
    self.timeLabel.text = [self.format stringFromDate:chooseDate];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if ([self.delegate respondsToSelector:@selector(textFieldFinishContent:)]) {
        [self.delegate textFieldFinishContent:self.Title.text];
    }
}

- (void)tapAction {
    if ([self.delegate respondsToSelector:@selector(tapDateCell)]) {
        [self.delegate tapDateCell];
    }
}

- (NSDateFormatter *)format {
    if (!_format) {
        _format = [[NSDateFormatter alloc]init];
        [_format setDateFormat:@"yyyy年MM月dd日"];
        _format.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"];
    }
    return _format;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
