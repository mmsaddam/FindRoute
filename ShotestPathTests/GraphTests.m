//
//  PESGraphTests.m
//  PESGraphTests
//
//  Created by Created by Muzahidul Islam on 6/10/15.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//


#import "GraphTests.h"
#import "Graph.h"
#import "GraphNode.h"
#import "GraphEdge.h"
#import "GraphRoute.h"

@implementation GraphTests

// Basic test to make sure we can keep track of all nodes in the graph
- (void)testAddingNodes
{
    Graph *graph = [[Graph alloc] init];
    
    // Create four basic nodes, connect them, add them to the graph, 
    // and make sure the graph contains them all.
    
    GraphNode *aNode = [GraphNode nodeWithIdentifier:@"A"];
    GraphNode *bNode = [GraphNode nodeWithIdentifier:@"B"];
    GraphNode *cNode = [GraphNode nodeWithIdentifier:@"C"];
    GraphNode *dNode = [GraphNode nodeWithIdentifier:@"D"];

    [graph addEdge:[GraphEdge edgeWithName:@"A-B"] fromNode:aNode toNode:bNode];
    [graph addEdge:[GraphEdge edgeWithName:@"B-D"] fromNode:bNode toNode:dNode];
    [graph addEdge:[GraphEdge edgeWithName:@"C-D"] fromNode:cNode toNode:dNode];
    [graph addEdge:[GraphEdge edgeWithName:@"A-C"] fromNode:aNode toNode:cNode];
    
    XCTAssertEqual([NSNumber numberWithInt:4], [NSNumber numberWithInt:(int)graph.nodes.count], @"Bad Amount, graph should contain 4 elements, not %lu", (unsigned long)graph.nodes.count);
    
}

// Test to make sure that edges are managed in the graph correctly.  The test graph below 
// looks like this (all edges are bi-directional)
//
//  A - 4 - B
//  |       |
//  3       6
//  |       |
//  C - 2 - D - 1 - F
//
- (void)testBiDirectionalEdges
{
    Graph *graph = [[Graph alloc] init];

    GraphNode *aNode = [GraphNode nodeWithIdentifier:@"A"];
    GraphNode *bNode = [GraphNode nodeWithIdentifier:@"B"];
    GraphNode *cNode = [GraphNode nodeWithIdentifier:@"C"];
    GraphNode *dNode = [GraphNode nodeWithIdentifier:@"D"];
    GraphNode *fNode = [GraphNode nodeWithIdentifier:@"F"];
    
    [graph addBiDirectionalEdge:[GraphEdge edgeWithName:@"A-C" andWeight:[NSNumber numberWithInt:4]] fromNode:aNode toNode:bNode];
    [graph addBiDirectionalEdge:[GraphEdge edgeWithName:@"A-B" andWeight:[NSNumber numberWithInt:3]] fromNode:aNode toNode:cNode];
    [graph addBiDirectionalEdge:[GraphEdge edgeWithName:@"C-D" andWeight:[NSNumber numberWithInt:2]] fromNode:cNode toNode:dNode];
    [graph addBiDirectionalEdge:[GraphEdge edgeWithName:@"B-D" andWeight:[NSNumber numberWithInt:6]] fromNode:bNode toNode:dNode];
    [graph addBiDirectionalEdge:[GraphEdge edgeWithName:@"D-F" andWeight:[NSNumber numberWithInt:1]] fromNode:dNode toNode:fNode];

    // Now check to make sure those weights are still as we expect them to be
    XCTAssertEqual([NSNumber numberWithInt:2], [graph weightFromNode:cNode toNeighboringNode:dNode], @"Invald weight from c -> d, should be 2, not %@", [graph weightFromNode:cNode toNeighboringNode:dNode]);

    XCTAssertEqual([NSNumber numberWithInt:4], [graph weightFromNode:aNode toNeighboringNode:bNode], @"Invald weight from a -> b, should be 4, not %@", [graph weightFromNode:aNode toNeighboringNode:bNode]);

    XCTAssertEqual([NSNumber numberWithInt:6], [graph weightFromNode:bNode toNeighboringNode:dNode], @"Invald weight from b -> d, should be 6, not %@", [graph weightFromNode:bNode toNeighboringNode:dNode]);

    
    // Also make sure they're correctly pointing both ways
    XCTAssertEqual([NSNumber numberWithInt:2], [graph weightFromNode:dNode toNeighboringNode:cNode], @"Invald weight from d -> c, should be 2, not %@", [graph weightFromNode:dNode toNeighboringNode:cNode]);

    // Last, make sure that nodes w/ no connection correctly report as nil
    XCTAssertNil([graph weightFromNode:aNode toNeighboringNode:fNode], @"Invald weight from a -> f, should be %@, not %@", nil, [graph weightFromNode:aNode toNeighboringNode:fNode]);

}

// Test to make sure edges are manage correctly when they're one directional
// Test graph looks like this
//   A -- 4 --> B -- 2 --> C <-- 3 --> D
//   ^                                 |
//    \------------- 10 ---------------/
//
- (void)testUniDirectionalEdges
{
    Graph *graph = [[Graph alloc] init];
    
    GraphNode *aNode = [GraphNode nodeWithIdentifier:@"A"];
    GraphNode *bNode = [GraphNode nodeWithIdentifier:@"B"];
    GraphNode *cNode = [GraphNode nodeWithIdentifier:@"C"];
    GraphNode *dNode = [GraphNode nodeWithIdentifier:@"D"];

    [graph addEdge:[GraphEdge edgeWithName:@"A -> B" andWeight:[NSNumber numberWithInt:4]] fromNode:aNode toNode:bNode];
    [graph addEdge:[GraphEdge edgeWithName:@"B -> C" andWeight:[NSNumber numberWithInt:2]] fromNode:bNode toNode:cNode];
    [graph addBiDirectionalEdge:[GraphEdge edgeWithName:@"C <-> D" andWeight:[NSNumber numberWithInt:3]] fromNode:cNode toNode:dNode];
    [graph addEdge:[GraphEdge edgeWithName:@"D -> A" andWeight:[NSNumber numberWithInt:10]] fromNode:dNode toNode:aNode];

    // Now check that the edges all line up
    NSNumber *aToBWeight = [graph weightFromNode:aNode toNeighboringNode:bNode];    
    XCTAssertEqual([NSNumber numberWithInt:4], aToBWeight, @"Invald weight from a -> b, should be 4, not %@", aToBWeight);

    NSNumber *cToDWeight = [graph weightFromNode:cNode toNeighboringNode:dNode];    
    XCTAssertEqual([NSNumber numberWithInt:3], cToDWeight, @"Invald weight from c -> d, should be 3, not %@", cToDWeight);

    NSNumber *dToCWeight = [graph weightFromNode:dNode toNeighboringNode:cNode];    
    XCTAssertEqual([NSNumber numberWithInt:3], cToDWeight, @"Invald weight from d -> c, should be 3, not %@", dToCWeight);

    NSNumber *dToAWeight = [graph weightFromNode:dNode toNeighboringNode:aNode];    
    XCTAssertEqual([NSNumber numberWithInt:10], dToAWeight, @"Invald weight from d -> a, should be 10, not %@", dToAWeight);
    
    XCTAssertNil([graph weightFromNode:aNode toNeighboringNode:dNode], @"Invald weight from a -> d, should be %@, not %@", nil, [graph weightFromNode:aNode toNeighboringNode:dNode]);

    
}

// Test to make sure that nodes are correctly stored and relatable to their neighbors
// test graph looks like below (all edges are bi-directional)
//
//  A - 4 - B
//  |       |
//  3       6
//  |       |
//  C - 2 - D - 1 - F
//
- (void)testNeighboringNodes
{
    Graph *graph = [[Graph alloc] init];
    
    GraphNode *aNode = [GraphNode nodeWithIdentifier:@"A"];
    GraphNode *bNode = [GraphNode nodeWithIdentifier:@"B"];
    GraphNode *cNode = [GraphNode nodeWithIdentifier:@"C"];
    GraphNode *dNode = [GraphNode nodeWithIdentifier:@"D"];
    GraphNode *fNode = [GraphNode nodeWithIdentifier:@"F"];
    
    [graph addBiDirectionalEdge:[GraphEdge edgeWithName:@"A-C" andWeight:[NSNumber numberWithInt:4]] fromNode:aNode toNode:bNode];
    [graph addBiDirectionalEdge:[GraphEdge edgeWithName:@"A-B" andWeight:[NSNumber numberWithInt:3]] fromNode:aNode toNode:cNode];
    [graph addBiDirectionalEdge:[GraphEdge edgeWithName:@"C-D" andWeight:[NSNumber numberWithInt:2]] fromNode:cNode toNode:dNode];
    [graph addBiDirectionalEdge:[GraphEdge edgeWithName:@"B-D" andWeight:[NSNumber numberWithInt:6]] fromNode:bNode toNode:dNode];
    [graph addBiDirectionalEdge:[GraphEdge edgeWithName:@"D-F" andWeight:[NSNumber numberWithInt:1]] fromNode:dNode toNode:fNode];

    NSSet *neighborsOfA = [graph neighborsOfNode:aNode];
    XCTAssertTrue([neighborsOfA containsObject:bNode], @"Incorrect Neighbors.  Node B should be a neighbor of A");
    XCTAssertTrue([neighborsOfA containsObject:cNode], @"Incorrect Neighbors.  Node C should be a neighbor of A");
    XCTAssertFalse([neighborsOfA containsObject:fNode], @"Incorrect Neighbors.  Node F should not be a neighbor of A");    
    XCTAssertFalse([neighborsOfA containsObject:dNode], @"Incorrect Neighbors.  Node D should not be a neighbor of A");    

}

// Test the shortest path, to make sure we're correctly pulling out the shortest path between two nodes
// Graph here is identical to the one on the "Dijkstra's algorithm" wikipedia page
// http://en.wikipedia.org/wiki/Dijkstra's_algorithm
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

    // There should be three steps in the route, from A -> C -> F -> E
    XCTAssertTrue(4 == [route count], @"Invald number of steps in route, should be 4, not %lu", (unsigned long)[route count]);
    XCTAssertEqual(aNode, [route startingNode], @"Invald starting point for route, should be node A, not %@", [[route startingNode] identifier]);
    XCTAssertEqual(eNode, [route endingNode], @"Invald starting point for route, should be node E, not %@", [[route endingNode] identifier]);
    XCTAssertTrue(20 == [route length], @"Invalid distance for route, should be 23, not %f.0", [route length]);
    
}

// A second test of the Dijkstra algorithm, here with the data on
// http://computer.howstuffworks.com/routing-algorithm3.htm
- (void)testShortestPathSecond
{
    Graph *graph = [[Graph alloc] init];
    
    GraphNode *aNode = [GraphNode nodeWithIdentifier:@"A"];
    GraphNode *bNode = [GraphNode nodeWithIdentifier:@"B"];
    GraphNode *cNode = [GraphNode nodeWithIdentifier:@"C"];
    GraphNode *dNode = [GraphNode nodeWithIdentifier:@"D"];
    GraphNode *eNode = [GraphNode nodeWithIdentifier:@"E"];

    [graph addBiDirectionalEdge:[GraphEdge edgeWithName:@"A <-> B" andWeight:[NSNumber numberWithInt:1]] fromNode:aNode toNode:bNode];
    [graph addBiDirectionalEdge:[GraphEdge edgeWithName:@"A <-> C" andWeight:[NSNumber numberWithInt:5]] fromNode:aNode toNode:cNode];
    [graph addBiDirectionalEdge:[GraphEdge edgeWithName:@"B <-> D" andWeight:[NSNumber numberWithInt:2]] fromNode:bNode toNode:dNode];
    [graph addBiDirectionalEdge:[GraphEdge edgeWithName:@"B <-> E" andWeight:[NSNumber numberWithInt:4]] fromNode:bNode toNode:eNode];
    [graph addBiDirectionalEdge:[GraphEdge edgeWithName:@"C <-> D" andWeight:[NSNumber numberWithInt:2]] fromNode:cNode toNode:dNode];
    [graph addBiDirectionalEdge:[GraphEdge edgeWithName:@"C <-> E" andWeight:[NSNumber numberWithInt:3]] fromNode:cNode toNode:eNode];
    [graph addBiDirectionalEdge:[GraphEdge edgeWithName:@"D <-> E" andWeight:[NSNumber numberWithInt:1]] fromNode:dNode toNode:eNode];
    
    GraphRoute *route = [graph shortestRouteFromNode:aNode toNode:eNode];

    // There should be four steps in the route, from A -> B -> D -> E
    XCTAssertTrue(4 == [route count], @"Invald number of steps in route, should be 4, not %lu", (unsigned long)[route count]);
    XCTAssertEqual(aNode, [route startingNode], @"Invald starting point for route, should be node A, not %@", [[route startingNode] identifier]);
    XCTAssertEqual(eNode, [route endingNode], @"Invald starting point for route, should be node E, not %@", [[route endingNode] identifier]);
    XCTAssertTrue(4 == [route length], @"Invalid distance for route, should be 4, not %f.0", [route length]);
    
}

// A third test of the Dijkstra algorithm implementation, with the data taken from
// http://www.math.unm.edu/~loring/links/graph_s09/dijskstra3.pdf (first problem)
- (void)testShortestPathThird
{
    Graph *graph = [[Graph alloc] init];
    
    GraphNode *oNode = [GraphNode nodeWithIdentifier:@"O"];
    GraphNode *aNode = [GraphNode nodeWithIdentifier:@"A"];
    GraphNode *bNode = [GraphNode nodeWithIdentifier:@"B"];
    GraphNode *cNode = [GraphNode nodeWithIdentifier:@"C"];
    GraphNode *dNode = [GraphNode nodeWithIdentifier:@"D"];
    GraphNode *eNode = [GraphNode nodeWithIdentifier:@"E"];
    GraphNode *fNode = [GraphNode nodeWithIdentifier:@"F"];
    GraphNode *gNode = [GraphNode nodeWithIdentifier:@"G"];
    GraphNode *hNode = [GraphNode nodeWithIdentifier:@"H"];
    GraphNode *iNode = [GraphNode nodeWithIdentifier:@"I"];
    GraphNode *tNode = [GraphNode nodeWithIdentifier:@"T"];
    
    [graph addBiDirectionalEdge:[GraphEdge edgeWithName:@"O <-> A" andWeight:[NSNumber numberWithInt:1]] fromNode:oNode toNode:aNode];
    [graph addBiDirectionalEdge:[GraphEdge edgeWithName:@"O <-> D" andWeight:[NSNumber numberWithInt:1]] fromNode:oNode toNode:dNode];    
    [graph addBiDirectionalEdge:[GraphEdge edgeWithName:@"A <-> B" andWeight:[NSNumber numberWithInt:2]] fromNode:aNode toNode:bNode];
    [graph addBiDirectionalEdge:[GraphEdge edgeWithName:@"A <-> T" andWeight:[NSNumber numberWithInt:9]] fromNode:aNode toNode:tNode];    
    [graph addBiDirectionalEdge:[GraphEdge edgeWithName:@"B <-> C" andWeight:[NSNumber numberWithInt:2]] fromNode:bNode toNode:cNode];
    [graph addBiDirectionalEdge:[GraphEdge edgeWithName:@"B <-> F" andWeight:[NSNumber numberWithInt:2]] fromNode:bNode toNode:fNode];
    [graph addBiDirectionalEdge:[GraphEdge edgeWithName:@"C <-> E" andWeight:[NSNumber numberWithInt:1]] fromNode:cNode toNode:eNode];
    [graph addBiDirectionalEdge:[GraphEdge edgeWithName:@"D <-> G" andWeight:[NSNumber numberWithInt:1]] fromNode:dNode toNode:gNode];
    [graph addBiDirectionalEdge:[GraphEdge edgeWithName:@"E <-> F" andWeight:[NSNumber numberWithInt:2]] fromNode:eNode toNode:fNode];
    [graph addBiDirectionalEdge:[GraphEdge edgeWithName:@"E <-> I" andWeight:[NSNumber numberWithInt:2]] fromNode:eNode toNode:iNode];    
    [graph addBiDirectionalEdge:[GraphEdge edgeWithName:@"F <-> H" andWeight:[NSNumber numberWithInt:1]] fromNode:fNode toNode:hNode];
    [graph addBiDirectionalEdge:[GraphEdge edgeWithName:@"G <-> H" andWeight:[NSNumber numberWithInt:1]] fromNode:gNode toNode:hNode];
    [graph addBiDirectionalEdge:[GraphEdge edgeWithName:@"I <-> T" andWeight:[NSNumber numberWithInt:1]] fromNode:iNode toNode:tNode];

    GraphRoute *route = [graph shortestRouteFromNode:oNode toNode:tNode];
    
    // There are two valid, equally weighted trips here, O -> A -> B -> C -> E -> I -> T and O -> D -> G -> H -> F -> E -> I -> T
    // Both have a total distance of 9
    XCTAssertTrue((7 == [route count] || 8 == [route count]), @"Invald number of steps in route, should be 7 or 8, not %lu", (unsigned long)[route count]);
    XCTAssertTrue(9 == [route length], @"Invalid distance for route, should be 9, not %f.0", [route length]);
    
}

// Test removing uni-directional edges from a graph
- (void)testRemoveEdgeFromNode
{
    Graph *graph = [[Graph alloc] init];

    // Create a simple graph with four nodes, and five several uni-directional edges
    GraphNode *aNode = [GraphNode nodeWithIdentifier:@"A"];
    GraphNode *bNode = [GraphNode nodeWithIdentifier:@"B"];
    GraphNode *cNode = [GraphNode nodeWithIdentifier:@"C"];
    GraphNode *dNode = [GraphNode nodeWithIdentifier:@"D"];
    
    [graph addEdge:[GraphEdge edgeWithName:@"A -> B"] fromNode:aNode toNode:bNode];
    [graph addEdge:[GraphEdge edgeWithName:@"B -> D"] fromNode:bNode toNode:dNode];
    [graph addEdge:[GraphEdge edgeWithName:@"B -> A"] fromNode:bNode toNode:aNode];    
    [graph addEdge:[GraphEdge edgeWithName:@"C -> D"] fromNode:cNode toNode:dNode];
    [graph addEdge:[GraphEdge edgeWithName:@"A -> C"] fromNode:aNode toNode:cNode];
    
    XCTAssertEqual([NSNumber numberWithInt:4], [NSNumber numberWithInt:(int)graph.nodes.count], @"Bad Amount, graph should contain 4 node, not %lu", (unsigned long)graph.nodes.count);
    XCTAssertEqual([NSNumber numberWithInt:5], [NSNumber numberWithInt:(int)[graph edgeCount]], @"Bad Amount, graph should contain 5 edges, not %ld", (long)[graph edgeCount]);

    // Also, specifically check that the edge we're interested in exists
    XCTAssertNotNil([graph edgeFromNode:bNode toNeighboringNode:dNode], @"An edge from B -> D should exist in the graph");
    
    // Now, remove a couple of edges and make sure that the graph is updated accordingly     
    XCTAssertEqual([graph removeEdgeFromNode:bNode toNode:dNode], YES, @"Removing an existing node should return YES");
    
    // Should now be 4 edges remaining in the graph
    XCTAssertEqual([NSNumber numberWithInt:4], [NSNumber numberWithInt:(int)[graph edgeCount]], @"Bad Amount, graph should now contain 4 edges, not %ld", (long)[graph edgeCount]);
    
    // Also make sure that there is no longer a edge between these two node
    XCTAssertNil([graph edgeFromNode:bNode toNeighboringNode:dNode], @"An edge from B -> D should exist in the graph");
    
    // Do it all again, by removing the edge from A -> C
    XCTAssertNotNil([graph edgeFromNode:aNode toNeighboringNode:cNode], @"An edge from A -> C should exist in the graph");
    XCTAssertEqual([graph removeEdgeFromNode:aNode toNode:cNode], YES, @"Removing an existing node should return YES");
    XCTAssertEqual([NSNumber numberWithInt:3], [NSNumber numberWithInt:(int)[graph edgeCount]], @"Bad Amount, graph should now contain 3 edges, not %ld", (long)[graph edgeCount]);
    XCTAssertNil([graph edgeFromNode:aNode toNeighboringNode:cNode], @"An edge from A -> C should exist in the graph");
    
    // Next, make sure we can add the edge back in and have everything update correctly
    [graph addEdge:[GraphEdge edgeWithName:@"A -> C"] fromNode:aNode toNode:cNode];
    XCTAssertEqual([NSNumber numberWithInt:4], [NSNumber numberWithInt:(int)[graph edgeCount]], @"Bad Amount, graph should now contain 4 edges, not %ld", (long)[graph edgeCount]);
    XCTAssertNotNil([graph edgeFromNode:aNode toNeighboringNode:cNode], @"An edge from A -> C should exist in the graph");
        
    // Last, check and make sure that we fail when we try to remove a non-existant edge
    XCTAssertEqual([graph removeEdgeFromNode:aNode toNode:dNode], NO, @"Trying to remove a non-existant edge should return NO");
}

- (void)testRemoveBiDirectionalEdgeFromNode
{
    Graph *graph = [[Graph alloc] init];
    
    GraphNode *aNode = [GraphNode nodeWithIdentifier:@"A"];
    GraphNode *bNode = [GraphNode nodeWithIdentifier:@"B"];
    GraphNode *cNode = [GraphNode nodeWithIdentifier:@"C"];
    GraphNode *dNode = [GraphNode nodeWithIdentifier:@"D"];
    GraphNode *fNode = [GraphNode nodeWithIdentifier:@"F"];
    
    [graph addBiDirectionalEdge:[GraphEdge edgeWithName:@"A-C" andWeight:[NSNumber numberWithInt:4]] fromNode:aNode toNode:bNode];
    [graph addBiDirectionalEdge:[GraphEdge edgeWithName:@"A-B" andWeight:[NSNumber numberWithInt:3]] fromNode:aNode toNode:cNode];
    [graph addBiDirectionalEdge:[GraphEdge edgeWithName:@"C-D" andWeight:[NSNumber numberWithInt:2]] fromNode:cNode toNode:dNode];
    [graph addBiDirectionalEdge:[GraphEdge edgeWithName:@"B-D" andWeight:[NSNumber numberWithInt:6]] fromNode:bNode toNode:dNode];
    [graph addBiDirectionalEdge:[GraphEdge edgeWithName:@"D-F" andWeight:[NSNumber numberWithInt:1]] fromNode:dNode toNode:fNode];

    // Basic sanity check to make sure the graph looks how we expect
    XCTAssertEqual([NSNumber numberWithInt:5], [NSNumber numberWithInt:(int)graph.nodes.count], @"Bad Amount, graph should contain 4 node, not %lu", (unsigned long)graph.nodes.count);
    XCTAssertEqual([NSNumber numberWithInt:10], [NSNumber numberWithInt:(int)[graph edgeCount]], @"Bad Amount, graph should contain 10 edges, not %ld", (long)[graph edgeCount]);

    // Now, try removing an exisitng bi-directional edge
    XCTAssertEqual([graph removeBiDirectionalEdgeFromNode:aNode toNode:cNode], YES, @"should be able to correctly remove an exiting bi-directional edge");
    
    // Now check to make sure that the counts are still correct
    XCTAssertEqual([NSNumber numberWithInt:5], [NSNumber numberWithInt:(int)graph.nodes.count], @"Bad Amount, graph should contain 4 node, not %lu", (unsigned long)graph.nodes.count);
    XCTAssertEqual([NSNumber numberWithInt:8], [NSNumber numberWithInt:(int)[graph edgeCount]], @"Bad Amount, graph should contain 8 edges, not %ld", (long)[graph edgeCount]);

    // Now try to remove a non-existing bi-directional edge and make sure it fails
    XCTAssertEqual([graph removeBiDirectionalEdgeFromNode:aNode toNode:fNode], NO, @"There is no edge from A <-> F, so removing shoudl fail");
 
    // Check to make sure we _really_ didn't remove anything by looking at the counts too
    XCTAssertEqual([NSNumber numberWithInt:5], [NSNumber numberWithInt:(int)graph.nodes.count], @"Bad Amount, graph should still contain 4 node, not %lu", (unsigned long)graph.nodes.count);
    XCTAssertEqual([NSNumber numberWithInt:8], [NSNumber numberWithInt:(int)[graph edgeCount]], @"Bad Amount, graph should still contain 8 edges, not %ld", (long)[graph edgeCount]);

    // Now, remove a single edge (ie just half of an origianlly added bi-directional edge)
    XCTAssertEqual([graph removeEdgeFromNode:dNode toNode:cNode], YES, @"Should be able to successfully remove a single edge of an (originally) bi-direcitonal edge");
    XCTAssertEqual([NSNumber numberWithInt:7], [NSNumber numberWithInt:(int)[graph edgeCount]], @"Bad Amount, graph should now contain 7 edges, not %ld", (long)[graph edgeCount]);
    
    // Next, make sure trying to remove a bi-directional edge, where one direction of the edge has already been removed, fails
    XCTAssertEqual([graph removeBiDirectionalEdgeFromNode:dNode toNode:cNode], NO, @"There edge from c -> d is no longer bi-directional, so this should fail");
    
    // Since we didn't actually remove anything above, we should still have 7 edges in the graph
    XCTAssertEqual([NSNumber numberWithInt:7], [NSNumber numberWithInt:(int)[graph edgeCount]], @"Bad Amount, graph should now contain 7 edges, not %ld", (long)[graph edgeCount]);

    // Last, make sure we can remove a bi-directional edge, even when we try to remove them in the opposite order we declaried them (ie removing
    // D <-> F should have the same effect as removing F <-> D
    XCTAssertEqual([graph removeBiDirectionalEdgeFromNode:fNode toNode:dNode], YES, @"We should be able to remove the bi-directional edge between two nodes, regardless of node order");
    XCTAssertEqual([NSNumber numberWithInt:5], [NSNumber numberWithInt:(int)[graph edgeCount]], @"Bad Amount, graph should now contain 5 edges, not %ld", (long)[graph edgeCount]);
}


@end
