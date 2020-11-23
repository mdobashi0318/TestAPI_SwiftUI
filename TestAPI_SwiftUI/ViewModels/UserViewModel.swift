//
//  UserViewModel.swift
//  TestAPI_SwiftUI
//
//  Created by 土橋正晴 on 2020/11/14.
//

import Foundation


class UserViewModel: ObservableObject {

    @Published var model: [UsersModel] = []
    
    init() {
        fetchAllUser()
    }
   
    func fetchAllUser() {
        
        UsersModel.fetchUsers() { result, error in
            
            if let _error = error {
                print("Error: \(_error)")
                self.model = []
                return
            }
            
            self.model = result
        }
    }
    
    
    func fetchUser(id: Int?, success: @escaping(UsersModel)->()) {
        
        guard let _id = id else {
            return
        }
        UsersModel.fetchUsers() { result, error in
            
            if let _error = error {
                print("Error: \(_error)")
                self.model = []
                return
            }
            
            success(result.filter { $0.id == _id }.first!)
        }
    }
    
    
    func postUser(name: String, text: String, imageStr: String, success: @escaping()->(), failure: @escaping(String?)->()) {
        
        if name == "" {
            failure("名前が入力されていません")
            return
        }
        
        if text == "" {
            failure("テキストが入力されていません")
            return
        }
        
        
        UsersModel.postRequest(name: name, text: text, image: imageStr) { error in
            if error != nil {
                failure("エラーが発生しました")
                return
            }
            success()
        }
    }
    
    
    func updateUser(id: Int, name: String, text: String, imageStr: String, success: @escaping()->(), failure: @escaping(String?)->()) {
        
        if name == "" {
            failure("名前が入力されていません")
            return
        }
        
        if text == "" {
            failure("テキストが入力されていません")
            return
        }
        
        
        UsersModel.putRequest(id: id, name: name, text: text, image: imageStr) { error in
            if error != nil {
                failure("エラーが発生しました")
                return
            }
            success()
        }
    }
    
    
}
