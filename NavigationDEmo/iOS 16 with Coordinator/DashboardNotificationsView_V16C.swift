//
//  DashboardNotificationsView_V2.swift
//  NavigationDEmo
//
//  Created by Dmitrii Zverev on 3/3/2025.
//

import SwiftUI

@available(iOS 16.0, *)
struct DashboardNotificationsView_V16C: View {
	@EnvironmentObject var coordinator: Coordinator
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
				GroupBox {
					Button {
						if let deepLink = notification.deepLink {
							coordinator.open(.needToLoad(deepLink))
						}
					} label: {
						NotificationCardView(notification)
					}
				}
			}
		}
		.transition(.move(edge: .top).combined(with: .opacity).combined(with: .scale))
	}
}

#Preview {
	if #available(iOS 16.0, *) {
		NavigationView {
			VStack {
				DashboardNotificationsView_V16C()
				Spacer()
			}
				.padding()
		}
	}
}
