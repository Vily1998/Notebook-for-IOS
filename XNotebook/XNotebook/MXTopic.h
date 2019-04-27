//
//  MXTopic.h
//  MXNotebook
//
//
//

#import <Realm/Realm.h>
#import "MXPaper.h"

@interface MXTopic : RLMObject

@property NSString *ID;
@property NSString *name;
@property NSDate *date;

/**
 一对多关系
 */
@property RLMArray <MXPaper*><MXPaper> *papers;
@property (strong, nonatomic) UIColor *topicColor;

@end
