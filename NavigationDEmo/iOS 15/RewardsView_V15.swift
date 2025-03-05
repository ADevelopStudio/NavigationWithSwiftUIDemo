//
//  RewardsView_V2.swift
//  NavigationDEmo
//
//  Created by Dmitrii Zverev on 3/3/2025.
//

import SwiftUI

struct RewardsView_V15: View {
	@StateObject fileprivate var viewModel = RewardsViewModel()

	var body: some View {
		VStack {
			switch viewModel.loadingState {
			case .loading(let data):
				if let data {
					makeList(data: data)
				} else {
					ProgressView()
				}
			case .loaded(let data):
				makeList(data: data)
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
		.navigationTitle("Rewards")
	}
	
	private func makeList(data: [Reward]) -> some View {
		List(data) { reward in
			NavigationLink {
				RewardDetailsView(reward: reward)
			} label: {
				RewardCardView(reward: reward)
			}
			.tint(.primary)
		}
		.refreshable {
			Task { await viewModel.load(forceLoad: true) }
		}
	}
}


#Preview {
	NavigationView {
		RewardsView_V15()
	}
}

