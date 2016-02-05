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
#import "SettingsActionGroup.h"


@interface SettingsViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) SettingsLogoView *logoView;

@end

@implementation SettingsViewController

-(instancetype)init {
    self = [super init];
    
    if (self) {
        
        self.title = @"Info";
        
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        tableView.translatesAutoresizingMaskIntoConstraints = NO;
        tableView.delegate = self;
        tableView.dataSource = self;
        
        [self.view addSubview:tableView];
        
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[tableView]|" options:0 metrics:nil views:@{@"tableView": tableView}]];
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[tableView]|" options:0 metrics:nil views:@{@"tableView": tableView}]];
        
        self.logoView = [[SettingsLogoView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 300)];
        self.logoView.labelBuildNumber.text = [NSString stringWithFormat:@"Build: %@", [[NSBundle mainBundle] objectForInfoDictionaryKey: (NSString *)kCFBundleVersionKey]];
        [self.logoView.logoButton addTarget:self action:@selector(logoTapped:) forControlEvents:UIControlEventTouchUpInside];
        [self.logoView layoutIfNeeded];
        tableView.tableFooterView = self.logoView;
    }
    
    return self;
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
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    cell.textLabel.text = self.actionGroups[indexPath.section].actions[indexPath.row].name;
    return cell;
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
