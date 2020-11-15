//
//  UserList.swift
//  TestAPI_SwiftUI
//
//  Created by 土橋正晴 on 2020/11/15.
//

import SwiftUI

struct UserList: View {
    
    @Binding var model: [UsersModel]?
    
    var body: some View {
        List {
            if self.model == nil || self.model?.count == 0 {
                Text("ユーザが見つかりませんでした")
            } else {
                ForEach(0..<self.model!.count, id: \.self) { row in
                    UserRow(user: .constant(self.model![row]))
                }
            }
        }
    }
    
}

struct UserList_Previews: PreviewProvider {
    static var previews: some View {
        UserList(model: .constant(testUser))
    }
}
