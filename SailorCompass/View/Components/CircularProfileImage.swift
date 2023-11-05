//
//  CircularProfileImage.swift
//  SailorCompass
//
//  Created by Vadim Vinogradov on 04.11.2023.
//

//import SwiftUI
//
//struct CircularProfileImage: View {
//    let imageState: ProfileViewModel.ImageState
//
//    var body: some View {
//        // В зависимости от состояния, показываем изображение или индикатор загрузки
//        switch imageState {
//        case .empty, .loading:
//            // Показать placeholder или индикатор загрузки
//            Text("Your Profile Image")
//        case .success(let image):
//            image
//                .resizable()
//                .clipShape(Circle())
//                .overlay(Circle().stroke(Color.white, lineWidth: 4))
//        case .failure:
//            // Показать сообщение об ошибке
//            Text("Failed to load image")
//        }
//    }
//}

//#Preview {
//    CircularProfileImage(imageState: <#ProfileViewModel.ImageState#>)
//}
