//
//  Model.swift
//  DataBindingCVWithIndicator
//
//  Created by Naga Divya Bobbara on 18/08/22.
//

import Foundation
struct GetPosts:Codable{
    let status : String?
    let data : [GetPostsData]?
}
struct GetPostsData:Codable{
    let userName : String?
    let postId : Int?
    let totalLikes : Int?
    let likeStatus : Bool?
    let postData : String?
}
struct UpdateLikes : Codable{
    let status : String?
    let message : String?
    let data : UpdateLikesData?
}
struct UpdateLikesData : Codable{
    let likeStatus : String?
    let count : String?
}

