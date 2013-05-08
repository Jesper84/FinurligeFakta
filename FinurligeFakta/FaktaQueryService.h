//
//  FaktaQueryService.h
//  FinurligeFakta
//
//  Created by Jesper Nielsen on 04/05/13.
//  Copyright (c) 2013 Jesper Nielsen. All rights reserved.
//

#import <Foundation/Foundation.h>
@class FaktaQueryService;
@protocol FaktaQueryDelegate <NSObject>

- (void)factRequestComplete:(NSDictionary *)factData;

@end
@interface FaktaQueryService : NSObject<NSURLConnectionDelegate>{
    __weak id <FaktaQueryDelegate> delegate;
}

@property (nonatomic, weak) id <FaktaQueryDelegate> delegate;

- (void)queryGuid;
- (void)queryFaktaFor:(NSString *) guid;

@end
