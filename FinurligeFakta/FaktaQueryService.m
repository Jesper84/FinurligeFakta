//
//  FaktaQueryService.m
//  FinurligeFakta
//
//  Created by Jesper Nielsen on 04/05/13.
//  Copyright (c) 2013 Jesper Nielsen. All rights reserved.
//

#import "FaktaQueryService.h"
#import "Constants.h"
#import <RestKit.h>
@implementation FaktaQueryService

- (void)queryFakta{
    NSString *url = [NSString stringWithFormat:@"http://service.finurligefakta.dk/?method=getGuid&api-key=%@", API_KEY];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
    
    
    
}

@end
