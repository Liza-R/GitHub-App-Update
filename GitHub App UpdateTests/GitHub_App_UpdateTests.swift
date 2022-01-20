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

class TableViewMock: UITableView {
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
    var detailsInfoController: UserDetailsViewController!
    var allUsersVMMock: AllUsersViewModelMock!
    var tableViewMock: TableViewMock!
    var coordinatorMock: CoordinatorMock!
    let navController = UINavigationController()
    
    override func setUp() {
        super.setUp()
        allUsersController = AllUsersViewController()
        detailsInfoController = UserDetailsViewController()
        allUsersVMMock = AllUsersViewModelMock()
        tableViewMock = TableViewMock()
        allUsersController.allUsersTableView = tableViewMock
        coordinatorMock = CoordinatorMock(rootController: self.navController)
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
        XCTAssert(allUsersController.contains(allUsersController.searchUserSearchBar))
        XCTAssertNotNil(allUsersController.searchUserSearchBar)
        XCTAssertNotNil(allUsersController.searchUserSearchBar.delegate)
        XCTAssert(allUsersController.conforms(to: UISearchBarDelegate.self))
    }
    
    func testAllUsersTableView(){
        // when
        allUsersController.viewDidLoad()
        allUsersController.allUsersTableView.reloadData()
        
        // then
        XCTAssert(allUsersController.contains(allUsersController.allUsersTableView))
        XCTAssertNotNil(allUsersController.allUsersTableView)
        XCTAssertNotNil(allUsersController.allUsersTableView.dataSource)
        XCTAssertNotNil(allUsersController.allUsersTableView.delegate)
        XCTAssert(allUsersController.conforms(to: UITableViewDelegate.self))
        XCTAssert(tableViewMock.reloadDataWasCalled)
        tableViewMock.reloadDataWasCalled = false
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
