//
//  MXPaperDetailTableViewCell.m
//  MXNotebook
//
//  Created by yellow on 2017/8/9.
//  Copyright © 2017年 yellow. All rights reserved.
//

#import "EventDetailViewCell.h"
#import "MXTopic.h"
#import "MXPaper.h"

@interface EventDetailViewCell ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIView *baseView;
@property (weak, nonatomic) IBOutlet UITextField *MainText;
@property (strong, nonatomic) NSDateFormatter *format;
@property (strong, nonatomic) UITapGestureRecognizer *tapGes;
@property (weak, nonatomic) IBOutlet UIImageView *cellArrowImageView;
@property (strong, nonatomic)UITextView *editDetailTextField;
@end

@implementation EventDetailViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    NSLog(@"P");
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.MainText.delegate = self;
    self.baseView.layer.cornerRadius = 5;
    self.baseView.layer.borderWidth = 1.5;
}

- (void)setType:(PaperDetailType)type Topic:(MXTopic*)topic andPaper:(MXPaper*)paper {
    //self.cellArrowImageView.hidden = type == PaperAdd ? NO : YES;
    self.baseView.layer.borderColor = [topic.topicColor colorWithAlphaComponent:0.8].CGColor;
        self.MainText.text = paper.Text;
}


- (void)textFieldDidEndEditing:(UITextField *)textField {
    if ([self.delegate respondsToSelector:@selector(textFieldFinishContent:)]) {
        [self.delegate textFieldFinishContent:self.MainText.text];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
