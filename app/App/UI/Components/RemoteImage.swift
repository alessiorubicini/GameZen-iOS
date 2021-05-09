// RemoteImage.swift
// Copyright (C) 2021 Alessio Rubicini.
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <http://www.gnu.org/licenses/>.

import SwiftUI

struct RemoteImage: View {
    
    @StateObject var loader: Loader
    var failure: Image
    var imageType: RemoteImage.imageType
    
    init(type: RemoteImage.imageType, url: String, failure: Image = Image(systemName: "multiply.circle")) {
        _loader = StateObject(wrappedValue: Loader(url: url))
        self.failure = failure
        self.imageType = type
    }
    
    @ViewBuilder
    var body: some View {
        if loader.state == .loading {
            ProgressView()
        } else if loader.state == .failure {
            Image(systemName: "xmark.square.fill").foregroundColor(.red)
        } else {
            if let image = UIImage(data: loader.data) {
                Image(uiImage: image).resizable().aspectRatio(contentMode: .fit).frame(height: self.imageType == .card ? 150 : 210)
            } else {
                failure
            }
        }
    }
    
    class Loader: ObservableObject {
        
        var data = Data()
        @Published var state = LoadState.loading
        
        init(url: String) {
            guard let parsedURL = URL(string: url) else {
                fatalError("Invalid URL")
            }
            
            URLSession.shared.dataTask(with: parsedURL) { data, response, error in
                DispatchQueue.main.async {
                    
                    if let data = data, data.count > 0 {
                        self.data = data
                        self.state = .success
                    } else {
                        self.state = .failure
                    }
                }
            }.resume()
        }
        
    }
    
    enum LoadState {
        case loading
        case success
        case failure
    }
    
    enum imageType {
        case card
        case view
    }
}

struct RemoteImage_Previews: PreviewProvider {
    static var previews: some View {
        RemoteImage(type: .view, url: "http://localhost:8888/test/smerillo.jpg")
    }
}
