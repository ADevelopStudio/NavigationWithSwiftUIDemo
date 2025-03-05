//
//  DashboardRewards_V2.swift
//  NavigationDEmo
//
//  Created by Dmitrii Zverev on 3/3/2025.
//

import SwiftUI

@available(iOS 16.0, *)
struct DashboardRewardsView_V16C: View {
	@EnvironmentObject var coordinator: Coordinator
	@StateObject fileprivate var viewModel = DashboardRewardsViewModel()

	var body: some View {
		VStack {
			switch viewModel.loadingState {
			case .loading(let reward):
				if let reward {
					makeBoby(reward)
				} else {
					ProgressView()
						.frame(height: 50)
				}
			case .loaded(let reward):
				makeBoby(reward)
			case .error(let error):
				ErrorView(error: error)
					.frame(height: 50)
			}
		}
		.animation(.easeInOut, value: viewModel.loadingState.index)
		.task {
			await viewModel.load()
		}
	}
	
	private func makeBoby(_ reward: Reward) -> some View {
		GroupBox("Last reward:") {
			GroupBox {
				Button {
					coordinator.open(.reward(reward))
				} label: {
					RewardCardView(reward: reward)
				}
				.tint(.primary)
			}
			GroupBox {
				Button {
					coordinator.switchTo(.rewards)
				} label: {
					HStack {
						Text("See  all")
						Spacer()
					}
				}
				.tint(.primary)
			}
		}
		.transition(.move(edge: .top).combined(with: .opacity).combined(with: .scale))
	}
}

#Preview {
	if #available(iOS 16.0, *) {
		DashboardRewardsView_V16C()
	} 
}
