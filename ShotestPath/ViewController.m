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
@property (weak, nonatomic) IBOutlet UIButton *findRoute;

@property (weak, nonatomic) IBOutlet UITextField *source;
@property (weak, nonatomic) IBOutlet UITextField *destination;
@property (weak, nonatomic) IBOutlet UIImageView *drawImage;

@property (nonatomic, strong) UIColor *color;
@property (nonatomic, strong) NSMutableArray *pointArray;
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
@synthesize nodeA,nodeB,nodeC,nodeD,nodeE,nodeF,nodeG,findRoute;
@synthesize graph,aNode,bNode,cNode,dNode,eNode,fNode,gNode,route;


- (void)viewDidLoad {
    [super viewDidLoad];
  
    self.color = nodeA.backgroundColor;
    self.pointArray = [[NSMutableArray alloc]init];
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
  findRoute.layer.cornerRadius = 7;
    
}

-(void)addNodeToGraph{
    
    aNode = [GraphNode nodeWithIdentifier:@"A"];
    bNode = [GraphNode nodeWithIdentifier:@"B"];
    cNode = [GraphNode nodeWithIdentifier:@"C"];
    dNode = [GraphNode nodeWithIdentifier:@"D"];
    eNode = [GraphNode nodeWithIdentifier:@"E"];
    fNode = [GraphNode nodeWithIdentifier:@"F"];
    gNode = [GraphNode nodeWithIdentifier:@"G"];
    
  
  [graph addBiDirectionalEdge:[GraphEdge edgeWithName:@"G <-> A" andWeight:[NSNumber numberWithInt:3]] fromNode:gNode toNode:aNode];
  
  [graph addBiDirectionalEdge:[GraphEdge edgeWithName:@"G <-> B" andWeight:[NSNumber numberWithInt:2]] fromNode:gNode toNode:bNode];
  
  [graph addBiDirectionalEdge:[GraphEdge edgeWithName:@"G <-> E" andWeight:[NSNumber numberWithInt:9]] fromNode:gNode toNode:eNode];
  [graph addBiDirectionalEdge:[GraphEdge edgeWithName:@"A <-> B" andWeight:[NSNumber numberWithInt:1]] fromNode:aNode toNode:bNode];
  
  [graph addBiDirectionalEdge:[GraphEdge edgeWithName:@"A <-> E" andWeight:[NSNumber numberWithInt:5]] fromNode:aNode toNode:eNode];
  
  [graph addBiDirectionalEdge:[GraphEdge edgeWithName:@"A <-> C" andWeight:[NSNumber numberWithInt:3]] fromNode:aNode toNode:cNode];
  
  [graph addBiDirectionalEdge:[GraphEdge edgeWithName:@"B <-> E" andWeight:[NSNumber numberWithInt:1]] fromNode:bNode toNode:eNode];
  
  [graph addBiDirectionalEdge:[GraphEdge edgeWithName:@"B <-> D" andWeight:[NSNumber numberWithInt:5]] fromNode:bNode toNode:dNode];
  
  [graph addBiDirectionalEdge:[GraphEdge edgeWithName:@"E <-> C" andWeight:[NSNumber numberWithInt:5]] fromNode:eNode toNode:cNode];
  
  [graph addBiDirectionalEdge:[GraphEdge edgeWithName:@"E <-> D" andWeight:[NSNumber numberWithInt:3]] fromNode:eNode toNode:dNode];
  
  [graph addBiDirectionalEdge:[GraphEdge edgeWithName:@"E <-> F" andWeight:[NSNumber numberWithInt:8]] fromNode:eNode toNode:fNode];
  
  [graph addBiDirectionalEdge:[GraphEdge edgeWithName:@"C <-> F" andWeight:[NSNumber numberWithInt:7]] fromNode:cNode toNode:fNode];
  
  [graph addBiDirectionalEdge:[GraphEdge edgeWithName:@"D <-> F" andWeight:[NSNumber numberWithInt:1]] fromNode:dNode toNode:fNode];
  
  [graph addBiDirectionalEdge:[GraphEdge edgeWithName:@"C <-> D" andWeight:[NSNumber numberWithInt:2]] fromNode:cNode toNode:dNode];
  
//  
//    [graph addBiDirectionalEdge:[GraphEdge edgeWithName:@"B <-> C" andWeight:[NSNumber numberWithInt:1]] fromNode:bNode toNode:cNode];
//    [graph addBiDirectionalEdge:[GraphEdge edgeWithName:@"C <-> D" andWeight:[NSNumber numberWithInt:1]] fromNode:cNode toNode:dNode];
//    [graph addBiDirectionalEdge:[GraphEdge edgeWithName:@"D <-> E" andWeight:[NSNumber numberWithInt:1]] fromNode:dNode toNode:eNode];
//    [graph addBiDirectionalEdge:[GraphEdge edgeWithName:@"C <-> F" andWeight:[NSNumber numberWithInt:1]] fromNode:cNode toNode:fNode];
//    [graph addBiDirectionalEdge:[GraphEdge edgeWithName:@"F <-> G" andWeight:[NSNumber numberWithInt:1]] fromNode:fNode toNode:gNode];
}

-(void)reset{
  self.drawImage.image = nil;
  nodeA.backgroundColor = nodeB.backgroundColor = nodeC.backgroundColor = nodeD.backgroundColor = nodeE.backgroundColor = nodeF.backgroundColor = nodeG.backgroundColor = self.color;
}



- (IBAction)findRoute:(id)sender {
    
    [self reset];
    
    GraphNode *source = [[GraphNode alloc]init];
    if ([self.source.text isEqualToString:@"A"]) {
        source = aNode;
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
  
  for (GraphRouteStep *obj in route.steps) {
    if ([obj.node isEqual:aNode]) {
      [self.pointArray addObject: [NSValue valueWithCGPoint:nodeA.center]];
    }else if([obj.node isEqual:bNode]){
      NSLog(@"Node B");
      [self.pointArray addObject: [NSValue valueWithCGPoint:nodeB.center]];
    }if ([obj.node isEqual:cNode]) {
      NSLog(@"Node C");
     [self.pointArray addObject: [NSValue valueWithCGPoint:nodeC.center]];
    }else if([obj.node isEqual:dNode]){
      NSLog(@"Node D");
      [self.pointArray addObject: [NSValue valueWithCGPoint:nodeD.center]];
    }if ([obj.node isEqual:eNode]) {
      NSLog(@"Node E");
      [self.pointArray addObject: [NSValue valueWithCGPoint:nodeE.center]];
    }else if([obj.node isEqual:fNode]){
      NSLog(@"Node F");
     [self.pointArray addObject: [NSValue valueWithCGPoint:nodeF.center]];
    }else if([obj.node isEqual:gNode]){
      NSLog(@"Node G");
      [self.pointArray addObject: [NSValue valueWithCGPoint:nodeG.center]];
    }

  }
  
  [self drawPath];

  //  [self animation:0];
  
}


-(void)drawPath{
  
  for (int i = 0; i < self.pointArray.count-1; i++) {
    CGPoint startPoint = [[self.pointArray objectAtIndex:i] CGPointValue];
    CGPoint nextPoint = [[self.pointArray objectAtIndex:i+1] CGPointValue];
    
    UIGraphicsBeginImageContext(self.drawImage.frame.size);
    [self.drawImage.image drawInRect:CGRectMake(0, 0, self.drawImage.frame.size.width, self.drawImage.frame.size.height)];
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), 5.0);
    CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), 0.0, 0.5, 0.6, 1.0);
    CGContextBeginPath(UIGraphicsGetCurrentContext());
    CGContextMoveToPoint(UIGraphicsGetCurrentContext(), startPoint.x, startPoint.y);
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), nextPoint.x, nextPoint.y);
    CGContextStrokePath(UIGraphicsGetCurrentContext());
    self.drawImage.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
  }
  
  
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
