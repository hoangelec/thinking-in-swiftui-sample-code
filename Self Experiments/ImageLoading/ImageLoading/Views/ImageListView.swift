//
//  ImageListView.swift
//  ImageLoading
//
//  Created by Hoang Cap on 10/10/2023.
//

import SwiftUI

struct ImageListView: View {
    @ObservedObject var imageRepository = DefaultImageRepository()

    var body: some View {
        NavigationView {
            Group {
                if imageRepository.images.isEmpty {
                    ProgressView()
                } else {
                    List(imageRepository.images) { image in
                        NavigationLink {
                            AsyncImage(url: URL(string: image.downloadUrl),
                                       transaction: Transaction(animation: .default)) { phase in
                                switch phase {
                                case .empty:
                                    ProgressView()
                                case .success(let image):
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .transition(.move(edge: .leading))
                                case .failure:
                                    Image(systemName: "wifi.slash")
                                @unknown default:
                                    EmptyView()
                                }
                            }
                        } label: {
                            Text("id is: \(image.id)")
                        }

                    }

                }
            }
            .navigationTitle("Images")
        }

        .onAppear {
            imageRepository.loadImage()
        }
    }
}

struct ImageListView_Previews: PreviewProvider {
    static var previews: some View {
        ImageListView()
    }
}
