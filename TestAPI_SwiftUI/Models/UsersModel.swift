//
//  UsersModel.swift
//  TestAPI_SwiftUI
//
//  Created by 土橋正晴 on 2020/11/14.
//

import Foundation
import Alamofire

struct UsersModel: Codable {
    
    // MARK: Properties
    
    /// リクエストするURL
    private static let url = URL(string: "http://localhost:3000/api/v1/users")
    
    /// ID
    var id: Int?
    
    /// 名前
    var name: String?
    
    /// テキスト
    var text: String?
    
    /// 画像
    var image: String?

    
    // MARK: Request
    
    /// 全ユーザー名を取得する
    /// - Parameters:
    ///   - viewController: 呼び出し元のVIewController
    ///   - callBack: getしたものを返す
    static func fetchUsers(callBack: @escaping([UsersModel], Error?) -> ()) {
        var usersModel = [UsersModel]()
        
        AF.request(url!, method: .get, headers: .none).response { response in
            

            guard response.error == nil else {
                callBack(usersModel, response.error)
                return
            }
            
            
            do {
                usersModel = try JSONDecoder().decode([UsersModel].self, from: response.data!)

            } catch {
                callBack(usersModel, error)
            }
            responsePrint(response)
            callBack(usersModel, nil)
        }
        
    }
    
    
    
    
    
    
    /// ユーザー名を作成する
    /// - Parameters:
    ///   - viewController: 呼び出し元のVIewController
    ///   - name: 登録する名前
    ///   - text: 登録するテキスト
    static func postRequest(name: String, text: String, image: String?, callBack: @escaping(AFError?) -> ()) {
        let params:[String:Any] = [
            "user":["name":name, "text":text, "image":image ?? ""]
        ]
        
        AF.request(url!, method: .post, parameters: params).response { response in
            guard response.error == nil else {
                callBack(response.error!)
                
                return
            }
            
            responsePrint(response)
            callBack(nil)
        }

    }

    
    
    /// ユーザ名を更新する
    /// - Parameters:
    ///   - viewController: 呼び出し元のVIewController
    ///   - id: ID
    ///   - name: 変更する名前
    ///   - text: 変更するテキスト
    static func putRequest(id: Int?, name: String, text: String, image: String?, callBack: @escaping(AFError?) -> ()) {
        
        guard let _id = id else {
            print("idの取得に失敗")
            return
        }
        
        let acccesURL = URL(string: String("\(url!)/\(_id)"))
        
        let params:[String:Any] = [
            "user":["name":name, "text":text, "image":image ?? ""]
        ]
        
        AF.request(acccesURL!, method: .put, parameters: params).response { response in
            
            guard response.error == nil else {
                callBack(response.error)
                
                return
            }
            
            responsePrint(response)
            callBack(nil)
            
        }
    }
    
    
    
    
    
    // MARK: Print
    
    fileprivate static func responsePrint(_ response:AFDataResponse<Data?>?) {
        
        #if DEBUG
        if let _response = response {
            print(" --------- \(String(describing: _response.response!.url!)) \(String(describing: _response.request!.httpMethod!)) response Start --------- ")
            print(_response.response!)
            print(" --------- \(String(describing: _response.response!.url!)) \(String(describing: _response.request!.httpMethod!)) response End --------- ")
        } else {
            print("NO Response")
        }
        #endif
        
    }
}



