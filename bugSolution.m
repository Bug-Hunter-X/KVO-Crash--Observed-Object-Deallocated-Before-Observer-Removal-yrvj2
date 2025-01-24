The solution involves removing the observer before the observed object is deallocated.  This prevents access to deallocated memory.

```objectivec
#import <Foundation/Foundation.h>

@interface ObservedObject : NSObject
@property (nonatomic, strong) NSString *observedProperty;
@end

@implementation ObservedObject
- (void)dealloc {
    NSLog(@"ObservedObject deallocated");
}
@end

@interface MyObserver : NSObject
@property (nonatomic, weak) ObservedObject *observedObject;
@end

@implementation MyObserver
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    NSLog(@"Observed property changed: %@
", [object valueForKeyPath:keyPath]);
}
- (void)removeObserver {
  [self.observedObject removeObserver:self forKeyPath:@