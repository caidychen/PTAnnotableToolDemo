
#import "SOScrollViewAutoView.h"
#import "NSObject+SOObject.h"
#import "UIImageView+WebCache.h"

#define SCROLL_CURRENT_PAGES    3

@interface SOScrollViewAutoView () <UIScrollViewDelegate>

@property (assign, nonatomic) NSInteger totalPage;
@property (assign, nonatomic) NSInteger curPage;
@property (assign, nonatomic) CGRect scrollFrame;
@property (strong, nonatomic) UIImageView *curImageView;
@property (strong, nonatomic) NSMutableArray *curImageUrls;
@property (strong, nonatomic) NSTimer *timer;

- (NSInteger)validPageValue:(NSInteger)value;
- (void)reloadData;

- (NSArray *)getDisplayImagesWithCurpage:(NSInteger)page;

@end

@implementation SOScrollViewAutoView
@synthesize scrollView = _scrollView;

- (void)dealloc {
    SORELEASE(_curImageView);
    SORELEASE(_scrollView);
    SORELEASE(_imageUrls);
    SORELEASE(_curImageUrls);
    SORELEASE(_pageCtrl);
    SOSUPERDEALLOC();
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        self.backgroundColor = [UIColor whiteColor];
        _autoTimeInterval = 5.0f;
        _autoScroll = NO;
        _curImageUrls = [[NSMutableArray alloc] initWithCapacity:0];
        _imageUrls = [[NSArray alloc] init];
        _totalPage = self.imageUrls.count;
        _curPage = 1;
        [self addSubview:self.scrollView];
        _pageCtrl = [[UIPageControl alloc] init];
        [_pageCtrl setCurrentPageIndicatorTintColor:UIColorFromRGB(0x985ec9)];
        [self addSubview:self.pageCtrl];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.scrollView.frame = self.bounds;
    self.scrollFrame = self.scrollView.frame;
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width * SCROLL_CURRENT_PAGES, self.scrollView.frame.size.height);
    self.pageCtrl.frame = CGRectMake(0, self.bounds.size.height * 0.75f, self.bounds.size.width, self.bounds.size.height * 0.25f);
}

#pragma mark - getter
- (UIScrollView *)scrollView {
    if(!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        _scrollView.backgroundColor = [UIColor clearColor];
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.pagingEnabled = YES;
        _scrollView.delegate = self;
    }
    self.scrollFrame = _scrollView.frame;
    _scrollView.contentSize = CGSizeMake(_scrollView.frame.size.width * SCROLL_CURRENT_PAGES, _scrollView.frame.size.height);
    return (_scrollView);
}

- (NSArray *)getDisplayImagesWithCurpage:(NSInteger)page {
    NSInteger pre = [self validPageValue:_curPage - 1];
    NSInteger last = [self validPageValue:_curPage + 1];
    if([_curImageUrls count] != 0) {
        [_curImageUrls removeAllObjects];
    }
    [_curImageUrls safeAddObject:[self.imageUrls safeObjectAtIndex:pre - 1]];
    [_curImageUrls safeAddObject:[self.imageUrls safeObjectAtIndex:_curPage - 1]];
    [_curImageUrls safeAddObject:[self.imageUrls safeObjectAtIndex:last - 1]];
    return (_curImageUrls);
}

- (NSInteger)validPageValue:(NSInteger)value {
    if(value == 0) {
        value = _totalPage;
    }
    if(value == _totalPage + 1) {
        value = 1;
    }
    return (value);
}
#pragma mark -

#pragma mark - setter
- (void)setImageUrls:(NSArray *)imageUrls {
    NSMutableArray *cpImageURLs = [[NSMutableArray alloc] initWithArray:imageUrls];
    SORELEASE(_imageUrls);
    _imageUrls = cpImageURLs;
    _curPage = 1;
    _totalPage = self.imageUrls.count;
    self.pageCtrl.numberOfPages = _totalPage;
    [self reloadData];
}

- (void)setAutoScroll:(BOOL)autoScroll {
    _autoScroll = autoScroll;
    if(_autoScroll) {
        if(!self.timer) {
            self.timer = [NSTimer scheduledTimerWithTimeInterval:_autoTimeInterval target:self selector:@selector(startAutoScroll) userInfo:nil repeats:YES];
            [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
        }
    } else {
        if(self.timer) {
            [self.timer invalidate];
            self.timer = nil;
        }
    }
}

- (void)setAutoTimeInterval:(NSTimeInterval)autoTimeInterval {
    _autoTimeInterval = autoTimeInterval;
    [self setAutoScroll:_autoScroll];
}
#pragma mark -

#pragma mark - actions
- (void)startAutoScroll {
    CGSize bdSize = self.bounds.size;
    CGRect nextRect = CGRectMake(bdSize.width * (SCROLL_CURRENT_PAGES - 1), 0, bdSize.width, bdSize.height);
    [self.scrollView scrollRectToVisible:nextRect animated:YES];
    
    NSArray *subViews = [self.scrollView subviews];
    if(subViews && [subViews isKindOfClass:[NSArray class]] && [subViews count] > _curPage && _curImageUrls && [_curImageUrls count] > _curPage) {
        UIView *vw = [subViews safeObjectAtIndex:_curPage];
        NSString *urlString = [_curImageUrls safeObjectAtIndex:_curPage];
        if(vw && [vw isKindOfClass:[UIImageView class]] && urlString && [urlString isKindOfClass:[NSString class]] && [urlString length] > 0) {
            UIImageView *imgVw = (UIImageView *)vw;
            [imgVw sd_setImageWithURL:[NSURL URLWithString:urlString] placeholderImage:[UIImage imageNamed:@"img_default"]];
        }
    }
    
    if (_delegate && [_delegate respondsToSelector:@selector(autoScrollViewDelegate:didScrollImageView:)]) {
        [_delegate autoScrollViewDelegate:self didScrollImageView:_curPage];
    }
}

- (void)reloadData {
    NSArray *subViews = [self.scrollView subviews];
    if([subViews count] != 0) {
        [subViews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    }
    [self getDisplayImagesWithCurpage:_curPage];
    for (NSInteger i = 0; i < SCROLL_CURRENT_PAGES; i++) {
        id url = [_curImageUrls safeObjectAtIndex:i];
        NSURL *imgUrl = nil;
        if([url isKindOfClass:[NSString class]]) {
            imgUrl = [NSURL URLWithString:url];
        } else {
            imgUrl = (NSURL *)url;
        }
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.scrollFrame];
        imageView.backgroundColor = [UIColor whiteColor];
        imageView.userInteractionEnabled = YES;
        [imageView sd_setImageWithURL:imgUrl placeholderImage:[UIImage imageNamed:@"img_default"]];
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
        [imageView addGestureRecognizer:singleTap];
        imageView.frame = CGRectOffset(imageView.frame, self.scrollFrame.size.width * i, 0);
        [self.scrollView addSubview:imageView];
    }
    [self.scrollView setContentOffset:CGPointMake(self.scrollFrame.size.width, 0)];
    self.pageCtrl.currentPage = _curPage - 1;
}

- (void)handleTap:(UITapGestureRecognizer *)tap {
    if (_delegate && [_delegate respondsToSelector:@selector(autoScrollViewDelegate:didSelectImageView:)]) {
        [_delegate autoScrollViewDelegate:self didSelectImageView:_curPage - 1];
    }
}
#pragma mark -

#pragma mark - <UIScrollViewDelegate>
- (void)scrollViewDidScroll:(UIScrollView *)aScrollView {
    NSInteger x = aScrollView.contentOffset.x;
    if(x >= ((SCROLL_CURRENT_PAGES - 1) * self.scrollFrame.size.width)) {
        _curPage = [self validPageValue:_curPage + 1];
        [self reloadData];
    }
    if(x <= 0) {
        _curPage = [self validPageValue:_curPage - 1];
        [self reloadData];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if(self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self setAutoScroll:self.autoScroll];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)aScrollView {
    [self.scrollView setContentOffset:CGPointMake(self.scrollFrame.size.width, 0) animated:YES];
}
#pragma mark -

@end
