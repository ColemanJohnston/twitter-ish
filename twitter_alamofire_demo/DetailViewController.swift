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
        
        if(tweet.retweeted){
            retweetButton.setImage(#imageLiteral(resourceName: "retweet-icon-green"), for: UIControlState.normal)
        }
        else{
            retweetButton.setImage(#imageLiteral(resourceName: "retweet-icon"), for: UIControlState.normal)
        }
        
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
