//
//  MessageTableViewCell.swift
//  FirebaseChat
//
//  Created by Kelvin Tan on 8/3/18.
//  Copyright © 2018 Kelvin Tan. All rights reserved.
//

import UIKit

class MessageTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var messageTextView: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        messageTextView.sizeToFit()
        messageTextView.layer.cornerRadius = 15
        messageTextView.isScrollEnabled = false
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    func setChat(chat: Chat) {
        nameLabel.text = chat.name
        messageTextView.text = chat.message
        
    }

}
