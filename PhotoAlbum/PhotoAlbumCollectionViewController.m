//
//  PhotoAlbumViewController.m
//  PhotoAlbum
//
//  Created by Akinbiyi Lalude on 6/10/13.
//  Copyright (c) 2013 Akinbiyi Lalude. All rights reserved.
//

#import "PhotoAlbumCollectionViewController.h"
#import "PhotoAlbumLayout.h"

@interface PhotoAlbumCollectionViewController ()

@property (nonatomic, weak) IBOutlet PhotoAlbumLayout *photoAlbumLayout;

@end

@implementation PhotoAlbumCollectionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.collectionView.backgroundColor = [UIColor colorWithWhite:0.25f alpha:1.0f];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
