#import "ZBFireworkView.h"
#import "ZBFireworkLayer.h"

@implementation ZBFireworkView

- (void)dealloc 
{
    [super dealloc];
}

- (void)tap:(UIGestureRecognizer *)r
{
	CGPoint location = [r locationInView:self];
	CGFloat hue = [NSDate timeIntervalSinceReferenceDate] - floor([NSDate timeIntervalSinceReferenceDate]);
	ZBFireworkLayer *aLayer = [[[ZBFireworkLayer alloc] initWithHue:hue] autorelease];
	CGPoint from = CGPointMake(location.x, self.bounds.size.height - 50.0);
	CGPoint to = CGPointMake(location.x, (self.bounds.size.height - 100.0) * (random() % 100 / (CGFloat) 100));
    aLayer.zPosition = random() % 100 / 100.0f;
	[aLayer animateInLayer:self.layer from:from to:to];
}

- (void)_init
{
	self.backgroundColor = [UIColor blackColor];
	UITapGestureRecognizer *r = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
	[self addGestureRecognizer:r];
	[r release];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
	self = [super initWithCoder:aDecoder];
	if (self != nil) {
		[self _init];
	}
	return self;
}

- (id)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self != nil) {
		[self _init];
	}	
    return self;
}

- (void)drawRect:(CGRect)rect
{
	[super drawRect:rect];
	[[UIImage imageNamed:@"stars.jpg"] drawInRect:self.bounds];
	
	NSString *msg = @"Tap to fire!";
	CGRect textFrame = CGRectMake(10.0, 64+20.0, self.bounds.size.width - 20.0, 30.0);
	[[UIColor whiteColor] set];
	[msg drawInRect:textFrame withFont:[UIFont boldSystemFontOfSize:18.0] lineBreakMode:UILineBreakModeTailTruncation alignment:UITextAlignmentCenter];
	
 
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    //在这里决定视口位置，才能通过zposition产生景深
    CATransform3D perspective = CATransform3DIdentity;
    perspective.m34 = -1.0/(random()%2+1);
    NSLog(@"%f",perspective.m34 );
    // Apply the transform to a parent layer.
    self.layer.sublayerTransform = perspective;
}
- (BOOL)isAccessibilityElement
{
	return YES;
}

- (NSString *)accessibilityLabel
{
	return @"Tap to fire!";
}



@end
