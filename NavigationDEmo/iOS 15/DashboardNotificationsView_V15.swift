//
//  DashboardNotificationsView_V2.swift
//  NavigationDEmo
//
//  Created by Dmitrii Zverev on 3/3/2025.
//

import SwiftUI

struct DashboardNotificationsView_V15: View {
	@StateObject fileprivate var viewModel = DashboardNotificationsViewModel()

    var body: some View {
		VStack {
			switch viewModel.loadingState {
			case .loading(let notifications):
				if let notifications {
					makeBoby(notifications)
				} else {
					ProgressView()
						.frame(height: 50)
				}
			case .loaded(let notifications):
				makeBoby(notifications)
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
	
	private func makeBoby(_ notifications: [AppNotification]) -> some View {
		GroupBox("Notifications: \(notifications.count)") {
			ForEach(notifications) { notification in
				if let deepLink = notification.deepLink {
					GroupBox {
						NavigationLink {
							switch deepLink {
							case .paymentId(let id):
								PaymentPreDetailsView(paymentId: id)
							case .rewardId(let id):
								RewardPreDetailsView(rewardId: id)
							}
						} label: {
							NotificationCardView(notification)
						}
					}
				}
			}
		}
		.transition(.move(edge: .top).combined(with: .opacity).combined(with: .scale))
	}
}

#Preview {
	NavigationView {
		VStack {
			DashboardNotificationsView_V15()
			Spacer()
		}
		.padding()
	}
}
