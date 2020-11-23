//
//  InputUserView.swift
//  TestAPI_SwiftUI
//
//  Created by 土橋正晴 on 2020/11/15.
//

import SwiftUI
import Photos

struct InputUserView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State var id: Int?
    
    @State var name: String = ""
    
    @State var text: String = ""
    
    @State var imageStr: String = ""
    
    @State var isImagePicker = false
    
    @State var isAlert = false
    
    @State var isUpdate = false
    
    
    var body: some View {
        NavigationView {
            List {
                nameSection
                textSection
                imageSection
                    .navigationBarItems(trailing: addButton)
                    .navigationTitle(isUpdate ? "更新" : "登録")
            }
        }
    }
}



// MARK: - UI作成

extension InputUserView {

    var addButton: some View {
        Button(action: {
            userModelAction()
        }, label: {
            Image(systemName: "plus")
        })
        .alert(isPresented: $isAlert) {
            Alert(title: Text(isUpdate ? "更新しました" : "登録しました"), dismissButton: .default(Text("閉じる")) {
                self.presentationMode.wrappedValue.dismiss()
            })
        }
        
    }
    
    
    var nameSection: some View {
        Section(header: Text("名前"), content: {
            TextField("名前を入力してください", text: self.$name)
        })
    }
    
    
    var textSection: some View {
        Section(header: Text("テキスト"), content: {
            TextField("テキストを入力してください", text: self.$text)
        })
    }
    
    
    var imageSection: some View {
        Section(header: Text("画像"), content: {
            Button(action: {
                switch PHPhotoLibrary.authorizationStatus() {
                case .authorized:
                    if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                        isImagePicker.toggle()
                    }
                    
                default:
                    PHPhotoLibrary.requestAuthorization { status in
                        if status == .authorized {
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




// MARK: - func

extension InputUserView {
    
    private func userModelAction() {
        if !isUpdate {
            UserViewModel().postUser(name: name, text: text, imageStr: imageStr, success: {
                isAlert.toggle()
            }, failure: { error in
                print(error!)
            })
        } else {
            guard let id = self.id else {
                print("idの取得失敗")
                return
            }
            UserViewModel().updateUser(id: id,
                                       name: name,
                                       text: text,
                                       imageStr: imageStr,
                                       success: {
                                        isAlert.toggle()
                                       },
                                       failure: { error in
                                        print(error!)
                                       }
            )
        }
    }
    
}



struct InputUserView_Previews: PreviewProvider {
    static var previews: some View {
        InputUserView()
    }
}
