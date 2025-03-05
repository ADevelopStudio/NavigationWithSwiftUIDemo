//
//  RewardsView_V2.swift
//  NavigationDEmo
//
//  Created by Dmitrii Zverev on 3/3/2025.
//

import SwiftUI

@available(iOS 16.0, *)
struct RewardsView_V16C: View {
	@EnvironmentObject var coordinator: Coordinator
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
			Button {
				coordinator.open(.reward(reward))
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


@available(iOS 16.0, *)
fileprivate struct RewardsView_V2Wrapper: View {
	@StateObject var coordinator = Coordinator()

	var body: some View {
		NavigationStack(path: $coordinator.rewardsNavigationPath) {
			RewardsView_V16C()
				.addNavigationDestinations()
		}
		.environmentObject(coordinator)
	}
}


#Preview {
	if #available(iOS 16.0, *) {
		RewardsView_V2Wrapper()
	}
}

