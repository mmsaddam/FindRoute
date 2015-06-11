//
//  PESGraphRouteStep.m
//  PESGraph
//
//  Created by Muzahidul Islam on 6/10/15.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GraphRouteStep.h"
#import "GraphNode.h"
#import "GraphEdge.h"

@implementation GraphRouteStep

@synthesize node, edge, isBeginningStep, isEndingStep;

#pragma mark -
#pragma mark Initilizers

- (id)init
{
    self = [super init];
    
    if (self) {
        
        isBeginningStep = NO;
        isEndingStep = NO;
    }
    
    return self;
}

- (id)initWithNode:(GraphNode *)aNode andEdge:(GraphEdge *)anEdge
{
    self = [super init];
    
    if (self) {
        
        isBeginningStep = NO;
        isEndingStep = (anEdge == nil);
        node = aNode;
        edge = anEdge;
    }
    
    return self;
}

- (id)initWithNode:(GraphNode *)aNode andEdge:(GraphEdge *)anEdge asBeginning:(bool)isBeginning
{
    self = [super init];
    
    if (self) {
        
        isBeginningStep = isBeginning;
        isEndingStep = (anEdge == nil);
        node = aNode;
        edge = anEdge;
    }
    
    return self;
}

#pragma mark -
#pragma mark Property Implementations
- (bool)isEndingStep
{
    return (self.edge == nil);
}

#pragma mark -
#pragma mark Memory Management


@end
