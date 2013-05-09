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
@implementation FaktaQueryService
@synthesize delegate;
- (void)queryGuid{

    NSString *url = [NSString stringWithFormat:@"http://service.finurligefakta.dk/?method=getGuid&api-key=%@", API_KEY];
    
    NSURLRequest *guidRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    [NSURLConnection sendAsynchronousRequest:guidRequest queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error){
        if(error.localizedDescription == nil){
            NSError *error = nil;
            NSDictionary *test = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
            NSLog(@"GUID: %@", [test valueForKey:@"guid"]);
            [self queryFaktaFor:[test valueForKey:@"guid"]];
            
            
        }
    }];
    
}

- (void)queryFaktaFor:(NSString *)guid{
    NSString *url = [NSString stringWithFormat:@"http://service.finurligefakta.dk/?method=getFact&guid=%@&api-key=%@", guid, API_KEY];
    NSURLRequest *factRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    [NSURLConnection sendAsynchronousRequest:factRequest queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error){
        if (error.localizedDescription == nil) {
            NSError *jsonError = nil;
            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&jsonError];
            NSLog(@"Fact: %@", json);
            [delegate factRequestComplete:json];
        }
    }];
}

@end
