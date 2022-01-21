import XCTest
@testable import GitHub_App_Update

class AllUsersViewModelMock: AllUsersViewModel {
    var loadAllUsersWasCalled: Bool = false
    var loadAllFoundUsersWasCalled: Bool = false

    override func uploadAllUsersInfo() {
        super.uploadAllUsersInfo()
        loadAllUsersWasCalled = true
    }
    
    override func foundUsersInfo(foundUserName: String) {
        super.foundUsersInfo(foundUserName: foundUserName)
        loadAllFoundUsersWasCalled = true
    }
}


class AllUsersTableViewMock: UITableView {
    var reloadDataWasCalled = false
    override func reloadData() {
        super.reloadData()
        reloadDataWasCalled = true
    }
}

class CoordinatorMock: Coordinator {
    var coordinatorWasCalled = false
    override func start() {
        super.start()
        coordinatorWasCalled = true
    }
}

class GitHub_App_UpdateTests: XCTestCase {
    var allUsersController: AllUsersViewController!
    var allUsersVMMock: AllUsersViewModelMock!
    var allUsersTableViewMock: AllUsersTableViewMock!
    var coordinatorMock: CoordinatorMock!
    let navController = UINavigationController()
    
    override func setUp() {
        super.setUp()
        allUsersController = AllUsersViewController()
        allUsersVMMock = AllUsersViewModelMock()
        allUsersTableViewMock = AllUsersTableViewMock()
        allUsersController.allUsersTableView = allUsersTableViewMock
        coordinatorMock = CoordinatorMock(rootController: self.navController)
    }
    
    func testAllUsersUIs() throws {
        // when
        allUsersController.viewDidLoad()
        
        // then
        XCTAssert(allUsersController.contains(allUsersController.allUsersTableView))
        XCTAssert(allUsersController.contains(allUsersController.searchUserSearchBar))
        XCTAssert(allUsersController.contains(allUsersController.logoGHImageView))
    }
    
    func testAllUsersLoad() throws {
        // when
        allUsersController.viewDidLoad()
                
        // then
        XCTAssert(allUsersVMMock.loadAllUsersWasCalled)
        allUsersVMMock.loadAllUsersWasCalled = false
    }
    
    func testAllFoundUsersLoad() throws {
        // when
        allUsersController.viewDidLoad()
        allUsersVMMock.foundUsersInfo(foundUserName: "test")
                
        // then
        XCTAssert(allUsersVMMock.loadAllFoundUsersWasCalled)
        allUsersVMMock.loadAllFoundUsersWasCalled = false
    }
    
    func testAllUsersSearchBar(){
        // when
        allUsersController.viewDidLoad()
        
        // then
        XCTAssertNotNil(allUsersController.searchUserSearchBar)
        XCTAssertNotNil(allUsersController.searchUserSearchBar.delegate)
        XCTAssert(allUsersController.conforms(to: UISearchBarDelegate.self))
    }
    
    func testAllUsersTableView(){
        // when
        allUsersController.viewDidLoad()
        allUsersController.allUsersTableView.reloadData()
        
        // then
        XCTAssertNotNil(allUsersController.allUsersTableView)
        XCTAssertNotNil(allUsersController.allUsersTableView.dataSource)
        XCTAssertNotNil(allUsersController.allUsersTableView.delegate)
        XCTAssert(allUsersController.conforms(to: UITableViewDelegate.self))
        XCTAssert(allUsersTableViewMock.reloadDataWasCalled)
        allUsersTableViewMock.reloadDataWasCalled = false
    }
    
    func testCoordinator(){
        // when
        coordinatorMock.start()
        
        // then
        XCTAssert(coordinatorMock.coordinatorWasCalled)
        coordinatorMock.coordinatorWasCalled = false
    }
    
    override func setUpWithError() throws { }

    override func tearDownWithError() throws { }
}
