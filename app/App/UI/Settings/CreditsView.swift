// CreditsView.swift
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

struct CreditsView: View {
    var body: some View {
        List {

            Section(header: Text("Stakeholders")) {
                Link(destination: URL(string: "https://www.instagram.com/a._visual_communication/")!) {
                    InfoRow(key: "Ambra Rubicini", value: "Designer")
                }
                
                InfoRow(key: "Daniele Monaldi", value: "Sviluppatore Android")
                InfoRow(key: "Andrea Ortolani", value: "Sviluppatore Web")
                
                InfoRow(key: "Prof.ssa Fabiola Farnese", value: "Supervisione")
                InfoRow(key: "Prof. Mauro Febi", value: "Supervisione")
            }
            
            Section(header: Text("Strumenti")) {
                Link(destination: URL(string: "https://github.com/Alamofire/Alamofire")!) {
                    InfoRow(key: "Alamofire", value: "HTTP API library")
                }
                
                Link(destination: URL(string: "https://github.com/SwiftUIX/SwiftUIX")!) {
                    InfoRow(key: "SwitUIX", value: "UI library")
                }
                
                Link(destination: URL(string: "https://github.com/LowKostKustomz/StatusAlert")!) {
                    InfoRow(key: "StatusAlert", value: "UI library")
                }
                
                Link(destination: URL(string: "https://fastlane.tools/")!) {
                    InfoRow(key: "FastLane", value: "Automation dev tool")
                }
                
                Link(destination: URL(string: "https://cocoapods.org/")!) {
                    InfoRow(key: "Cocoapods", value: "Dependency manager")
                }
            }
            
        }.listStyle(InsetGroupedListStyle())
    }
}

struct CreditsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CreditsView()
                .navigationTitle("Crediti e ringraziamenti")
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}
