//
//  EventDetailViewCell.h
//  XNotebook
//
//  Created by 陈博 on 19/4/19.
//  Copyright © 2019年 yellow. All rights reserved.
//
#import <UIKit/UIKit.h>

@protocol EventDetailViewCellDelegate <NSObject>

- (void)textFieldFinishContent:(NSString*)content ;

@end

@class MXTopic, MXPaper;
@interface EventDetailViewCell : UITableViewCell

@property (weak, nonatomic) id <EventDetailViewCellDelegate>delegate;

- (void)setType:(PaperDetailType)type Topic:(MXTopic*)topic andPaper:(MXPaper*)paper;

@end
