//
//  DetailViewController.swift
//  twitter_alamofire_demo
//
//  Created by Coleman on 3/10/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screennameLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var tweetBodyLabel: UILabel!
    @IBOutlet weak var dateTimeLabel: UILabel!
    @IBOutlet weak var numRetweetsLabel: UILabel!
    @IBOutlet weak var numFavoritesLabel: UILabel!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    
    var tweet: Tweet!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = tweet.user.name
        screennameLabel.text = tweet.user.screenName
        tweetBodyLabel.text = tweet.text
        dateTimeLabel.text = tweet.createdAtString
        numRetweetsLabel.text = String(describing: tweet.retweetCount)
        numFavoritesLabel.text = String(describing: tweet.favoriteCount!)
        profileImageView.af_setImage(withURL: tweet.user.profileImageUrl!)
        refreshRetweeted()
        refreshFavorited()
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
        refreshRetweeted()
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
        refreshFavorited()
    }
    
    func refreshRetweeted(){
        if(tweet.retweeted){
            retweetButton.setImage(#imageLiteral(resourceName: "retweet-icon-green"), for: UIControlState.normal)
        }
        else{
            retweetButton.setImage(#imageLiteral(resourceName: "retweet-icon"), for: UIControlState.normal)
        }
    }
    
    func refreshFavorited(){
        if(tweet.favorited!){
            favoriteButton.setImage(#imageLiteral(resourceName: "favor-icon-red"), for: UIControlState.normal)
        }
        else{
            favoriteButton.setImage(#imageLiteral(resourceName: "favor-icon"), for: UIControlState.normal)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
