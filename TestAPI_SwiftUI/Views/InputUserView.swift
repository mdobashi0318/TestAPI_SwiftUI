//
//  InputUserView.swift
//  TestAPI_SwiftUI
//
//  Created by 土橋正晴 on 2020/11/15.
//

import SwiftUI
import Photos

struct InputUserView: View {
    
    
    @Binding var name: String
    
    @Binding var text: String
    
    @Binding var imageStr: String
    
    @State var isImagePicker = false
    
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
                        switch PHPhotoLibrary.authorizationStatus() {
                        case .authorized:
                            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                                isImagePicker.toggle()
                            }
                            
                        default:
                            PHPhotoLibrary.requestAuthorization { result in
                                if result == .authorized {
                                    isImagePicker.toggle()
                                }
                            }
                            
                        }
                        
                    }, label: {
                        Image.setImage(imageStr: self.imageStr)
                            .resizable()
                            .frame(width: 50, height: 50)
                    }).sheet(isPresented: $isImagePicker, content: {
                        ImagePicker(sourceType: .photoLibrary, imageStr: self.$imageStr)
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
