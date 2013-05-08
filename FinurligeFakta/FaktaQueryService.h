//
//  FaktaQueryService.h
//  FinurligeFakta
//
//  Created by Jesper Nielsen on 04/05/13.
//  Copyright (c) 2013 Jesper Nielsen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FaktaQueryService : NSObject<NSURLConnectionDelegate>
- (void)queryGuid;
- (void)queryFaktaFor:(NSString *) guid;

@end
