//
//  Message.swift
//  SwiftPost
//
//  Created by David Rossouw on 2019-08-17.
//  Copyright © 2019 David Rossouw. All rights reserved.
//

import Foundation

final class Message: Codable {
    var id:Int?
    var message:String
    
    init(message: String) {
        self.message = message
    }
}
