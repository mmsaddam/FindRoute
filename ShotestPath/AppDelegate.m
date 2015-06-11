//
//  AppDelegate.m
//  ShotestPath
//
//  Created by Muzahidul Islam on 6/10/15.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#import "Graph.h"
#import "GraphNode.h"
#import "GraphEdge.h"
#import "GraphRoute.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
     //  [self testShortestPath];
    return YES;
}
- (void)testShortestPath
{
    Graph *graph = [[Graph alloc] init];
    
    GraphNode *aNode = [GraphNode nodeWithIdentifier:@"A"];
    GraphNode *bNode = [GraphNode nodeWithIdentifier:@"B"];
    GraphNode *cNode = [GraphNode nodeWithIdentifier:@"C"];
    GraphNode *dNode = [GraphNode nodeWithIdentifier:@"D"];
    GraphNode *eNode = [GraphNode nodeWithIdentifier:@"E"];
    GraphNode *fNode = [GraphNode nodeWithIdentifier:@"F"];
    
    [graph addBiDirectionalEdge:[GraphEdge edgeWithName:@"A <-> B" andWeight:[NSNumber numberWithInt:7]] fromNode:aNode toNode:bNode];
    [graph addBiDirectionalEdge:[GraphEdge edgeWithName:@"A <-> C" andWeight:[NSNumber numberWithInt:9]] fromNode:aNode toNode:cNode];
    [graph addBiDirectionalEdge:[GraphEdge edgeWithName:@"A <-> F" andWeight:[NSNumber numberWithInt:14]] fromNode:aNode toNode:fNode];
    [graph addBiDirectionalEdge:[GraphEdge edgeWithName:@"B <-> C" andWeight:[NSNumber numberWithInt:10]] fromNode:bNode toNode:cNode];
    [graph addBiDirectionalEdge:[GraphEdge edgeWithName:@"B <-> D" andWeight:[NSNumber numberWithInt:15]] fromNode:bNode toNode:dNode];
    [graph addBiDirectionalEdge:[GraphEdge edgeWithName:@"C <-> F" andWeight:[NSNumber numberWithInt:2]] fromNode:cNode toNode:fNode];
    [graph addBiDirectionalEdge:[GraphEdge edgeWithName:@"C <-> D" andWeight:[NSNumber numberWithInt:11]] fromNode:cNode toNode:dNode];
    [graph addBiDirectionalEdge:[GraphEdge edgeWithName:@"D <-> E" andWeight:[NSNumber numberWithInt:6]] fromNode:dNode toNode:eNode];
    [graph addBiDirectionalEdge:[GraphEdge edgeWithName:@"E <-> F" andWeight:[NSNumber numberWithInt:9]] fromNode:eNode toNode:fNode];
    
    GraphRoute *route = [graph shortestRouteFromNode:aNode toNode:eNode];
    
    NSLog(@"steps %@",route);
    
//    // There should be three steps in the route, from A -> C -> F -> E
//    XCTAssertTrue(4 == [route count], @"Invald number of steps in route, should be 4, not %lu", (unsigned long)[route count]);
//    XCTAssertEqual(aNode, [route startingNode], @"Invald starting point for route, should be node A, not %@", [[route startingNode] identifier]);
//    XCTAssertEqual(eNode, [route endingNode], @"Invald starting point for route, should be node E, not %@", [[route endingNode] identifier]);
//    XCTAssertTrue(20 == [route length], @"Invalid distance for route, should be 23, not %f.0", [route length]);
    
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
