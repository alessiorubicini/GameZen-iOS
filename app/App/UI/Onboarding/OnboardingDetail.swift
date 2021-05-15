// OnboardingDetail.swift
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
// along with this program. If not, see <http://www.gnu.org/licenses/>.

import SwiftUI

struct OnboardingDetail: View {
    var image: String
    var title: String
    var description: String
    
    var body: some View {
        HStack(alignment: .center) {
            HStack {
                Image(systemName: image)
                    .font(.system(size: 50))
                    .frame(width: 50)
                    .foregroundColor(.bluePrimary)
                    .padding()
                
                VStack(alignment: .leading) {
                    Text(title).bold().foregroundColor(.darkBlue)
                    
                    Text(description).foregroundColor(.darkBlue)
                        .fixedSize(horizontal: false, vertical: true)
                }
            }.frame(width: 340, height: 100)
        }
    }
}

struct OnboardingDetail_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingDetail(image: "heart.fill", title: "More Personalized", description: "Top Stories picked for you and recommendations from siri.")
            .previewLayout(.sizeThatFits)
            .padding(10)
    }
}
