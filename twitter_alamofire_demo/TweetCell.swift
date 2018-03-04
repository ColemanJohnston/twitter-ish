//
//  TweetCell.swift
//  twitter_alamofire_demo
//
//  Created by Charles Hieger on 6/18/17.
//  Copyright © 2017 Charles Hieger. All rights reserved.
//

import UIKit
import AlamofireImage
import Alamofire

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
            refreshData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func didTapFavorite(_ sender: Any) {
        if(tweet.favorited!){
            tweet.favorited = false
            tweet.favoriteCount! -= 1
            APIManager.shared.unfavorite(tweet) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error unfavoriting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully unfavorited the following Tweet: \n(tweet.text)")
                }
            }
        }
        else{
            tweet.favorited = true
            tweet.favoriteCount! += 1
            APIManager.shared.favorite(tweet) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error favoriting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully favorited the following Tweet: \n(tweet.text)")
                }
            }
        }
        refreshData()
    }
    
    @IBAction func didTapRetweet(_ sender: Any) {
        if(tweet.retweeted){
            tweet.retweeted = false
            tweet.retweetCount -= 1
            //call call API manager to unretweet the tweet
            APIManager.shared.unRetweet(tweet) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error unretweeting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully unretweeted the following Tweet: \n(tweet.text)")
                }
            }
        }
        else{
            tweet.retweeted = true
            tweet.retweetCount += 1
            //call API manager to retweet the tweet
            APIManager.shared.retweet(tweet) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error retweeting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully retweeted the following Tweet: \n(tweet.text)")
                }
            }
        }
        refreshData()
    }
    
    func refreshData(){
        if(tweet.favorited!){
            favoriteButton.setImage(#imageLiteral(resourceName: "favor-icon-red"), for: UIControlState.normal)
        }
        else{
            favoriteButton.setImage(#imageLiteral(resourceName: "favor-icon"), for: UIControlState.normal)
        }
        if(tweet.retweeted){
            retweetButton.setImage(#imageLiteral(resourceName: "retweet-icon-green"), for: UIControlState.normal)
        }
        else{
            retweetButton.setImage(#imageLiteral(resourceName: "retweet-icon"), for: UIControlState.normal)
        }
        
        profileImageView.af_setImage(withURL: tweet.user.profileImageUrl!)
        nameLabel.text = tweet.user.name
        screenNameAndDateLabel.text = tweet.user.screenName! + " • " + tweet.createdAtString
        tweetBodyLabel.text = tweet.text
        //numRepliesLabel = tweet.repliesCount
        numRetweetsLabel.text = String(tweet.retweetCount)
        numFavoritesLabel.text = String(tweet.favoriteCount!)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    
}
