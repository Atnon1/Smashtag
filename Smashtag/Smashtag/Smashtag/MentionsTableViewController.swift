//
//  MentionsTableViewController.swift
//  Smashtag
//
//  Created by Admin on 20.12.17.
//  Copyright © 2017 MakeY. All rights reserved.
//

import UIKit
import Twitter

class MentionsTableViewController: UITableViewController {

    var tweetInfo: Twitter.Tweet?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    
    var numberOfSections: Int {
        get {
            var count = 0
            if let tweet = tweetInfo {
                if !tweet.hashtags.isEmpty {
                    count += 1
                }
                if !tweet.media.isEmpty {
                    count += 1
                }
                if !tweet.userMentions.isEmpty {
                    count += 1
                }
                if !tweet.urls.isEmpty {
                    count += 1
                }
            }
            return count
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return numberOfSections
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tweetInfo?[getTweetDataSectionForViewSetion(section)] ?? 0
    }
    
    enum tweetData: Int {
        case images = 0, hashtag, mention, url
    }
    
    //override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
   // }
    
    func getTweetDataSectionForViewSetion(_ section: Int) -> Int {
        if let tweet = tweetInfo {
            var substructor = 0
            if numberOfSections < 4 {
                for dataNumber in 0...section {
                    if tweet[dataNumber] == 0 {
                        substructor += 1
                    }
                }
                return section - substructor
            }
        }
        return 4
    }
    
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}

extension Tweet {
    subscript(dataSection: Int) -> Int {
        switch dataSection{
        case 0: return self.media.count
        case 1: return self.hashtags.count
        case 2: return self.userMentions.count
        case 3: return self.urls.count
        default: return 0
        }
    }
}








