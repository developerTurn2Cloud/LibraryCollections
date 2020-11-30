import Foundation
import Firebase

public class PerformanceMonitorManager {
    
    public static let shared:PerformanceMonitorManager = PerformanceMonitorManager()
    
    private var trace:Trace!
    
    private init() {}
    
    // MARK:- Trace
    public func startTrace(sessionName:String) {
        if let trace = self.trace {
            trace.stop()
        }
        
        self.trace = Performance.startTrace(name: sessionName)
    }
    
    public func stopStrace() {
        self.trace.stop()
    }
    
    // MARK:- Attribute
    public func setAttribute(attribute:String, value:String) {
        self.trace.setValue(value, forAttribute: attribute)
    }
    
    public func removeAttribute(attribute:String) {
        self.trace.removeAttribute(attribute)
    }
    
    // MARK:- Metric
    public func setMetric(metric:String, value:Int64) {
        self.trace.setValue(value, forMetric: metric)
    }
    
    public func incrementMetric(metric:String, value:Int64) {
        self.trace.incrementMetric(metric, by: value)
    }
}
