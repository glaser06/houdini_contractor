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
    var projectName: String = ""
    var contractorID: String
    var userID: String
    var userName: String = ""
    var quoteID: String = ""
    var scheduleID: String = ""
    
    init(name: String, convoID: String, yelpID: String, _ img: UIImage? = nil, cID: String, uid: String) {
        self.name = name
        
        self.yelpID = yelpID
        self.conversationID = convoID
        self.contractorID = cID
        self.userID = uid
        //        self.project = proj
    }
    
}
