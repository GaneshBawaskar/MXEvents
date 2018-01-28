//
//  VViewColor.m
//  MXEvents
//
//  Created by Sabertooth on 25/01/18.
//  Copyright © 2018 Ganesh Bawaskar. All rights reserved.
//

#import "ViewColor.h"

@implementation ViewColor

- (void)drawRect:(NSRect)dirtyRect {

    if ([[self identifier] isEqualToString:@"1"]) {
         [[NSColor yellowColor] setFill];
         NSRectFill(dirtyRect);
    }
    
    if ([[self identifier] isEqualToString:@"2"]) {
        [[NSColor redColor] setFill];
        NSRectFill(dirtyRect);
    }
    
    if ([[self identifier] isEqualToString:@"3"]) {
        [[NSColor greenColor] setFill];
        NSRectFill(dirtyRect);
    }
    
    if ([[self identifier] isEqualToString:@"4"]) {
        [[NSColor magentaColor] setFill];
        NSRectFill(dirtyRect);
    }
    
//    if ([[self window] firstResponder] == self)
//    {
//        NSSetFocusRingStyle(NSFocusRingOnly);
//        [[NSBezierPath bezierPathWithRect:[self bounds]] fill];
//    }
    NSLog(@"Drawing Method");
    // Drawing code here.
}

//
// Method to draw focus ring
//
-(BOOL)acceptsFirstResponder{
    if ([self.identifier isEqualToString:@"2"]) {
        return false;
    }

    NSSetFocusRingStyle(NSFocusRingOnly);
    
    //
    // Use of stroke in color/benzier path.
    //
    [[NSBezierPath bezierPathWithRect:[self bounds]] fill];
    return true;
}
-(BOOL)becomeFirstResponder{
    [self setNeedsDisplay:true];
    return true;
}
- (void)drawFocusRingMask {
    NSRectFill([self bounds]);
}
- (NSRect)focusRingMaskBounds {
    return [self bounds];
}


-(void)updateTrackingAreas{
    [super updateTrackingAreas];
    if (!TrackArea) {
         TrackArea = [[NSTrackingArea alloc] initWithRect:NSZeroRect options:NSTrackingMouseEnteredAndExited|NSTrackingActiveAlways|NSTrackingInVisibleRect owner:self userInfo:nil];
    }
    
    if (![[self trackingAreas] containsObject:TrackArea]) {
        [self addTrackingArea:TrackArea];
    }
}


-(void)mouseExited:(NSEvent *)theEvent{

   self.layer.borderWidth = 0.0;
    
    
    NSString *name = [self identifier];
    NSLog(@"Mouse Exited in %@ %f", name, self.layer.borderWidth);
}

-(void)mouseEntered:(NSEvent *)theEvent{
   [self superview].wantsLayer = true;
    if ([self.identifier isEqualToString:@"2"]) {
        self.layer.borderWidth = 2.0;
        self.layer.borderColor = [NSColor greenColor].CGColor;
        //
        //  To draw anything outside drawRect using NSBenzierPath
        //  We need to call setNeedsDisplay() method explicity to suppress
        //  graphics warning. Exp:please set CG_CONTEXT_SHOW_BACKTRACE environmental variable
        //  [self setNeedsDisplay:true];
        //  [[NSBezierPath bezierPathWithRect:[self bounds]] fill];
        //
    }
    
    NSString *name = [self identifier];
     NSLog(@"Mouse Entered in %@", name);
    
}
@end
