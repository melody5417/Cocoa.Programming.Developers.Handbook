@protocol ChatPeerProtocol
- (void) handleMessage:(NSString*)aMessage
				  from:(NSString*)aUser;
- (NSString*) name;
@end
