import UIKit

public protocol ILoadMoreEvent {
    func onLoadMore()
}

open class LoadMoreTableView: UITableView, UITableViewDataSource, UITableViewDelegate {
    
    public var loadMoreDelegage:ILoadMoreEvent?
    public var datas:[AnyObject] = []
    public var count:Int {
        self.datas.count
    }
    public var cellID:String!
    public var hasReachLast:Bool = false
    
    public func addDatas(newDatas:[AnyObject]) {
        guard newDatas.count > 0 else {
            return
        }
        
        self.hasReachLast = false
        
        self.datas.append(contentsOf: newDatas)
        self.reloadData()
    }
    
    public func clear() {
        datas = []
        
        self.reloadData()
    }
    
    // MARK:- UITableViewDataSource
   public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        datas.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        cell.selectionStyle = .none
        
        if !self.hasReachLast && (indexPath.row == self.datas.count - 1) {
            self.hasReachLast = true
            self.loadMoreDelegage?.onLoadMore()
        }
        
        return cell
    }
}
