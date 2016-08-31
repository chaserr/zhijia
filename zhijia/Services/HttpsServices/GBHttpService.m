//
//  GBHttpService.m
//  zhijia
//
//  Created by 童星 on 16/5/23.
//  Copyright © 2016年 Beijing tongxing Technology Development Co., Ltd. All rights reserved.
//

#import "GBHttpService.h"

@interface GBHttpRequest : NSObject
{
}

@property (strong, nonatomic) NSString *uniqueId;
@property (strong, nonatomic) NSString *url;
@property (strong, nonatomic) NSString* httpMethod;
@property (strong, nonatomic) NSMutableDictionary *headers;
@property (strong, nonatomic) NSMutableDictionary *body;
@property (strong, nonatomic) AFHTTPSessionManager *op;
@property (nonatomic, copy) HttpReuqestSucceedBlock succeedBlock;
@property (nonatomic, copy) HttpRequestFailedBlock failedBlock;
@property (strong, nonatomic) NSMutableArray *headerarray;
@property (nonatomic) BOOL isRequesting;

@end

@implementation GBHttpRequest
- (id)init
{
    self = [super init];
    if (self)
    {
        self.uniqueId = [NSString uniqueString];
    }
    return self;
}

-(void)dealloc
{
    if(self.headers)
    {
        [self.headers removeAllObjects];
    }
    if(self.body)
    {
        [self.body removeAllObjects];
    }
}

-(void)cancel
{
    if(self.op)
    {
        [self.op.operationQueue cancelAllOperations];
    }
    if(self.succeedBlock)
    {
        self.succeedBlock = nil;
    }
    if(self.failedBlock)
    {
        self.failedBlock = nil;
    }
    if(self.headers)
    {
        [self.headers removeAllObjects];
    }
    if(self.body)
    {
        [self.body removeAllObjects];
    }
}

- (AFHTTPSessionManager *)op{
    
    if (!_op) {
        _op = [AFHTTPSessionManager manager];
    }
    return _op;
}

@end


@interface GBHttpQueue : NSObject
@property (strong, nonatomic) NSMutableArray *queue;

-(void)addRequest:(GBHttpRequest*)request;
-(void)removeRequest:(GBHttpRequest*)request;
-(void)removeRequestWithUniqueId:(NSString*)uniqueId;
-(void)removeAllRequest;
-(GBHttpRequest*)findRequestWithUniqueId:(NSString*)uniqueId;

@end

@implementation GBHttpQueue

- (id)init
{
    self = [super init];
    if (self) {
        self.queue = [[NSMutableArray alloc] init];
    }
    return self;
}

-(void)addRequest:(GBHttpRequest*)request
{
    if(request == nil)
        return;
    
    [self.queue addObject:request];
}

-(void)removeRequest:(GBHttpRequest*)request
{
    if(request == nil)
        return;
    
    [self.queue removeObject:request];
}

-(void)removeAllRequest
{
    [self.queue removeAllObjects];
}

-(void)removeRequestWithUniqueId:(NSString*)uniqueId
{
    GBHttpRequest* request = [self findRequestWithUniqueId:uniqueId];
    if(request != nil)
    {
        [self removeRequest:request];
    }
}

-(GBHttpRequest*)findRequestWithUniqueId:(NSString*)uniqueId
{
    for(GBHttpRequest *request in self.queue)
    {
        if([request.uniqueId isEqualToString:uniqueId])
        {
            return request;
        }
    }
    return nil;
}

-(void)dealloc
{
    [self.queue removeAllObjects];
}

@end

static GBHttpService * instance = nil;


@interface GBHttpService ()

//@property (strong, nonatomic) MKNetworkEngine *engine;
@property (strong, nonatomic) NSMutableDictionary *customHeaders;
@property (strong, nonatomic) AFHTTPSessionManager *op;
@property (strong, nonatomic) NSMutableArray *opValues;
@property (strong, nonatomic) NSMutableArray *opKeys;
@property (strong, nonatomic) GBHttpQueue *requestQueue;
@end

@implementation GBHttpService

+ (GBHttpService*)getInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{

        instance = [[GBHttpService alloc] init];

    });

    return instance;
}

NSString* const GETS = @"GET";
NSString* const POSTS = @"POST";

-(id)init
{
    self = [super init];
    if (self)
    {
    }
//    self.engine = [[MKNetworkEngine alloc] init];
    self.customHeaders = [[NSMutableDictionary alloc] init];
    self.requestQueue = [[GBHttpQueue alloc]init];
    return self;
}

-(void)setHeaders:(NSDictionary*)headerDic
{
    if(nil == headerDic)
    {
        [self.customHeaders setDictionary:headerDic];
    }
}

-(void)removeAllHeaders
{
    [self.customHeaders removeAllObjects];
}

//-(NSString*)sendGetWithURL:(NSString*)url httpHeader:(NSDictionary*)headerDic onCompletion:(HttpReuqestSucceedBlock) completionBlock onError:(HttpRequestFailedBlock) errorBlock
//{
//    
//}
//
//-(NSString*) sendPostWithURL:(NSString*)url body:(NSMutableDictionary*)body httpHeader:(NSDictionary*)headerDic onCompletion:(HttpReuqestSucceedBlock) completionBlock onError:(HttpRequestFailedBlock) errorBlock
//{
//    //-----------------------------------------------------------------------------
//    // 如果session id存在的话需要替换(unknown)
//    NSString* sessionID = YY_CONFIG.sessionId;
//    if(sessionID && sessionID.length > 0)
//    {
//        NSMutableString* tempUrl = [NSMutableString stringWithString:url];
//        url = [tempUrl stringByReplacingOccurrencesOfString:@"unknown" withString:sessionID];
//    }
//    
//    // 所有请求都要在url后面带上auth
//    url = [NSString stringWithFormat:@"%@?oh=%@", url, [YY_CONFIG getAuthCode]];
//    // 所有请求都要在url后面带上token
//    if(YY_CONFIG.token && YY_CONFIG.token.length > 0)
//    {
//        url = [NSString stringWithFormat:@"%@&token=%@", url, YY_CONFIG.token];
//    }
//    // 所有请求都要在body体里面带上platformInfo
//    if(body == nil)
//    {
//        body = [[NSMutableDictionary alloc] init];
//    }
//    [body setValue:[YY_CONFIG getPlatformInfo] forKey:@"platformInfo"];
//    //-----------------------------------------------------------------------------
//    
//    MKNetworkOperation *op = [self.engine operationWithURLString:url
//                                                          params:body
//                                                      httpMethod:POST];
//    op.postDataEncoding = MKNKPostDataEncodingTypeJSON;
//    
//    if(nil != headerDic)
//        [op addHeaders:headerDic];
//    
//    YYHttpRequest* request = [[YYHttpRequest alloc]init];
//    request.op = op;
//    request.url = url;
//    request.headers = self.customHeaders;
//    request.httpMethod = POST;
//    request.body = body;
//    request.succeedBlock = completionBlock;
//    request.failedBlock = errorBlock;
//    CORE_LOG(@"%@", request);
//    [self.requestQueue addRequest:request];
//    YYHttpService * __weak weakSelf = self;
//    [op onCompletion:^(MKNetworkOperation *completedOperation) {
//        
//        YYHttpService *strongSelf = weakSelf;
//        
//        NSDictionary* responseHeader = [[completedOperation readonlyResponse] allHeaderFields];
//        if([responseHeader objectForKey:@"errorCode"] || [responseHeader objectForKey:@"errorMsg"])
//        {
//            NSString* errorMsg = nil;
//            
//            NSString* temp = [responseHeader objectForKey:@"errorMsg"];
//            errorMsg = [NSString stringWithString:[temp stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
//            
//            CORE_LOG(@"errorCode = %@ errorMsg = %@", [responseHeader objectForKey:@"errorCode"], errorMsg);
//            
//            if([[responseHeader objectForKey:@"errorCode"] intValue] == -99)
//            {
//                [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationTokenError object:self];
//            }
//            else
//            {
//                [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationServerError object:self];
//            }
//            
//            if(errorMsg == nil)
//            {
//                errorMsg = @"服务器未知错误";
//            }
//            
//            NSDictionary* info = [NSDictionary dictionaryWithObject:errorMsg forKey:@"errorMsg"];
//            NSError* error = [NSError errorWithDomain:@"YouYuan" code:[[responseHeader objectForKey:@"errorCode"] intValue] userInfo:info];
//            errorBlock(request.uniqueId, error);
//            
//            [strongSelf.requestQueue removeRequest:request];
//        }
//        else
//        {
//            if([completedOperation responseData])
//            {
//                //NSString *newStr = [[NSString alloc] initWithData:[completedOperation responseData] encoding:NSUTF8StringEncoding];
//                //CORE_LOG(@"Post Response: %@", newStr);
//                
//                NSDictionary* dc = [[JSONDecoder decoder] parseJSONData:[completedOperation responseData]];
//                if([dc isKindOfClass:[NSDictionary class]])
//                {
//                    completionBlock(request.uniqueId,dc);
//                }
//                else
//                {
//                    completionBlock(request.uniqueId,nil);
//                }
//            }
//            else
//            {
//                completionBlock(request.uniqueId,nil);
//            }
//            [strongSelf.requestQueue removeRequest:request];
//        }
//        
//    }onError:^(NSError* error) {
//        
//        YYHttpService *strongSelf = weakSelf;
//        errorBlock(request.uniqueId,error);
//        [strongSelf.requestQueue removeRequest:request];
//    }];
//    
//    request.isRequesting = YES;
//    [self.engine enqueueOperation:op];
//    return request.uniqueId;
//}

-(BOOL) cancelWithUniqueId:(NSString*)uniqueId
{
    GBHttpRequest* request = [self.requestQueue findRequestWithUniqueId:uniqueId];
    if(request != nil)
    {
        [request cancel];
        [self.requestQueue removeRequest:request];
        return YES;
    }
    return NO;
}

-(void) cancelAll
{
    for(GBHttpRequest* request  in self.requestQueue.queue)
    {
        [request cancel];
    }
    [self.requestQueue removeAllRequest];
}

- (AFHTTPSessionManager *)op{
    
    if (!_op) {
        _op = [AFHTTPSessionManager manager];
    }
    return _op;
}
@end
