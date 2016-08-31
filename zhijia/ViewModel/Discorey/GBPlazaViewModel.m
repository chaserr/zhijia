//
//  GBPlazaViewModel.m
//  zhijia
//
//  Created by admin on 15/7/24.
//  Copyright (c) 2015年 Beijing Hahu Technology Development Co., Ltd. All rights reserved.
//

#import "GBPlazaViewModel.h"

@implementation GBPlazaViewModel
-(void)loadSceneModel{
    [super loadSceneModel];
    //[self.action useCache];
    self.response = nil;
    @weakify(self);
    _request = [GBPlazaRequest RequestWithBlock:^{  // 初始化请求回调
        @strongify(self)
        [self SEND_IQ_ACTION:self.request];
    }];
    
    
    [[RACObserve(self.request, state) //监控 网络请求的状态
      filter:^BOOL(NSNumber *state) { //过滤请求状态
          @strongify(self);
          return self.request.succeed;
      }]
     subscribeNext:^(NSNumber *state) {
         @strongify(self);
         NSError *error;
//         self.response = [[GBPlazaResponseModel alloc] initWithDictionary:[self.request.output objectForKey:@"data"] error:&error];//Model的ORM操作，dictionary to object
         
     }];
    
    NSString *jsonStr=@"{\"pagination\":{\"page\":1,\"page_size\":1,\"total\":1,\"is_end\":1},\"posts\":[{\"post_id\":\"小明\",\"author_id\":\"useridhash\",\"likes\":0,\"words\":\"我草你多少速度阿斯顿发斯蒂芬阿萨德开房间阿里看到健身房阿斯达飞是打发士大夫阿萨德发斯蒂芬阿斯蒂芬阿斯达罚单\",\"avatar\":\"http://ac-0y463z4t.clouddn.com/7kL1W7Q6ZdGmWCrknRgSK2A\",\"pictures\":[\"http://ac-0y463z4t.clouddn.com/7kL1W7Q6ZdGmWCrknRgSK2A\",\"http://ac-0y463z4t.clouddn.com/cSxXlfBptcrkuPsBMgUuGDA\"],\"videos\":\"\",\"liked\":1,\"comments\":20,\"created\":1437806859,\"commentsDetail\":[\"费获得减肥:呵呵呵 \",\"银他妈:你特么在逗我??\",\"我是谁:是打飞机爱神的箭罚款了圣诞节疯狂拉丝级东方就爱看电视我次奥不会吧\"]},{\"post_id\":\"小红\",\"author_id\":\"useridhash\",\"likes\":100,\"words\":\"\",\"avatar\":\"http://ac-0y463z4t.clouddn.com/hOYkBNAzdqZX1Ec9IeW9L1B\",\"pictures\":[\"http://ac-0y463z4t.clouddn.com/hOYkBNAzdqZX1Ec9IeW9L1B\", \"http://ac-0y463z4t.clouddn.com/nXDKJ2LkQWGqyLqWkYatLXD\", \"http://ac-0y463z4t.clouddn.com/R8Yc20QAvjW1rEZ8nFGfIlA\"],\"videos\":\"\",\"liked\":1,\"comments\":0,\"created\":1365895457,\"commentsDetail\":[]},{\"post_id\":\"小刚\",\"author_id\":\"useridhash\",\"likes\":0,\"words\":\"我就不告诉你我长得帅\",\"avatar\":\"http://ac-0y463z4t.clouddn.com/nXDKJ2LkQWGqyLqWkYatLXD\",\"pictures\":[\"http://ac-0y463z4t.clouddn.com/nXDKJ2LkQWGqyLqWkYatLXD\", \"http://ac-0y463z4t.clouddn.com/QMXEBvF4ZwIUHMFfansJICA\", \"http://ac-0y463z4t.clouddn.com/WNB4v8NQTL7xOODT3qFEHJA\", \"http://ac-0y463z4t.clouddn.com/LcDbiySH4n5j7QQGzinDNxC\", \"http://ac-0y463z4t.clouddn.com/Z6kW77Coo7W4eDFuZyDLQUB\", \"http://ac-0y463z4t.clouddn.com/1VzBzcIa7EXIdSzCnCFnSzD\", \"http://ac-0y463z4t.clouddn.com/cSxXlfBptcrkuPsBMgUuGDA\", \"http://ac-0y463z4t.clouddn.com/nXDKJ2LkQWGqyLqWkYatLXD\"],\"videos\":\"\",\"liked\":1,\"comments\":0,\"created\":1365895457,\"commentsDetail\":[\"费获得减肥:呵呵呵 \"]},{\"post_id\":\"小吕\",\"author_id\":\"useridhash\",\"likes\":100,\"words\":\"如果爱有来生我愿意花树下等你一轮回,哈哈哈哈哈哈哈哈哈哈啊哈哈哈哈\",\"avatar\":\"http://ac-0y463z4t.clouddn.com/hOYkBNAzdqZX1Ec9IeW9L1B\",\"pictures\":[],\"videos\":\"\",\"liked\":1,\"comments\":20,\"created\":1437506659,\"commentsDetail\":[\"费获得减肥:呵呵呵 \",\"银他妈:你特么在逗我??\"]}]}";
//    JSONModelError *err;
//    self.response=[[GBPlazaResponseModel alloc] initWithString:jsonStr error:&err];
}
@end
