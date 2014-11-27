//
//  GKAutocompleteViewController.m
//  GoogleKitDemo
//
//  Created by Max Sokolov on 12/11/14.
//  Copyright (c) 2014 Max Sokolov. All rights reserved.
//

#import "GKAutocompleteViewController.h"
#import "GKPlaceAutocompleteQuery.h"

@interface GKAutocompleteViewController ()

@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, strong) UITextField *textField;

@end

@implementation GKAutocompleteViewController

- (void)viewDidLoad {

    [super viewDidLoad];
    
    self.title = @"Autocomplete";

    self.textField = [[UITextField alloc] initWithFrame:CGRectMake(20.0f, 0.0f, self.view.frame.size.width - 50.0f, 50.0f)];
    self.textField.autocorrectionType = UITextAutocorrectionTypeNo;
    [self.textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    self.tableView.tableHeaderView = self.textField;
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
}

- (void)viewDidAppear:(BOOL)animated {

    [super viewDidAppear:animated];
    [self.textField becomeFirstResponder];
}

- (void)textFieldDidChange:(UITextField *)textField {

    GKPlaceAutocompleteQuery *query = [GKPlaceAutocompleteQuery query];
    query.input = textField.text;
    query.coordinate = CLLocationCoordinate2DMake(55.738407f, 37.612306f); // New York City
    query.types = @[ @"geocode" ];
    query.radius = 10000;
    [query fetchPlaces:^(NSArray *results, NSError *error) {

        self.dataSource = [NSArray arrayWithArray:results];
        [self.tableView reloadData];
    }];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    GKPlaceAutocomplete *place = [self.dataSource objectAtIndex:indexPath.row];
    GKPlaceAutocompleteTerm *term = [place.terms firstObject];

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.textLabel.text = term.value;
    
    return cell;
}

@end