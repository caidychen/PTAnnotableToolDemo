//
//  HomeViewController.m
//  FilterFrameEditDemo
//
//  Created by CHEN KAIDI on 23/6/2016.
//  Copyright © 2016 Putao. All rights reserved.
//

#import "HomeViewController.h"
#import "FilterManager.h"
#import "PTAnnotableCanvasView.h"
#import "UIImage+PTImage.h"


typedef NS_ENUM(NSInteger, FilterType){
    FilterTypeIOSBlurEffect = 0,
    FilterTypePixellateEffect = 1
};

@interface HomeViewController (){
    NSInteger filterMaskTag;
}
@property (nonatomic, strong) UIView *canvasView;
@property (nonatomic, strong) PTAnnotableCanvasView *annotableView;
@property (nonatomic, strong) UIImageView *baseImageView;
@property (nonatomic, strong) UIImage *originalImage;
@property (nonatomic, strong) UIImage *blurredImage;
@property (nonatomic, strong) UIImage *pixellatedImage;
@property (nonatomic, strong) NSMutableArray *maskArray;
@property (nonatomic, strong) UIButton *deleteButton;
@end

@implementation HomeViewController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.canvasView];
    self.originalImage = [UIImage imageNamed:@"miku.jpg"];
    self.baseImageView.image = self.originalImage;
    self.canvasView.height = self.view.width/self.originalImage.size.width*self.originalImage.size.height;
    self.baseImageView.frame = self.canvasView.bounds;
    [self.canvasView addSubview:self.baseImageView];
    [self.canvasView addSubview:self.annotableView];
    self.canvasView.center = self.view.center;
    self.blurredImage = [FilterManager IOS7BlurredEffectWithImage:self.originalImage];
    self.pixellatedImage = [FilterManager pixellateEffectWithImage:self.originalImage];
    [self.view addSubview:self.deleteButton];
    self.deleteButton.center = CGPointMake(self.view.center.x, self.view.height-self.deleteButton.height/2);
    
    [self.annotableView dropFilterMaskWithSourceImage:self.blurredImage initialFrame:CGRectMake(self.annotableView.width/2-50, self.annotableView.height/2-50, 100, 100) type:PTRectangleTypeFilterMask];
    [self.annotableView dropFilterMaskWithSourceImage:self.pixellatedImage initialFrame:CGRectMake(self.annotableView.width/2-50, self.annotableView.height/2-50, 100, 100) type:PTRectangleTypeFilterMask];
    
    //    Arrow *arrow = [[Arrow alloc] initWithFrame:self.view.bounds];
    //    [self.view addSubview:arrow];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private Methods


-(void)toggleDeleteSelectedShape{
    [self.annotableView deleteSelectedShape];
}

#pragma mark - Getters/Setters

-(NSMutableArray *)maskArray{
    if (!_maskArray) {
        _maskArray = [[NSMutableArray alloc] init];
    }
    return _maskArray;
}

-(UIView *)canvasView{
    if (!_canvasView) {
        _canvasView = [[UIView alloc] initWithFrame:self.view.bounds];
        _canvasView.clipsToBounds = YES;
    }
    return _canvasView;
}

-(PTAnnotableCanvasView *)annotableView{
    if (!_annotableView) {
        _annotableView = [[PTAnnotableCanvasView alloc] initWithFrame:self.canvasView.bounds];
    }
    return _annotableView;
}

-(UIImageView *)baseImageView{
    if (!_baseImageView) {
        _baseImageView = [[UIImageView alloc] initWithFrame:self.canvasView.bounds];
        _baseImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _baseImageView;
}

-(UIImage *)originalImage{
    if (!_originalImage) {
        _originalImage = [[UIImage alloc] init];
    }
    return _originalImage;
}

-(UIImage *)blurredImage{
    if (!_blurredImage) {
        _blurredImage = [[UIImage alloc] init];
    }
    return _blurredImage;
}

-(UIImage *)pixellatedImage{
    if (!_pixellatedImage) {
        _pixellatedImage = [[UIImage alloc] init];
    }
    return _pixellatedImage;
}

-(UIButton *)deleteButton{
    if (!_deleteButton) {
        _deleteButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 50)];
        [_deleteButton setTitle:@"Delete" forState:UIControlStateNormal];
        [_deleteButton addTarget:self action:@selector(toggleDeleteSelectedShape) forControlEvents:UIControlEventTouchUpInside];
        [_deleteButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    return _deleteButton;
}

@end
