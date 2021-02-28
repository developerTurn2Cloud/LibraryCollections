import UIKit

public protocol ILoadMoreEvent {
    func onLoadMore()
}

open class LoadMoreTableView: UITableView, UITableViewDataSource, UITableViewDelegate {
    
    var loadMoreDelegage:ILoadMoreEvent?
    var datas:[AnyObject] = []
    var count:Int {
        self.datas.count
    }
    var cellID:String!
    var hasReachLast:Bool = false
    
    func addDatas(newDatas:[AnyObject]) {
        guard newDatas.count > 0 else {
            return
        }
        
        self.hasReachLast = false
        
        self.datas.append(contentsOf: newDatas)
        self.reloadData()
    }
    
    func clear() {
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
