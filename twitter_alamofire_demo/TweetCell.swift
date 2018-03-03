//
//  TweetCell.swift
//  twitter_alamofire_demo
//
//  Created by Charles Hieger on 6/18/17.
//  Copyright © 2017 Charles Hieger. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screenNameAndDateLabel: UILabel!
    @IBOutlet weak var tweetBodyLabel: UILabel!
    @IBOutlet weak var numRepliesLabel: UILabel!
    @IBOutlet weak var numRetweetsLabel: UILabel!
    @IBOutlet weak var numFavoritesLabel: UILabel!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    
    
    var tweet: Tweet! {
        didSet {
            //profileImageView.af_setImage(withURL: tweet.user.profileImageUrl)
            nameLabel.text = tweet.user.name
            screenNameAndDateLabel.text = tweet.user.screenName! + " • " + tweet.createdAtString
            tweetBodyLabel.text = tweet.text
            //numRepliesLabel = tweet.repliesCount
            numRetweetsLabel.text = String(tweet.retweetCount)
            numFavoritesLabel.text = String(tweet.favoriteCount!)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func didTapFavorite(_ sender: Any) {
        //tweet.favorited = true
        //tweet.favoriteCount! += 1
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    
}
