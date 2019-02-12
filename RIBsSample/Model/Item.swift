//
//  Item.swift
//  RIBsSample
//
//  Created by SHINGAI YOSHIMI on 2019/01/31.
//  Copyright © 2019 SHINGAI YOSHIMI. All rights reserved.
//

import Foundation

typealias Items = [Item]

struct Item: Codable {
    let renderedBody, body: String
    let coediting: Bool
    let commentsCount: Int
    let createdAt: Date
    let group: Group?
    let id: String
    let likesCount: Int
    let itemPrivate: Bool
    let reactionsCount: Int
    let tags: [Tag]
    let title: String
    let updatedAt: Date
    let url: String
    let user: User
    let pageViewsCount: Int?

    enum CodingKeys: String, CodingKey {
        case renderedBody = "rendered_body"
        case body, coediting
        case commentsCount = "comments_count"
        case createdAt = "created_at"
        case group, id
        case likesCount = "likes_count"
        case itemPrivate = "private"
        case reactionsCount = "reactions_count"
        case tags, title
        case updatedAt = "updated_at"
        case url, user
        case pageViewsCount = "page_views_count"
    }
}

struct Group: Codable {
    let createdAt: Date
    let id: Int
    let name: String
    let groupPrivate: Bool
    let updatedAt: Date
    let urlName: String

    enum CodingKeys: String, CodingKey {
        case createdAt = "created_at"
        case id, name
        case groupPrivate = "private"
        case updatedAt = "updated_at"
        case urlName = "url_name"
    }
}

struct Tag: Codable {
    let name: String
    let versions: [String]
}

struct User: Codable {
    let description: String?
    let facebookID: String?
    let followeesCount, followersCount: Int
    let githubLoginName: String?
    let id: String
    let itemsCount: Int
    let linkedinID: String?
    let location: String?
    let name: String
    let organization: String?
    let permanentID: Int
    let profileImageURL: String
    let teamOnly: Bool
    let twitterScreenName: String?
    let websiteURL: String?

    enum CodingKeys: String, CodingKey {
        case description
        case facebookID = "facebook_id"
        case followeesCount = "followees_count"
        case followersCount = "followers_count"
        case githubLoginName = "github_login_name"
        case id
        case itemsCount = "items_count"
        case linkedinID = "linkedin_id"
        case location, name, organization
        case permanentID = "permanent_id"
        case profileImageURL = "profile_image_url"
        case teamOnly = "team_only"
        case twitterScreenName = "twitter_screen_name"
        case websiteURL = "website_url"
    }
}
