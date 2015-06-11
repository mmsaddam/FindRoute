//
//  PESGraphEdge.m
//  PESGraph
//
//  Created by Muzahidul Islam on 6/10/15.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GraphEdge.h"

@implementation GraphEdge

@synthesize name;
@synthesize weight;

#pragma mark -
#pragma mark Class Methods

+ (GraphEdge *)edgeWithName:(NSString *)aName andWeight:(NSNumber *)aNumber {
    
    GraphEdge *anEdge = [[GraphEdge alloc] init];
    
    anEdge.weight = aNumber;
    anEdge.name = aName;
    
    return anEdge;
}

+ (GraphEdge *)edgeWithName:(NSString *)aName {
    
    GraphEdge *anEdge = [[GraphEdge alloc] init];
    
    anEdge.name = aName;
    
    return anEdge;
}

#pragma mark -
#pragma mark Initilizers

- (id)init
{
    self = [super init];
    
    if (self) {
        
        // Set the default weight of the edge to be 1
        self.weight = [NSNumber numberWithInt:1];
    }
    
    return self;
}

#pragma mark -
#pragma mark Overrides

- (NSString *)description {
    
    return [NSString stringWithFormat:@"Edge: %@ with Weight:%@", self.name, self.weight];
}

#pragma mark -
#pragma mark Memory Management


@end
