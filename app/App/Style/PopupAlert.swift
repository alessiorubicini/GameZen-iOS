// PopupAlert.swift
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

import Foundation
import StatusAlert

/// Show a blurred alert like Apple's default apps
/// It's used to display succesfull operations alerts to the user
/// - Parameters:
///   - icon: Apple SF Symbol's icon name
///   - title: alert title
///   - message: alert text description
func showStatusAlert(icon: String, title: String, message: String) {
    
    // Creating StatusAlert instance
    let statusAlert = StatusAlert()
    statusAlert.image = UIImage(systemName: icon)
    statusAlert.title = title
    statusAlert.message = message

    // Presenting created instance
    statusAlert.showInKeyWindow()
}
