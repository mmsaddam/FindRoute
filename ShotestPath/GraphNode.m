//
//  PESNode.m
//  PESGraph
//
//  Created by Muzahidul Islam on 6/10/15.
//  Copyright 2011 __MyCompanyName__. All rights reserved.//

#import "GraphNode.h"

@implementation GraphNode

@synthesize identifier;
@synthesize title;
@synthesize additionalData;


+ (GraphNode *)nodeWithIdentifier:(NSString *)anIdentifier {
    
    GraphNode *aNode = [[GraphNode alloc] init];
    
    aNode.identifier = anIdentifier;
    
    return aNode;
}



@end
