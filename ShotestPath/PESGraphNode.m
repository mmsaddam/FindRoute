//
//  PESNode.m
//  PESGraph
//
//  Created by Muzahidul Islam on 6/10/15.
//  Copyright 2011 __MyCompanyName__. All rights reserved.//

#import "PESGraphNode.h"

@implementation PESGraphNode

@synthesize identifier;
@synthesize title;
@synthesize additionalData;


+ (PESGraphNode *)nodeWithIdentifier:(NSString *)anIdentifier {
    
    PESGraphNode *aNode = [[PESGraphNode alloc] init];
    
    aNode.identifier = anIdentifier;
    
    return aNode;
}



@end
