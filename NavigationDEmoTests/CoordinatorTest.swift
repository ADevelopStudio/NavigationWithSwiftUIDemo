//
//  CoordinatorTest.swift
//  NavigationDEmoTests
//
//  Created by Dmitrii Zverev on 5/3/2025.
//

import Testing
@testable import NavigationDEmo

struct CoordinatorTest {
	
	@Test func fullFlowTest() async throws {
		let coordinator = await Coordinator()
		await #expect(coordinator.selectedTab == .home)
		await #expect(coordinator.homeNavigationPath.isEmpty)
		await #expect(coordinator.paymentsNavigationPath.isEmpty)
		await #expect(coordinator.rewardsNavigationPath.isEmpty)
		await #expect(coordinator.playNavigationPath.isEmpty)
		await #expect(coordinator.popover == nil)
		
		// Open Reward in Rewards tab (staying in same tab)
		await coordinator.open(.reward(.example), in: .rewards)
		
		await #expect(coordinator.selectedTab == .home)
		await #expect(coordinator.homeNavigationPath.isEmpty)
		await #expect(coordinator.paymentsNavigationPath.isEmpty)
		await #expect(coordinator.rewardsNavigationPath.count == 1)
		await #expect(coordinator.playNavigationPath.isEmpty)
		await #expect(coordinator.popover == nil)
		
		// Open Payment in Rewards tab and moving to Rewards
		await coordinator.open(.reward(.example), in: .rewards, needToOpenTabIfDifferent: true)
		
		await #expect(coordinator.selectedTab == .rewards)
		await #expect(coordinator.homeNavigationPath.isEmpty)
		await #expect(coordinator.paymentsNavigationPath.isEmpty)
		await #expect(coordinator.rewardsNavigationPath.count == 2)
		await #expect(coordinator.playNavigationPath.isEmpty)
		await #expect(coordinator.popover == nil)
		
		// popToRoot
		await coordinator.popToRoot()
		
		await #expect(coordinator.selectedTab == .rewards)
		await #expect(coordinator.homeNavigationPath.isEmpty)
		await #expect(coordinator.paymentsNavigationPath.isEmpty)
		await #expect(coordinator.rewardsNavigationPath.isEmpty)
		await #expect(coordinator.playNavigationPath.isEmpty)
		await #expect(coordinator.popover == nil)
		
		//Open 3 Payments in Home (staying in Rewards)
		await coordinator.open(.payment(.example), in: .home)
		await coordinator.open(.payment(.example), in: .home)
		await coordinator.open(.payment(.example), in: .home)

		await #expect(coordinator.selectedTab == .rewards)
		await #expect(coordinator.homeNavigationPath.count == 3)
		await #expect(coordinator.paymentsNavigationPath.isEmpty)
		await #expect(coordinator.rewardsNavigationPath.isEmpty)
		await #expect(coordinator.playNavigationPath.isEmpty)
		await #expect(coordinator.popover == nil)
		
		// Switching to home
		await coordinator.switchTo(.home)
		await #expect(coordinator.selectedTab == .home)
		
		// Go back twice
		await coordinator.back(steps: 2)
		await #expect(coordinator.homeNavigationPath.count == 1)
		
		// Go back twice again. even though it's only one element in homeNavigationPath
		await coordinator.back(steps: 2)
		await #expect(coordinator.homeNavigationPath.isEmpty)
		
		// open a poppover
		await coordinator.openPopover(.payment(.example))
		
		await #expect(coordinator.selectedTab == .home)
		await #expect(coordinator.homeNavigationPath.isEmpty)
		await #expect(coordinator.paymentsNavigationPath.isEmpty)
		await #expect(coordinator.rewardsNavigationPath.isEmpty)
		await #expect(coordinator.playNavigationPath.isEmpty)
		await #expect(coordinator.popover != nil)
		
		// dismiss a poppover
		await coordinator.dismissPopover()
		await #expect(coordinator.popover == nil)
	}
}
