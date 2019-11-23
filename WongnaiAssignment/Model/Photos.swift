//
//  HomeModel.swift
//  WongnaiAssignment
//
//  Created by Nuan on 22/11/2562 BE.
//  Copyright © 2562 Hathairat. All rights reserved.
//

struct Photos: Codable {
    
    let name : String?
    let description : String?
    let positiveVotesCount : Int
    let imageUrl : [String]?
    
    private enum CodingKeys : String, CodingKey {
        case name = "name"
        case description = "description"
        case positiveVotesCount = "positive_votes_count"
        case imageUrl = "image_url"
    }
    
}
