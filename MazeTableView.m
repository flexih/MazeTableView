//
//  MazeTableView.m
//  MazeTableView
//
//  Created by flexih on 4/10/13.
//

#import "MazeTableView.h"
#import <QuartzCore/QuartzCore.h>

@interface MazeTableView ()
{
    CGFloat _corner;
    CGRect _maskBounds;
}
@end

@implementation MazeTableView

- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    return [self initWithFrame:frame corner:0];
}

- (id)initWithFrame:(CGRect)frame corner:(CGFloat)corner
{
    self = [super initWithFrame:frame style:0];
    
    if (self != nil) {
        if (corner > 0) {
            _corner = corner;
            self.layer.mask = [CAShapeLayer layer];
            self.scrollIndicatorInsets = UIEdgeInsetsMake(corner, 0, corner, 0);
        }
    }

    return self;
}

- (UIView *)indicatorView
{
    if (self.showsVerticalScrollIndicator) {
        UIView *v = [self.subviews lastObject];
        if ([v isMemberOfClass:[UIImageView class]]) {
            return v;
        }
    }
    
    return nil;
}

- (void)layoutSubviews
{
    [super layoutSubviews];

    CAShapeLayer *mask = (CAShapeLayer *)self.layer.mask;
    
    if (self.contentOffset.y < 0) {
        CGRect rect;
        rect.origin.x = rect.origin.y = 0;
        rect.size.width = self.bounds.size.width;
        rect.size.height = CGRectGetMaxY(self.bounds);//self.bounds.size.height + self.contentOffset.y;
        mask.path = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:_corner].CGPath;
        
        UIView *v = [self indicatorView];
        if (v != nil) {
            CGRect frame = v.frame;
            frame.origin.y = _corner;
            v.frame = frame;
        }

    } else if (self.contentOffset.y > self.contentSize.height - self.bounds.size.height){
        CGRect rect;
        rect.origin.x = 0;
        rect.origin.y = self.contentOffset.y;
        rect.size.width = self.bounds.size.width;
        rect.size.height = self.contentSize.height - self.contentOffset.y;
        mask.path = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:_corner].CGPath;
        
        UIView *v = [self indicatorView];
        if (v != nil) {
            CGRect frame = v.frame;
            frame.origin.y = self.contentSize.height - frame.size.height - _corner;;
            v.frame = frame;
        }

    } else {
        if (!CGRectEqualToRect(_maskBounds, self.bounds)) {
            mask.path = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:_corner].CGPath;
            _maskBounds = self.bounds;
        }
    }
}

@end