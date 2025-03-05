//
//  TabbarOptions.swift
//  NavigationDEmo
//
//  Created by Dmitrii Zverev on 3/3/2025.
//

import Foundation

enum TabbarOption: CaseIterable {
	case home
	case payments
	case rewards
	case play
}

extension TabbarOption: Identifiable {
	var id: String { String(describing: self) }
}

extension TabbarOption {
	var name: String {
		switch self {
		case .home: return "Home"
		case .payments: return "Payments"
		case .rewards: return "Rewards"
		case .play: return "Play"
		}
	}
	var iconName: String {
		switch self {
		case .home: return "house"
		case .payments: return "banknote"
		case .rewards: return "checkmark.seal"
		case .play: return "gear"
		}
	}
}
