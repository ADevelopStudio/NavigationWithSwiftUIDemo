//
//  CoordinatorNavigatorPath.swift
//  NavigationDEmo
//
//  Created by Dmitrii Zverev on 3/3/2025.
//

import Foundation

enum DeepLink: Hashable {
	case paymentId(id: String)
	case rewardId(id: String)
}

enum CoordinatorNavigatorPath: Hashable {
	case payment(Payment)
	case reward(Reward)
	case needToLoad(DeepLink)
}

extension CoordinatorNavigatorPath: Identifiable {
	var id: String { String(describing: self) }
}
