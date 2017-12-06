//
//  Conversation.swift
//  ContractorApp2
//
//  Created by Zaizen Kaegyoshi on 12/6/17.
//  Copyright © 2017 Team5. All rights reserved.
//

import Foundation
import UIKit

class Conversation {
    
    //    var business: Business
    //    var project: Project
    var name: String
    var yelpID: String
    var image: UIImage?
    var conversationID: String
    
    init(name: String, convoID: String, yelpID: String, _ img: UIImage? = nil) {
        self.name = name
        
        self.yelpID = yelpID
        self.conversationID = convoID
        //        self.project = proj
    }
    
}
