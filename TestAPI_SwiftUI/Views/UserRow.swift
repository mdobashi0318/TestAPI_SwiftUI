//
//  UserRow.swift
//  TestAPI_SwiftUI
//
//  Created by 土橋正晴 on 2020/11/15.
//

import SwiftUI

struct UserRow: View {
    
    @Binding var user: UsersModel
        
    var body: some View {
        HStack {
            Image.setImage(imageStr: user.image)
                .resizable()
                .frame(width: 50, height: 50)

            VStack(alignment: .leading) {
                    Text(user.name ?? "")
                    Text(user.text ?? "")
            }
        }
    }
}

struct UserRow_Previews: PreviewProvider {
    static var previews: some View {
        UserRow(user: .constant(testUser[0]))
            .previewLayout(.fixed(width: UIScreen.main.bounds.width, height: 60))
    }
}

