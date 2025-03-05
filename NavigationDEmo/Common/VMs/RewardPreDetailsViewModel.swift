//
//  RewardPreDetailsViewModel.swift
//  NavigationDEmo
//
//  Created by Dmitrii Zverev on 3/3/2025.
//

import Foundation

@MainActor
class RewardPreDetailsViewModel: NSObject, ObservableObject {
	@Published var rewardLoadingState: LoadingState<Reward> = .loading()

	private var isLoaded = false
	var rewardId: String
	var connectionManager: ConnectionManager
	
	init(rewardId: String, connectionManager: ConnectionManager = ConnectionManagerMock.shared) {
		self.rewardId = rewardId
		self.connectionManager = connectionManager
	}

	
	func load(forceLoad: Bool = false ) async {
		if isLoaded && !forceLoad { return }
		isLoaded = true
		rewardLoadingState = .loading(rewardLoadingState.currentValue)
		do {
			let data = try await connectionManager.getRewardDetails(rewardId: rewardId)
			rewardLoadingState = .loaded(data)
		} catch {
			rewardLoadingState = .error(error)
		}
	}
}
