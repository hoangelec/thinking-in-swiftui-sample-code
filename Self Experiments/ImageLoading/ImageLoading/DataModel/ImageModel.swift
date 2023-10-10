//
//  ImageModel.swift
//  ImageLoading
//
//  Created by Hoang Cap on 10/10/2023.
//

import Foundation
import Combine

struct ImageModel: Decodable, Identifiable {
    var id: String
    var author: String
    var width: CGFloat
    var height: CGFloat
    var url: String
    var downloadUrl: String

    enum CodingKeys: String, CodingKey {
        case id
        case author
        case width
        case height
        case url
        case downloadUrl = "download_url"
    }

}

final class DefaultImageRepository: ObservableObject {
    @Published var images: [ImageModel] = []
    @Published var error: Error?

    private let urlString = "https://picsum.photos/v2/list"
    private var url: URL {
        URL(string: urlString)!
    }

    func loadImage() {
        let request = URLRequest(url: url)

        print("loading images...")

        URLSession.shared.dataTask(with: request) { [weak self] data, _, error in
            print("Loading completed")
            guard let self = self else { return }
            if let error = error {
                print("Loading error: \(error)")
                self.error = error
            }


            if let data = data {
                do {
                    let result = try JSONDecoder().decode([ImageModel].self, from: data)
                    print("Loading success")
                    DispatchQueue.main.async {
                        self.images = result
                    }

                } catch  {
                    print("decoding error: \(error)")
                    DispatchQueue.main.async {
                        self.error = error
                    }
                }
            }
        }.resume()
    }

}
