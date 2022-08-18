//
//  CVListViewController.swift
//  DataBindingCVWithIndicator
//
//  Created by Naga Divya Bobbara on 18/08/22.
//

import Foundation
import Alamofire
class CVListViewController{
    let viewModel  : GetPostsListViewModel
    init(viewModel : GetPostsListViewModel = GetPostsListViewModel()){
        self.viewModel = viewModel
    }
    
    func start()
    {
        viewModel.isLoading.value = true
        viewModel.isTableViewHidden.value = true
        
        viewModel.title.value = "Loading...."
        apiCall()
        
//        updatePostsApiCall(postId: viewModel.userLists.value)
    }
    func apiCall()
    {
        DispatchQueue.global().async {
            sleep(3)
            AF.request("http://stagetao.gcf.education:3000/api/v1/posts/3", method: .get, parameters: nil,headers: nil).responseDecodable(of: GetPosts.self) { response in
//                print(response)
                self.viewModel.isLoading.value = false
                self.viewModel.isTableViewHidden.value = false
                self.viewModel.title.value = " Get Posts"
                self.convertDataObjectToViewModel(response: response.value?.data ?? [])
                
               
            }
        
            
        }
    }
    func updateLikes(index:Int){
        print("index",index)
        var likeStatus = viewModel.userLists.value[index].likeStatus
        var postId = viewModel.userLists.value[index].postId
        print(likeStatus)
        print(postId)
        AF.request("http://stagetao.gcf.education:3000/api/v1/postLikes/\(postId)/3/\(!(likeStatus))", method: .put, parameters: nil, headers: nil).responseDecodable(of:UpdateLikes.self) { res in
            print(res)
        }
       
    }
    func updatePostsApiCall(postId:Int){
        print(postId)
    }
    func convertDataObjectToViewModel(response: [GetPostsData]) {
        self.viewModel.userLists.value = response.compactMap({
            CVCellViewModel(userName: $0.userName ?? "",totalLikes: $0.totalLikes ?? 0,likeStatus: ($0.likeStatus)!,postId: $0.postId ?? 0,postData: $0.postData ?? "")
        })
    }
}
