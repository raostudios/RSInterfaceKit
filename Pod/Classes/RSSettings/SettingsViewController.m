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
#import "SwitchSettingsAction.h"
#import "NumericalSettingAction.h"

#import "SettingsActionGroup.h"
#import "SettingsHeaderView.h"
#import "SocialAction.h"
#import "LogoAction.h"

#import "SwitchActionTableViewCell.h"
#import "SliderActionTableViewCell.h"

@interface SettingsViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) SettingsLogoView *logoView;
@property (strong, nonatomic) UITableView *tableView;

@end

@implementation SettingsViewController

static NSString *CellIdentifier = @"CellIdentifier";

-(instancetype)init {
    self = [super init];
    
    if (self) {
        
        self.title = @"Info";
        
        self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
        
        self.tableView.estimatedRowHeight = 44.0;
        self.tableView.rowHeight = UITableViewAutomaticDimension;
        
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

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.actionGroups count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.actionGroups[section].actions count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SettingsAction *action =  self.actionGroups[indexPath.section].actions[indexPath.row];
    
    if ([action isKindOfClass:[AppSettingAction class]]) {
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        AppSettingAction *appAction = (AppSettingAction *)action;
        cell.textLabel.text = action.name;
        cell.imageView.image = [UIImage imageNamed:appAction.imageName];
        return cell;
        
    } else if ([action isKindOfClass:[SocialAction class]]) {
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        SocialAction *socialAction = (SocialAction *)action;
        cell.textLabel.text = socialAction.name;
        
        NSBundle *bundle = [NSBundle bundleForClass:[SettingsViewController class]];
        NSURL *bundleURL = [bundle URLForResource:@"RSInterfaceKit_RSSettings" withExtension:@"bundle"];
        
        if (bundleURL) {
            cell.imageView.image = [UIImage imageNamed:socialAction.glyphName
                                              inBundle:[NSBundle bundleWithURL:bundleURL]
                         compatibleWithTraitCollection:nil];
        }
        
        cell.imageView.tintColor = [UIColor blackColor];
        return cell;
        
    } else if ([action isKindOfClass:[LogoAction class]]) {
        LogoAction *logoAction = (LogoAction *)action;
        SettingsLogoView *logoView = [SettingsLogoView new];
        logoView.separatorInset = UIEdgeInsetsMake(0, CGRectGetWidth(self.tableView.bounds)/2.0, 0, CGRectGetWidth(self.tableView.bounds)/2.0);
        
        [logoView.logoButton setImage:[UIImage imageNamed:logoAction.logoName]
                             forState:UIControlStateNormal];
        logoView.labelBuildNumber.text = [NSString stringWithFormat:@"Build: %@", [[NSBundle mainBundle] objectForInfoDictionaryKey: (NSString *)kCFBundleVersionKey]];
        
        [logoView.logoButton addTarget:self
                                action:@selector(logoTapped:)
                      forControlEvents:UIControlEventTouchUpInside];
        [logoView layoutIfNeeded];
        return logoView;
    } else if ([action isKindOfClass:[SwitchSettingsAction class]]) {
        SwitchSettingsAction *switchAction = (SwitchSettingsAction *)action;
        SwitchActionTableViewCell *cell = [[SwitchActionTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.labelName.text = switchAction.name;
        cell.switchValue.on = [switchAction currentValue];
        [cell.switchValue addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
        return cell;
    } else if ([action isKindOfClass:[NumericalSettingAction class]]) {
        NumericalSettingAction *numericalAction = (NumericalSettingAction *)action;
        SliderActionTableViewCell *cell = [[SliderActionTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.labelName.text = numericalAction.name;
        cell.sliderValue.maximumValue = numericalAction.maximumValue.floatValue;
        cell.sliderValue.minimumValue = numericalAction.minimumValue.floatValue;
        cell.sliderValue.value = [numericalAction currentValue].floatValue;
        [cell.sliderValue addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
        return cell;
    } else {
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
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

-(void)valueChanged:(UISwitch *)sender {
    UserSettingsAction *selectedAction = [self actionForView:sender];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:selectedAction.name object:self userInfo:@{@"value": @(sender.on)}];
    [[NSUserDefaults standardUserDefaults] setBool:sender.on forKey:selectedAction.settingKey];
}

-(void)sliderValueChanged:(UISlider *)sender {
    UserSettingsAction *selectedAction = [self actionForView:sender];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:selectedAction.name object:self userInfo:@{@"value": @(sender.value)}];
    [[NSUserDefaults standardUserDefaults] setObject:@(sender.value) forKey:selectedAction.settingKey];
}

-(UserSettingsAction *) actionForView:(UIView *)view {
    
    UIView *superView = view;
    
    while (![superView isKindOfClass:[UITableViewCell class]]) {
        superView = superView.superview;
    }
    
    NSIndexPath *indexPath = [self.tableView indexPathForCell:(UITableViewCell *)superView];
    
    SettingsActionGroup *group = self.actionGroups[indexPath.section];
    UserSettingsAction *selectedAction = (UserSettingsAction *)group.actions[indexPath.item];
    return selectedAction;
}

@end
