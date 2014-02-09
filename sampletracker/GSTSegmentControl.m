//
//  GSTSegmentControll.m
//  sampletracker
//
//  Created by Ondrej Fabian on 09/02/2014.
//  Copyright (c) 2014 Galaxy. All rights reserved.
//

#import "GSTSegmentControl.h"

@implementation GSTSegmentControl

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    NSInteger previousSelectedSegmentIndex = self.selectedSegmentIndex;
    [super touchesEnded:touches withEvent:event];
    if (previousSelectedSegmentIndex == self.selectedSegmentIndex) {
        [self sendActionsForControlEvents:UIControlEventValueChanged];
    }
}

@end
