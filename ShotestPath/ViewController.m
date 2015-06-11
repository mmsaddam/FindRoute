//
//  ViewController.m
//  ShotestPath
//
//  Created by Muzahidul Islam on 6/10/15.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#import "Graph.h"
#import "GraphNode.h"
#import "GraphEdge.h"
#import "GraphRoute.h"
#import "GraphRouteStep.h"

@interface ViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIButton *nodeA;
@property (weak, nonatomic) IBOutlet UIButton *nodeB;
@property (weak, nonatomic) IBOutlet UIButton *nodeC;
@property (weak, nonatomic) IBOutlet UIButton *nodeD;
@property (weak, nonatomic) IBOutlet UIButton *nodeE;
@property (weak, nonatomic) IBOutlet UIButton *nodeF;
@property (weak, nonatomic) IBOutlet UIButton *nodeG;
@property (weak, nonatomic) IBOutlet UITextField *source;
@property (weak, nonatomic) IBOutlet UITextField *destination;

@property (nonatomic, strong) Graph *graph;
@property (nonatomic, strong) GraphNode *aNode;
@property (nonatomic, strong) GraphNode *bNode;
@property (nonatomic, strong) GraphNode *cNode;
@property (nonatomic, strong) GraphNode *dNode;
@property (nonatomic, strong) GraphNode *eNode;
@property (nonatomic, strong) GraphNode *fNode;
@property (nonatomic, strong) GraphNode *gNode;
@property (nonatomic, strong) GraphRoute *route;
@end

@implementation ViewController
@synthesize nodeA,nodeB,nodeC,nodeD,nodeE,nodeF,nodeG;
@synthesize graph,aNode,bNode,cNode,dNode,eNode,fNode,gNode,route;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self makeUIRound];
    [self reset];
    
    graph = [[Graph alloc] init];
    
    [self addNodeToGraph];
    
   
    
    
   // NSLog(@"steps %@ route %@ start node %@",route.steps,route,route.startingNode);

}


-(GraphRoute *)findRouteFromNode:(GraphNode *)startNode ToNode:(GraphNode *)endNode{
    return [graph shortestRouteFromNode:startNode toNode:eNode];
}

-(void)makeUIRound{
    nodeA.layer.cornerRadius = 15;
    nodeB.layer.cornerRadius = 15;
    nodeC.layer.cornerRadius = 15;
    nodeD.layer.cornerRadius = 15;
    nodeE.layer.cornerRadius = 15;
    nodeF.layer.cornerRadius = 15;
    nodeG.layer.cornerRadius = 15;
    
}

-(void)addNodeToGraph{
    
    aNode = [GraphNode nodeWithIdentifier:@"A"];
    bNode = [GraphNode nodeWithIdentifier:@"B"];
    cNode = [GraphNode nodeWithIdentifier:@"C"];
    dNode = [GraphNode nodeWithIdentifier:@"D"];
    eNode = [GraphNode nodeWithIdentifier:@"E"];
    fNode = [GraphNode nodeWithIdentifier:@"F"];
    gNode = [GraphNode nodeWithIdentifier:@"G"];
    
    
    [graph addBiDirectionalEdge:[GraphEdge edgeWithName:@"A <-> B" andWeight:[NSNumber numberWithInt:1]] fromNode:aNode toNode:bNode];
    [graph addBiDirectionalEdge:[GraphEdge edgeWithName:@"B <-> C" andWeight:[NSNumber numberWithInt:1]] fromNode:bNode toNode:cNode];
    [graph addBiDirectionalEdge:[GraphEdge edgeWithName:@"C <-> D" andWeight:[NSNumber numberWithInt:1]] fromNode:cNode toNode:dNode];
    [graph addBiDirectionalEdge:[GraphEdge edgeWithName:@"D <-> E" andWeight:[NSNumber numberWithInt:1]] fromNode:dNode toNode:eNode];
    [graph addBiDirectionalEdge:[GraphEdge edgeWithName:@"C <-> F" andWeight:[NSNumber numberWithInt:1]] fromNode:cNode toNode:fNode];
    [graph addBiDirectionalEdge:[GraphEdge edgeWithName:@"F <-> G" andWeight:[NSNumber numberWithInt:1]] fromNode:fNode toNode:gNode];
}

-(void)reset{
    nodeA.backgroundColor = nodeB.backgroundColor = nodeC.backgroundColor = nodeD.backgroundColor = nodeE.backgroundColor = nodeF.backgroundColor = nodeG.backgroundColor = [UIColor blueColor];
}

- (IBAction)findRoute:(id)sender {
    
    [self reset];
    
    GraphNode *source = [[GraphNode alloc]init];
    if ([self.source.text isEqualToString:@"A"]) {
        source = aNode;
        NSLog(@"source A");
    }else if([self.source.text isEqualToString:@"B"]){
        source = bNode;
    }if ([self.source.text isEqualToString:@"C"]) {
        source = cNode;
    }else if([self.source.text isEqualToString:@"D"]){
        source = dNode;
    }if ([self.source.text isEqualToString:@"E"]) {
        source = eNode;
    }else if([self.source.text isEqualToString:@"F"]){
        source = fNode;
    }if ([self.source.text isEqualToString:@"G"]) {
        source = gNode;
    }
    
    GraphNode *destination = [[GraphNode alloc]init];
    if ([self.destination.text isEqualToString:@"A"]) {
        destination = aNode;
    }else if([self.destination.text isEqualToString:@"B"]){
        destination = bNode;
    }if ([self.destination.text isEqualToString:@"C"]) {
        destination = cNode;
    }else if([self.destination.text isEqualToString:@"D"]){
        destination = dNode;
    }if ([self.destination.text isEqualToString:@"E"]) {
        destination = eNode;
    }else if([self.destination.text isEqualToString:@"F"]){
        destination = fNode;
    }if ([self.destination.text isEqualToString:@"G"]) {
        destination = gNode;
        NSLog(@"destination G");
    }
    
    route = [graph shortestRouteFromNode:source toNode:destination];
    
    
    [self animation:0];
    
    
//    for (PESGraphRouteStep *obj in route.steps) {
//        NSLog(@"node %@",obj.node);
//        if ([obj.node isEqual:aNode]) {
//            NSLog(@"Node A");
//            nodeA.backgroundColor = [UIColor redColor];
//        }else if([obj.node isEqual:bNode]){
//            NSLog(@"Node B");
//            nodeB.backgroundColor = [UIColor redColor];
//        }if ([obj.node isEqual:cNode]) {
//            NSLog(@"Node C");
//            nodeC.backgroundColor = [UIColor redColor];
//        }else if([obj.node isEqual:dNode]){
//            NSLog(@"Node D");
//            nodeD.backgroundColor = [UIColor redColor];
//        }if ([obj.node isEqual:eNode]) {
//            NSLog(@"Node E");
//            nodeE.backgroundColor = [UIColor redColor];
//        }else if([obj.node isEqual:fNode]){
//            NSLog(@"Node F");
//            nodeF.backgroundColor = [UIColor redColor];
//        }else if([obj.node isEqual:gNode]){
//            NSLog(@"Node G");
//            nodeG.backgroundColor = [UIColor redColor];
//        }
//    }

}

-(void)animation:(NSInteger)count{
    if (count == route.count) {
        return;
    }
    GraphRouteStep *obj = route.steps[count];
  __block  NSUInteger var = count;
    [UIView animateWithDuration:0.3 delay:0.3 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        if ([obj.node isEqual:aNode]) {
            NSLog(@"Node A");
            nodeA.backgroundColor = [UIColor redColor];
        }else if([obj.node isEqual:bNode]){
            NSLog(@"Node B");
            nodeB.backgroundColor = [UIColor redColor];
        }if ([obj.node isEqual:cNode]) {
            NSLog(@"Node C");
            nodeC.backgroundColor = [UIColor redColor];
        }else if([obj.node isEqual:dNode]){
            NSLog(@"Node D");
            nodeD.backgroundColor = [UIColor redColor];
        }if ([obj.node isEqual:eNode]) {
            NSLog(@"Node E");
            nodeE.backgroundColor = [UIColor redColor];
        }else if([obj.node isEqual:fNode]){
            NSLog(@"Node F");
            nodeF.backgroundColor = [UIColor redColor];
        }else if([obj.node isEqual:gNode]){
            NSLog(@"Node G");
            nodeG.backgroundColor = [UIColor redColor];
        }
        
    } completion:^(BOOL finished) {
        var = var + 1;
        [self animation:var];
        
    }];
    
    
}

#pragma mark - UITextField Delegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    return YES;
   
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if(range.length + range.location > textField.text.length)
    {
        return NO;
    }
    
    NSUInteger newLength = [textField.text length] + [string length] - range.length;
    return newLength <= 1;
}
- (BOOL)textFieldShouldClear:(UITextField *)textField{
    return  YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
