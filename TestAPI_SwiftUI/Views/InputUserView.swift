//
//  InputUserView.swift
//  TestAPI_SwiftUI
//
//  Created by 土橋正晴 on 2020/11/15.
//

import SwiftUI

struct InputUserView: View {
    
    
    @Binding var name: String
    
    @Binding var text: String
    
    @Binding var imageStr: String
    
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("名前"), content: {
                    TextField("名前を入力してください", text: self.$name)
                })
                
                Section(header: Text("テキスト"), content: {
                    TextField("テキストを入力してください", text: self.$text)
                })
                
                Section(header: Text("画像"), content: {
                    Button(action: {
                        // TODO: imagePickerを表示する
                        print("imagePickerを表示する")
                    }, label: {
                        Image.setImage(imageStr: self.$imageStr.wrappedValue)
                            .resizable()
                            .frame(width: 50, height: 50)
                    })
                    
                })
                
            }
        }
    }
}

struct InputUserView_Previews: PreviewProvider {
    static var previews: some View {
        InputUserView(name: .constant(testUser[0].name ?? ""), text: .constant(testUser[0].text ?? ""), imageStr: .constant(testUser[0].image ?? ""))
    }
}
