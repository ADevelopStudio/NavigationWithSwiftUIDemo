//
//  RewardPreDetailsView.swift
//  NavigationDEmo
//
//  Created by Dmitrii Zverev on 3/3/2025.
//

import SwiftUI

struct RewardPreDetailsView: View {
	@StateObject fileprivate var viewModel: RewardPreDetailsViewModel
	
	init(rewardId: String) {
		_viewModel = StateObject(wrappedValue: RewardPreDetailsViewModel(rewardId: rewardId))
	}

	var body: some View {
		VStack {
			switch viewModel.rewardLoadingState {
			case .loading(let reward):
				if let reward {
					RewardDetailsView(reward: reward)
				} else {
					ProgressView("Loading reward \(viewModel.rewardId)")
				}
			case .loaded(let reward):
				RewardDetailsView(reward: reward)
			case .error(let error):
				ErrorView(error: error)
				Button("Refresh") {
					Task { await viewModel.load(forceLoad: true) }
				}
			}
		}
		.task {
			await viewModel.load()
		}
	}
}

#Preview {
	RewardPreDetailsView(rewardId: "123")
}
