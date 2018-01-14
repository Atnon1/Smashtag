//
//  TweetTableViewCell.swift
//  Smashtag
//
//  Created by Admin on 12.12.17.
//  Copyright © 2017 MakeY. All rights reserved.
//

import UIKit
import Twitter

class TweetTableViewCell: UITableViewCell {
    @IBOutlet weak var tweetProfileImageView: UIImageView!
    @IBOutlet weak var tweetCreatedLabel: UILabel!
    @IBOutlet weak var tweetUserLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    
    var tweet : Twitter.Tweet? { didSet { updateUI() } }
    
    private func updateUI() {
        
        
        tweetTextLabel?.text = tweet?.text
        
        if tweet != nil {
            tweetTextLabel?.attributedText = attributedTextFor(tweet!, mentionTypes: [.hashtag, .userMention, .url])
        }
        
        tweetUserLabel?.text = tweet?.user.description
        
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            if let profileImageURL = self?.tweet?.user.profileImageURL {
                if let imageData = try? Data(contentsOf: profileImageURL) {
                    DispatchQueue.main.async {
                        self?.tweetProfileImageView?.image = UIImage(data: imageData)
                    }
                }
            } else {
                self?.tweetProfileImageView?.image = nil
            }
        }
        
        if let created = tweet?.created {
            let formatter = DateFormatter()
            if Date().timeIntervalSince(created) > 24*60*60 {
                formatter.dateStyle = .short
            } else {
                formatter.timeStyle = .short
            }
            tweetCreatedLabel?.text = formatter.string(from: created)
        }   else {
            tweetCreatedLabel?.text = nil
        }
    }
    
    private func attributedTextFor(_ tweet: Twitter.Tweet, mentionTypes: [mentionType]) -> NSAttributedString{
        let attributedText = NSMutableAttributedString(string: tweet.text)
        var color: UIColor
        var mentions: [Mention]
        for mentionType in mentionTypes {
            switch mentionType {
            case .hashtag:
                color = UIColor.blue
                mentions = tweet.hashtags
            case .url:
                color = UIColor.orange
                mentions = tweet.urls
            case .userMention:
                color = UIColor.green
                mentions = tweet.userMentions
            }
            for mention in mentions {
                attributedText.addAttribute("color", value: color, range: mention.nsrange)
            }
            
            
        }
        return attributedText
    }
}

private enum mentionType {
    case url, hashtag, userMention
}



