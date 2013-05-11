//
//  Fakta.m
//  FinurligeFakta
//
//  Created by Jesper Nielsen on 05/05/13.
//  Copyright (c) 2013 Jesper Nielsen. All rights reserved.
//

#import "Fakta.h"

@implementation Fakta
@synthesize guid, title, author, content, url, sourceTitle;


- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.guid forKey:@"JNIGuid"];
    [aCoder encodeObject:self.title forKey:@"JNIFactTitle"];
    [aCoder encodeObject:self.author forKey:@"JNIFactAuthor"];
    [aCoder encodeObject:self.content forKey:@"JNIFactContent"];
    [aCoder encodeObject:self.url forKey:@"JNIFactURL"];
    [aCoder encodeObject:self.sourceTitle forKey:@"JNIFactSourceTitle"];
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if (self) {
        guid = [aDecoder decodeObjectForKey:@"JNIGuid"];
        title = [aDecoder decodeObjectForKey:@"JNIFactTitle"];
        author = [aDecoder decodeObjectForKey:@"JNIFactAuthor"];
        content = [aDecoder decodeObjectForKey:@"JNIFactContent"];
        url = [aDecoder decodeObjectForKey:@"JNIFactURL"];
        sourceTitle = [aDecoder decodeObjectForKey:@"JNIFactSourceTitle"];
    }
    return self;
}

- (NSString *)description{
    return [NSString stringWithFormat:@"GUID: %@, title: %@, author: %@, content: %@", guid, title, author, content];
}

@end
