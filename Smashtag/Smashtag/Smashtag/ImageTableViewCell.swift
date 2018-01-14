//
//  ImageTableViewCell.swift
//  Smashtag
//
//  Created by Admin on 20.12.17.
//  Copyright © 2017 MakeY. All rights reserved.
//

import UIKit

class ImageTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    
    var profileImageURL: URL? { didSet { updateUI() } }
    
    func updateUI() {
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            if let url = self?.profileImageURL {
                if let imageData = try? Data(contentsOf: url) {
                    DispatchQueue.main.async {
                        self?.profileImageView?.image = UIImage(data: imageData)
                    }
                }
            } else {
                self?.profileImageView?.image = nil
            }
        }
        profileImageView.sizeToFit()
    }
}

