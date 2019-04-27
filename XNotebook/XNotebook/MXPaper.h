//
//  MXPaper.h
//  MXNotebook
//
//
//

#import <Realm/Realm.h>

@interface MXPaper : RLMObject

@property NSString *topicID;
@property NSString *name;
@property NSDate *date;
@property NSString *Text;
@property NSString *filePath;
@property (copy, nonatomic) NSString *dateStr;

@end
RLM_ARRAY_TYPE(MXPaper)
