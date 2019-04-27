//
//  MXPaper.m
//  MXNotebook
//
//
//

#import "MXPaper.h"

@implementation MXPaper

+ (NSArray<NSString *> *)ignoredProperties {
    return @[@"dateStr"];
}

- (NSString *)dateStr {
    NSDateFormatter *formate = [[NSDateFormatter alloc]init];
    [formate setDateFormat:@"yyyy.MM.dd"];
    formate.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"];
    return [formate stringFromDate:self.date];
}

@end
