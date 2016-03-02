//
//  SettingsViewController.m
//  Preset
//
//  Created by Venkat Rao on 2/3/16.
//  Copyright © 2016 Venkat Rao. All rights reserved.
//

#import "SettingsViewController.h"
#import "SettingsLogoView.h"
#import "SettingsActionGenerator.h"
#import "SettingsAction.h"
#import "AppSettingAction.h"

#import "SettingsActionGroup.h"
#import "SettingsHeaderView.h"

@interface SettingsViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) SettingsLogoView *logoView;
@property (strong, nonatomic) UITableView *tableView;

@end

@implementation SettingsViewController

-(instancetype)init {
    self = [super init];
    
    if (self) {
        
        self.title = @"Info";
        
        self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        
        [self.view addSubview:self.tableView];
        
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[tableView]|"
                                                                          options:0
                                                                          metrics:nil
                                                                            views:@{@"tableView": self.tableView}]];
        
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[tableView]|"
                                                                          options:0 metrics:nil
                                                                            views:@{@"tableView": self.tableView}]];
        
        self.logoView = [[SettingsLogoView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 300)];
        self.logoView.labelBuildNumber.text = [NSString stringWithFormat:@"Build: %@", [[NSBundle mainBundle] objectForInfoDictionaryKey: (NSString *)kCFBundleVersionKey]];
        [self.logoView.logoButton addTarget:self
                                     action:@selector(logoTapped:)
                           forControlEvents:UIControlEventTouchUpInside];
        [self.logoView layoutIfNeeded];
        self.tableView.tableFooterView = self.logoView;
    }
    
    return self;
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self updateHeaderForSize:self.view.bounds.size];
}

-(void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    [self updateHeaderForSize:size];
}

-(void) updateHeaderForSize:(CGSize)size {
    if ([self.appDescription length] > 0 || self.appLogo) {
        SettingsHeaderView *headerView = [[SettingsHeaderView alloc] initWithFrame:CGRectZero];
        headerView.text = self.appDescription;
        headerView.imageLogo = self.appLogo;
        headerView.frame = [headerView frameForHeaderForMaxWidth:size.width];
        self.tableView.tableHeaderView = headerView;
    } else {
        self.tableView.tableHeaderView = nil;
    }
}

-(void)setImageLogo:(UIImage *)imageLogo {
    [self.logoView.logoButton setImage:[imageLogo imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]
                              forState:UIControlStateNormal];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.actionGroups count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.actionGroups[section].actions count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SettingsAction *action =  self.actionGroups[indexPath.section].actions[indexPath.row];

    if ([action isKindOfClass:[AppSettingAction class]]) {
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
        AppSettingAction *appAction = (AppSettingAction *)action;
        cell.textLabel.text = action.name;
        cell.imageView.image = [UIImage imageNamed:appAction.imageName];
        return cell;
        
    } else {
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
        cell.textLabel.text = action.name;
        return cell;
    }
    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.actionGroups[indexPath.section].actions[indexPath.row].action) {
        self.actionGroups[indexPath.section].actions[indexPath.row].action();
    }

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return self.actionGroups[section].name;
}

-(void)logoTapped:(UIButton *)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.raostudios.com"]];
}


@end
