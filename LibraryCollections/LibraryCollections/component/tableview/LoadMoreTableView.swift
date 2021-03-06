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
    public var isLoading:Bool = false
    
    public func addDatas(newDatas:[AnyObject]) {
        guard newDatas.count > 0 else {
            return
        }
        
        self.isLoading = false
        
        self.datas.append(contentsOf: newDatas)
        self.reloadData()
    }
    
    public func clear() {
        datas = []
        
        self.reloadData()
    }
    
    // MARK:- scrollViewDidScroll
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let isReachLast = self.indexPathsForVisibleRows?.contains(where: { indexPath in
            indexPath.row == self.datas.count - 1
        }) ?? false
        
        if isReachLast && !self.isLoading {
            self.isLoading = true
            self.loadMoreDelegage?.onLoadMore()
        }
    }
    
    // MARK:- UITableViewDataSource
   open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        datas.count
    }
    
    open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        cell.selectionStyle = .none
        
        return cell
    }
}
