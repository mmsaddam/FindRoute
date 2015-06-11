//
//  PESGraphRoute.m
//  PESGraph
//
//  Created by Muzahidul Islam on 6/10/15.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GraphRoute.h"
#import "GraphRouteStep.h"
#import "GraphNode.h"
#import "GraphEdge.h"

@implementation GraphRoute

@synthesize steps;

- (id)init
{
    self = [super init];
    
    if (self) {
        
        steps = [[NSMutableArray alloc] init];
    }
    
    return self;
}

- (void)addStepFromNode:(GraphNode *)aNode withEdge:(GraphEdge *)anEdge
{
    GraphRouteStep *aStep = [[GraphRouteStep alloc] initWithNode:aNode
                                                               andEdge:anEdge
                                                           asBeginning:([steps count] == 0)];
    
    [steps addObject:aStep];
}

- (NSString *)description
{
    NSMutableString *string = [NSMutableString string];
    
    [string appendString:@"Start: \n"];
    
    for (GraphRouteStep *aStep in steps) {
        
        if (aStep.edge) {
            
            [string appendFormat:@"\t%@ -> %@\n", aStep.node.identifier, aStep.edge];
            
        } else {
            
            [string appendFormat:@"\t%@ (End)", aStep.node.identifier];
            
        }
    }
    
    return string;
}

- (NSUInteger)count {
    
    return [steps count];
}

- (GraphNode *)startingNode {
    
    return ([self count] > 0) ? [[steps objectAtIndex:0] node] : nil;
}

- (GraphNode *)endingNode {
    
    return ([self count] > 0) ? [[steps objectAtIndex:([self count] - 1)] node] : nil;
}

- (float)length {
    
    float totalLength = 0;
    
    for (GraphRouteStep *aStep in steps) {
        
        if (aStep.edge) {
            
            totalLength += [aStep.edge.weight floatValue];
        }
    }
    
    return totalLength;
}

#pragma mark -
#pragma mark Memory Management


@end
