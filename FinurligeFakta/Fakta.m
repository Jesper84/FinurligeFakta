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


- (NSString *)description{
    return [NSString stringWithFormat:@"GUID: %@, title: %@, author: %@, content: %@", guid, title, author, content];
}

@end
