//
//  MXTopic.m
//  MXNotebook
//
//
//

#import "MXTopic.h"

@implementation MXTopic

+ (NSString *)primaryKey {
    return @"ID";
}

+ (NSArray<NSString *> *)ignoredProperties {
    return @[@"topicColor"];
}

@end
