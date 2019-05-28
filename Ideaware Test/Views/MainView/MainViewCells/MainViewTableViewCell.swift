//
//  MainViewTableViewCell.swift
//  Ideaware Test
//
//  Created by Miguel Roncallo on 5/27/19.
//  Copyright © 2019 Miguel Roncallo. All rights reserved.
//

import UIKit
import Foundation

class MainViewTableViewCell: UITableViewCell {
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var usernameHandle: UILabel!
    
    @IBOutlet weak var verifiedImage: UIImageView!
    @IBOutlet weak var usernameFull: UILabel!
    
    @IBOutlet weak var networkLabel: UILabel!
    
    
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var contentImage: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(post: Post){
        
        if let user = post.author{
            
            if user.picture != nil{
                let urlString = user.picture!
                do{
                    let data = try Data(contentsOf: URL(string: urlString)!)
                    userImage.image = UIImage(data: data)
                }catch{
                    userImage.image = nil
                }
            }else{
                userImage.image = nil
            }
            
            
            usernameHandle.text = user.account != nil ? "@\(user.account!)" : ""
            usernameFull.text = user.name != nil ? user.name : ""
            verifiedImage.isHidden = !user.verified!
            usernameHandle.sizeToFit()
            usernameFull.sizeToFit()
        }
        
        if let text = post.text{
            contentLabel.text = text.plain
        }else{
            contentLabel.text = ""
        }
        contentLabel.sizeToFit()
        networkLabel.text = post.network!
        if let picture = post.attachment{
            do{
                let data = try Data(contentsOf: URL(string: picture.link!)!)
                contentImage.image = UIImage(data: data)
            }catch{
                contentImage.image = nil
            }
        }else{
            contentImage.image = nil
        }
        
        dateLabel.text = formatDate(post.date!)
    }
    
    func formatDate(_ dateString: String) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        let date = dateFormatter.date(from: dateString)!
        dateFormatter.dateFormat = "EEEE, MMM d yyyy"
        let stringFromDate = dateFormatter.string(from: date)
        return stringFromDate
    }
    
}
