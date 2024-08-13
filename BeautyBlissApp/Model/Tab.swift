//
//  Tab.swift
//  BeautyBlissApp
//
//  Created by Sevde Aydın on 3.08.2024.
//

import Foundation

enum Tab: String, CaseIterable {
    case home = "Home"
    case explore = "Explore"
    case favorite = "Favorite"
    case profile = "Profile"

    var systemImage: String {
        switch self {
        case .home:
            return "house"
        case .explore:
            return "safari"
        case .favorite:
            return "heart"
        case .profile:
            return "person"
        }
    }

    var index: Int {
        return Tab.allCases.firstIndex(of: self) ?? 0
    }
}
