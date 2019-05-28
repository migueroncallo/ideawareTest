//
//  Post.swift
//  Ideaware Test
//
//  Created by Miguel Roncallo on 5/27/19.
//  Copyright © 2019 Miguel Roncallo. All rights reserved.
//

import Foundation

struct Post: Codable{
    var author: Author?
    var date: String?
    var link: String?
    var text: Text?
    var attachment: Picture?
    var network: String?
    
    private enum postsEncodingKeys: String, CodingKey{
        case author
        case date
        case link
        case network
        case text
        case attachment
    }
    
    init(from decoder: Decoder) throws{
        let container = try decoder.container(keyedBy: postsEncodingKeys.self)
        
        self.author = try container.decodeIfPresent(Author.self, forKey: .author)
        self.date = try container.decodeIfPresent(String.self, forKey: .date)
        self.link = try container.decodeIfPresent(String.self, forKey: .link)
        self.text = try container.decodeIfPresent(Text.self, forKey: .text)
        self.attachment = try container.decodeIfPresent(Picture.self, forKey: .attachment)
        self.network = try container.decodeIfPresent(String.self, forKey: .network)
        
    }
}

struct Text: Codable{
    var plain: String!
}

struct Picture: Codable{
    var link: String?
    
    private enum picturEncodingKeys: String, CodingKey{
        case link = "picture-link"
    }
    
    init(from decoder: Decoder) throws{
        let container = try decoder.container(keyedBy: picturEncodingKeys.self)
        link = try container.decode(String.self, forKey: .link)
    }
}
//{
//    author: {
//        account: "fina1908",
//        is-verified: true,
//        name: "FINA",
//        picture-link: "https://pbs.twimg.com/profile_images/1080783555037401088/Jrt4blMM_normal.jpg"
//    },
//    date: "2018-11-17T12:10:50+00:00",
//    link: "https://twitter.com/fina1908/status/1063766410948689921",
//    text: {
//        markup: [
//        {
//        length: 5,
//        location: 45,
//        link: "https://twitter.com/hashtag/FINA?src=hash"
//        },
//        {
//        length: 6,
//        location: 51,
//        link: "https://twitter.com/hashtag/SWC18?src=hash"
//        },
//        {
//        length: 9,
//        location: 58,
//        link: "https://twitter.com/hashtag/Swimming?src=hash"
//        },
//        {
//        length: 11,
//        location: 79,
//        link: "https://twitter.com/hashtag/4x50Medley?src=hash"
//        },
//        {
//        length: 7,
//        location: 91,
//        link: "https://twitter.com/speedo"
//        },
//        {
//        length: 13,
//        location: 99,
//        link: "https://twitter.com/omegawatches"
//        },
//        {
//        length: 26,
//        location: 113,
//        link: "https://t.co/bdwovAff8F"
//        }
//        ],
//        plain: "FINA Swimming World Cup 2018 - Singapore 🇸🇬 #FINA #SWC18 #Swimming 🏊🏻‍♂️🏊🏻‍♀️ #4x50Medley @speedo @omegawatches pic.twitter.com/bdwovAff8F"
//    },
//    attachment: {
//        picture-link: "https://pbs.twimg.com/media/DsNB5F-XgAEbSyM.jpg:large",
//        width: 1080,
//        height: 1080
//    },
//    network: "twitter"
//}
