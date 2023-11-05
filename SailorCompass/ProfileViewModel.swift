//
//  ProfileViewModel.swift
//  SailorCompass
//
//  Created by Vadim Vinogradov on 04.11.2023.
//
//
//import PhotosUI
//import SwiftUI
//
//class ProfileViewModel: ObservableObject {
//    @Published var imageSelection: PhotosPickerItem? = nil {
//        didSet {
//            if let imageSelection {
//                let progress = loadTransferable(from: imageSelection)
//                imageState = .loading(progress)
//            } else {
//                imageState = .empty
//            }
//        }
//    }
//    @Published var imageState: ImageState = .empty
//
//    enum ImageState {
//        case empty
//        case loading(Progress)
//        case success(Image)
//        case failure(Error)
//    }
//
//    private func loadTransferable(from imageSelection: PhotosPickerItem) -> Progress {
//        return imageSelection.loadTransferable(type: ProfileImage.self) { result in
//            DispatchQueue.main.async {
//                guard imageSelection == self.imageSelection else {
//                    print("Failed to get the selected item.")
//                    return
//                }
//                switch result {
//                case .success(let profileImage?):
//                    self.imageState = .success(profileImage.image)
//                case .success(nil):
//                    self.imageState = .empty
//                case .failure(let error):
//                    self.imageState = .failure(error)
//                }
//            }
//        }
//    }
//}
//
//// Модель `ProfileImage` для работы с изображениями
//struct ProfileImage: Transferable {
//    let image: Image
//
//    static var transferRepresentation: some TransferRepresentation {
//        DataRepresentation(importedContentType: .image) { data in
//            // Здесь вам нужно выбрать соответствующую платформу
//            // Пример для UIKit:
//            guard let uiImage = UIImage(data: data) else {
//                throw TransferError.importFailed
//            }
//            let image = Image(uiImage: uiImage)
//            return ProfileImage(image: image)
//        }
//    }
//}
//
//enum TransferError: Error {
//    case importFailed
//}
