//
//  MusicTabbarVC.m
//  MusicColorfulBox
//
//  Created by jp on 2017/3/3.
//  Copyright © 2017年 Sancochip. All rights reserved.
//

#import "MusicTabbarVC.h"



#define RowHeight ScreenHeight*0.07

@interface MusicTabbarVC ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation MusicTabbarVC
{
    NSMutableArray *_chooseModeTableViewArr;
    UITableViewCell *selectedCell;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initTableViewData];
    [self initTableView];
    
}



#pragma mark -  ChooseModeTableView

-(void)initTableViewData{
    
    
    _chooseModeTableViewArr = [NSMutableArray arrayWithObjects:@"本地音乐",@"TF卡音乐",@"云音乐", nil];
    
}




-(void)initTableView{
    
    _chooseModeTableView = [[UITableView alloc] initWithFrame:CGRectMake(ScreenWidth * 0.6, 70, ScreenWidth*0.39, RowHeight * _chooseModeTableViewArr.count+10)];
    _chooseModeTableView.delegate = self;
    _chooseModeTableView.dataSource = self;
    _chooseModeTableView.rowHeight = RowHeight;
    _chooseModeTableView.backgroundColor = [UIColor clearColor];
    _chooseModeTableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"下拉菜单底背景"]];
    _chooseModeTableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _chooseModeTableView.width, 10)];
    _chooseModeTableView.scrollEnabled = NO;
    _chooseModeTableView.hidden = YES;
    [_chooseModeTableView setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
    [_chooseModeTableView setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
    

    
    [self.view addSubview:_chooseModeTableView];
    
    
    [self tableView:_chooseModeTableView didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    
}





-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return  _chooseModeTableViewArr.count;
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [_chooseModeTableView dequeueReusableCellWithIdentifier:@"musicCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"musicCell"];
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    
    return cell;
    
}









-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    cell.textLabel.text = _chooseModeTableViewArr[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:16];
    
    
    
    if (ScreenWidth == 320) {
        cell.textLabel.font = [UIFont systemFontOfSize:11.5];
    }
    cell.imageView.image = [UIImage imageNamed:_chooseModeTableViewArr[indexPath.row]];
    
    
   
    
}




-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (selectedCell != [tableView cellForRowAtIndexPath:indexPath]) {
        
        
        selectedCell = [tableView cellForRowAtIndexPath:indexPath];
        NSString *selectedStr = selectedCell.textLabel.text;
        self.navigationItem.title = selectedStr;
        
        
        self.delegate = self.selectedViewController;
//        if ([self.delegate conformsToProtocol:@protocol(MusicTabbarVCDelegate) ]) {
//            [self.delegate pausePlayingMusic];
//        }
        
        
        if ([selectedStr isEqualToString:@"本地音乐"]) {
            self.selectedIndex = 0;
            
        }else if ([selectedStr isEqualToString:@"TF卡音乐"]){
            self.selectedIndex = 1;
        }else{
            self.selectedIndex = 2;
        }
        
        
        
    }
    
    _chooseModeTableView.hidden = YES;
    
}




- (IBAction)showMusicModeViewClick:(UIBarButtonItem *)sender {
    
    _chooseModeTableView.hidden = _chooseModeTableView.hidden?NO:YES;
}









-(void)setSelectedIndex:(NSUInteger)selectedIndex{
    
    [super setSelectedIndex:selectedIndex];
    
    self.tabBar.hidden = YES;
    
}


@end
