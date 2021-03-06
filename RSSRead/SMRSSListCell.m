//
//  SMRSSListCell.m
//  RSSRead
//
//  Created by ming on 14-3-21.
//  Copyright (c) 2014年 starming. All rights reserved.
//

#import "SMRSSListCell.h"
#import "SMUIKitHelper.h"
#import "NSString+HTML.h"



@implementation SMRSSListCell {
    NSDateFormatter *_formatter;
    UILabel *_lbTitle;
    UILabel *_lbSummary;
    UILabel *_lbAuthor;
    UILabel *_lbDate;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        _formatter = [[NSDateFormatter alloc] init] ;
        [_formatter setDateFormat:@"MM.dd HH:mm"];
        
        self.contentView.backgroundColor = [SMUIKitHelper colorWithHexString:COLOR_BACKGROUND];
        _lbTitle = [SMUIKitHelper labelShadowWithRect:CGRectZero text:nil textColor:LIST_DARK_COLOR fontSize:LIST_BIG_FONT];
        _lbTitle.numberOfLines = 99;
        _lbTitle.lineBreakMode = NSLineBreakByCharWrapping;
        [self.contentView addSubview:_lbTitle];
        
        _lbSummary = [SMUIKitHelper labelShadowWithRect:CGRectZero text:nil textColor:LIST_LIGHT_COLOR fontSize:LIST_SMALL_FONT];
        [self.contentView addSubview:_lbSummary];
        
        _lbAuthor = [SMUIKitHelper labelShadowWithRect:CGRectZero text:nil textColor:LIST_LIGHT_COLOR fontSize:LIST_SMALL_FONT];
        [self.contentView addSubview:_lbAuthor];
        
        _lbDate = [SMUIKitHelper labelShadowWithRect:CGRectZero text:nil textColor:LIST_LIGHT_COLOR fontSize:LIST_SMALL_FONT];
        [self.contentView addSubview:_lbDate];
        
    }
    return self;
}

-(void)setRss:(RSS *)rss {
    [_lbTitle setText:rss.title];
    if (_subscribeTitle) {
        [_lbAuthor setText:[NSString stringWithFormat:@"%@ - %@",rss.author,_subscribeTitle]];
    } else {
        [_lbAuthor setText:rss.author];
    }
    
    [_lbDate setText:[_formatter stringFromDate:rss.date]];
    if ([rss.isFav isEqual:@1]) {
        _lbTitle.textColor = [SMUIKitHelper colorWithHexString:LIST_YELLOW_COLOR];
    } else if([rss.isRead  isEqual: @1]) {
        _lbTitle.textColor = [SMUIKitHelper colorWithHexString:LIST_LIGHT_COLOR];
    } else {
        _lbTitle.textColor = [SMUIKitHelper colorWithHexString:LIST_DARK_COLOR];
    }
    [_lbSummary setText:[rss.summary stringByConvertingHTMLToPlainText]];
    [self setNeedsDisplay];
}

-(void)layoutSubviews {
    [super layoutSubviews];
    CGRect rect = CGRectZero;
    rect.origin.x = 11;
    rect.origin.y = 6;
    
    //作者
    CGSize fitSize = [_lbAuthor.text sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:LIST_SMALL_FONT]}];
    rect.size = fitSize;
    _lbAuthor.frame = rect;
    
    //时间
    if (_lbDate.text) {
        fitSize = [_lbDate.text sizeWithAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:LIST_SMALL_FONT]}];
        rect.size = fitSize;
        rect.origin.x = SCREEN_WIDTH - fitSize.width - 11;
        _lbDate.frame = rect;
    }
    
    
    //标题
    rect.origin.x = _lbAuthor.frame.origin.x;
    rect.origin.y += fitSize.height + 2;
    fitSize = [_lbTitle.text boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 11*2, 99) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:LIST_BIG_FONT]} context:nil].size;
    rect.size = fitSize;
    _lbTitle.frame = rect;
    
    //简介
    rect.origin.y += fitSize.height + 2;
    fitSize = [_lbSummary.text sizeWithAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:LIST_SMALL_FONT]}];
    fitSize.width = SCREEN_WIDTH - 11*2;
    rect.size = fitSize;
    _lbSummary.frame = rect;
}

+(float)heightForRSSList:(RSS *)rss {
    float countHeight = 6;
    
    CGSize fitSize = [rss.author sizeWithAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:LIST_SMALL_FONT]}];
    countHeight += fitSize.height + 2;
    
    fitSize = [rss.title boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 11*2, 999) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:LIST_BIG_FONT]} context:nil].size;
    countHeight += fitSize.height + 2;
    
    fitSize = [rss.summary sizeWithAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:LIST_SMALL_FONT]}];
    countHeight += fitSize.height;
    
    countHeight += 8;
    return countHeight;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
