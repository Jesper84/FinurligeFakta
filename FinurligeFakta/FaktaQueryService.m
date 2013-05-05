//
//  FaktaQueryService.m
//  FinurligeFakta
//
//  Created by Jesper Nielsen on 04/05/13.
//  Copyright (c) 2013 Jesper Nielsen. All rights reserved.
//

#import "FaktaQueryService.h"
#import "Constants.h"
#import "Fakta.h"
#import <RestKit.h>
@implementation FaktaQueryService

- (void)queryFakta{
    __block Fakta *fakta = nil;
    NSString *guidURL = [NSString stringWithFormat:@"http://service.finurligefakta.dk/?method=getGuid&api-key=%@", API_KEY];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:guidURL]];
    
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[Fakta class]];
    [mapping addAttributeMappingsFromDictionary:@{
     @"guid":   @"guid",
     @"title": @"title",
     @"author": @"author",
     @"content": @"content"
     }];
    
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:mapping pathPattern:nil keyPath:nil statusCodes:nil];
    RKObjectRequestOperation *operation = [[RKObjectRequestOperation alloc] initWithRequest:request responseDescriptors:@[responseDescriptor]];
    
    [operation setCompletionBlockWithSuccess:^(RKObjectRequestOperation *operation, RKMappingResult *result){
        fakta = (Fakta *)[result firstObject];
        NSLog(@"Fakta: %@", fakta);
        
        NSString *faktaURL = [NSString stringWithFormat:@"http://service.finurligefakta.dk/?method=getFact&api-key=%@&guid=%@", API_KEY, fakta.guid];
        NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:faktaURL]];
        
        RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:mapping pathPattern:nil keyPath:nil statusCodes:nil];
        operation = [[RKObjectRequestOperation alloc] initWithRequest:request responseDescriptors:@[responseDescriptor]];
        
        [operation setCompletionBlockWithSuccess:^(RKObjectRequestOperation *operation, RKMappingResult *result){
            fakta = (Fakta *)[result firstObject];
            NSLog(@"Fakta: %@", fakta);
            
        } failure:nil];
        
        
        
        [operation start];
        
    } failure:nil];
    
    [operation start];
    
    
}

@end
