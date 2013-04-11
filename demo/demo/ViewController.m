//
//  ViewController.m
//  demo
//
//  Created by flexih on 13-4-11.
//
//

#import "ViewController.h"
#import "MazeTableView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.view.backgroundColor = [UIColor darkGrayColor];
    
    MazeTableView *tableView = [[MazeTableView alloc] initWithFrame:CGRectMake(30, 30, 260, 200) corner:20];
    
    tableView.backgroundColor = [UIColor whiteColor];
    tableView.delegate = (id)self;
    tableView.dataSource = (id)self;
    
    [self.view addSubview:tableView];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    __autoreleasing UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:0 reuseIdentifier:@"cell"];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%d", indexPath.row];
    
    return cell;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
