//
//  Game.m
//  SoulsGame
//
//  Created by Andrew Cummings on 5/27/16.
//  Copyright © 2016 Andrew Cummings. All rights reserved.
//

#import "Game.h"
#import "FireResist.h"
#import "Crystal.h"
#import "FireBuff.h"
#import "LifeBuff.h"
#import "WaterResist.h"
#import "WaterBuff.h"

#import "Fireball.h"
#import "QuickHeal.h"
#import "WaterShard.h"
#import "HealingPool.h"

#import "Spells.h"
#import "SoulsLibrary.h"

@interface Game ()

@property (nonatomic, strong) UIViewController<UpdateableController>* _delegate;
@property (nonatomic) NSInteger userID;
@property (nonatomic) NSInteger awayID;

@property (nonatomic) BOOL shouldEndClearTimer;

@property (strong, nonatomic) NSTimer* receiveDataTimer;
@property (strong, nonatomic) NSTimer* clearBufferTimer;

@end

@implementation Game

@synthesize messageIndex;
@synthesize currentBuffer;

static Game* gameInstance = nil;

-(instancetype)init{
    if (self = [super init]){
        self.time = 0;
        
        self.homePlayer = [[Player alloc]init];
        self.homePlayer.delegate = self;
        
        self.awayPlayer = [[Player alloc]init];
        
        self.homePlayer.mana = 25;//[Game crystalCreateCost];
        self.awayPlayer.mana = 25;//[Game crystalCreateCost];
        
        self.homeKnownResist = [[NSArray alloc]initWithObjects:[[FireResist alloc]init], [[WaterResist alloc]init], nil];
        self.homeKnownBuff = [[NSArray alloc]initWithObjects:[[FireBuff alloc]init], [[LifeBuff alloc]init], [[WaterBuff alloc]init] ,  nil];
        self.homeKnownSpec = [[NSArray alloc]init];
        
        self.knownSpells = [[NSArray alloc]initWithObjects:[[Fireball alloc]init], [[QuickHeal alloc]init], [[WaterShard alloc]init], [[HealingPool alloc] init], nil];
        
        self.canAttack = NO;
        
        self.messageIndex = 1;
        self.currentBuffer = [[NSMutableString alloc]init];
        
        self.shouldEndClearTimer = NO;
    }
    return self;
}

-(void)setShouldStart {
    NSURL *url = [NSURL URLWithString:@"http://10.0.1.121/souls/data.php"];
    
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    
    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:url];
    NSString* params = [NSString stringWithFormat:@"id=%ld", self.userID];
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setHTTPBody:[params dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSError *error = nil;
    
    if (!error) {
        NSURLSessionDataTask *uploadTask = [session dataTaskWithRequest:urlRequest completionHandler:^(NSData *data,NSURLResponse *response,NSError *error) {
            NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
            
            NSUInteger len = [str length];
            unichar buffer[len+1];
            
            [str getCharacters:buffer range:NSMakeRange(0, len)];
            
            self.canAttack = YES;
            
            for(int i = 0; i < len; i++) {
                unichar thisChar = buffer[i];
                
                if (thisChar < '0' || thisChar > '9'){
                    if (thisChar == 's'){
                        self.canAttack = NO;
                        self.receiveDataTimer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(receiveDataClock:) userInfo:nil repeats:YES];
                        [[NSRunLoop mainRunLoop] addTimer:self.receiveDataTimer forMode:NSRunLoopCommonModes];
                    }
                }
            }
            
            if (self.canAttack) {
                self.clearBufferTimer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(clearBufferClock:) userInfo:nil repeats:YES];
                [[NSRunLoop mainRunLoop] addTimer:self.clearBufferTimer forMode:NSRunLoopCommonModes];
            }
            
            [self._delegate updateGUI];
        }];
        
        [uploadTask resume];
    }
}

-(void)checkCrystalDeath {
    [self.homePlayer checkCrystalDeath];
    [self.awayPlayer checkCrystalDeath];
}

-(void)homeEndTurn {
    self.time++;
    [self.homePlayer nextTurn];
    
    self.canAttack = NO;
    [self addBufferMessage:@"end"];
    
    self.receiveDataTimer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(receiveDataClock:) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.receiveDataTimer forMode:NSRunLoopCommonModes];
    
    self.shouldEndClearTimer = YES;
}

-(void)awayEndTurn{
    self.time++;
    [self.awayPlayer nextTurn];
    
    self.canAttack = YES;
    
    [self.receiveDataTimer invalidate];
    self.receiveDataTimer = nil;
    
    self.clearBufferTimer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(clearBufferClock:) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.clearBufferTimer forMode:NSRunLoopCommonModes];
}

+(Game*)instance {
    @synchronized(self) {
        if (gameInstance == nil) {
            gameInstance = [[self alloc] init];
        }
    }
    
    return gameInstance;
}

+(NSInteger)crystalCreateCost{
    return 9;
}

-(void)setDelegate:(UIViewController<UpdateableController> *)delegate{
    self._delegate = delegate;
    self.userID = delegate.userID;
    self.awayID = delegate.awayID;
}

-(void)queryGUIUpdate {
    NSURL *url = [NSURL URLWithString:@"http://10.0.1.121/souls/getr.php"];
    
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    
    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:url];
    NSString* params = [NSString stringWithFormat:@"id=%ld", self.userID];
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setHTTPBody:[params dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSError *error = nil;
    
    if (!error) {
        NSURLSessionDataTask *uploadTask = [session dataTaskWithRequest:urlRequest completionHandler:^(NSData *data,NSURLResponse *response,NSError *error) {
            NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
            NSInteger rVal = [str integerValue];
            
            if (rVal == 0){
                [self receiveGUIData];
            }
        }];
        
        [uploadTask resume];
    }
}

-(void)receiveGUIData {
    NSURL *url = [NSURL URLWithString:@"http://10.0.1.121/souls/data.php"];
    
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    
    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:url];
    NSString* params = [NSString stringWithFormat:@"id=%ld", self.userID];
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setHTTPBody:[params dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSError *error = nil;
    
    if (!error) {
        NSURLSessionDataTask *uploadTask = [session dataTaskWithRequest:urlRequest completionHandler:^(NSData *data,NSURLResponse *response,NSError *error) {
            NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
            
            [self handleData:str];
        }];
        
        [uploadTask resume];
    }
}

-(void)handleData:(NSString*)data{
    //unichar - 48 = the number (so if '1' then = 49 - 48 = 1)
    //compare unichar "A" to single quote 'A'
    
    NSMutableArray* cmds = [[NSMutableArray alloc]init];
    
    NSUInteger len = [data length];
    unichar buffer[len+1];
    
    [data getCharacters:buffer range:NSMakeRange(0, len)];
    
    BOOL foundMaxIndex = NO;
    NSInteger maxIndex;
    NSInteger maxIndexEnd = 0;
    
    for(int i = 0; i < len; i++) {
        unichar thisChar = buffer[i];
        
        if (thisChar < '0' || thisChar > '9'){
            if (!foundMaxIndex) {
                maxIndexEnd = i;
                foundMaxIndex = YES;
            }
            
            if (thisChar == 's') {
                i += 7;
            } else if (thisChar == 'e') {
                [cmds addObject:[data substringWithRange:NSMakeRange(i, 3)]];
                i += 3;
            } else if (thisChar == 'p') {
                [cmds addObject:[data substringWithRange:NSMakeRange(i, 6)]];
                i += 6;
            } else if (thisChar == 'c'){
                [cmds addObject:[data substringWithRange:NSMakeRange(i, 8)]];
                 i += 8;
            } else if (thisChar == 'o') {
                [cmds addObject:[data substringWithRange:NSMakeRange(i, 5)]];
                i += 5;
            }
        }
    }
    
    maxIndex = [[data substringWithRange:NSMakeRange(0, maxIndexEnd)] integerValue];
    
    
    for (int i = (int)[cmds count] - 1; i >= 0; i--){
        NSString* cmd = [cmds objectAtIndex:i];
        
        if ([[cmd substringToIndex:1] isEqualToString:@"e"]) {
            [self awayEndTurn];
        } else if ([[cmd substringToIndex:1] isEqualToString:@"p"]) {
            
            NSInteger caster = [[cmd substringWithRange:NSMakeRange(1, 1)] integerValue];
            NSInteger target = [[cmd substringWithRange:NSMakeRange(2, 1)] integerValue];
            NSString *spellID = [cmd substringWithRange:NSMakeRange(3, 3)];
            
            NSObject<Spell>* spell = [Spells spellWithID:spellID];
            if (spell == nil){
                NSLog(@"Unrecognized spell!");
                return;
            }
            
            Crystal* casterCrystal = [self.awayPlayer crystalN:caster];
            Crystal* targetCrystal;
            
            if (target > 5) {
                targetCrystal = [self.awayPlayer crystalN:caster-5];
            } else {
                targetCrystal = [self.homePlayer crystalN:caster];
            }
            
            [casterCrystal castSpell:spell onTarget:targetCrystal];
            
        } else if ([[cmd substringToIndex:1] isEqualToString:@"c"]) {
            
            NSInteger target = [[cmd substringWithRange:NSMakeRange(1, 1)] integerValue];
            NSInteger health = [[cmd substringWithRange:NSMakeRange(2, 2)] integerValue];
            NSInteger speed = [[cmd substringWithRange:NSMakeRange(4, 2)] integerValue];
            NSInteger shield = [[cmd substringWithRange:NSMakeRange(6, 2)] integerValue];
            
            Crystal* newCrystal = [[Crystal alloc]initWithHealth:health Speed:speed shield:shield];
            
            [self.awayPlayer setCrystalN:target toCrystal:newCrystal];
            
        } else if ([[cmd substringToIndex:1] isEqualToString:@"o"]) {
            
            NSInteger target = [[cmd substringWithRange:NSMakeRange(1, 1)] integerValue];
            NSString *soulID = [cmd substringWithRange:NSMakeRange(2, 3)];
            
            NSObject<Soul>* soul = [SoulsLibrary soulWithID:soulID];
            Crystal* targetCrystal = [self.awayPlayer crystalN:target];
            [targetCrystal addSoulInEmptyIndex:soul];
            
        }
    }
    
    [self setResetValue:maxIndex forUser:self.userID];
    [self._delegate updateGUI];
}

-(void)setResetValue:(NSInteger)r forUser:(NSInteger)ID {
    NSURL *url = [NSURL URLWithString:@"http://10.0.1.121/souls/setr.php"];
    
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    
    NSString* params = [NSString stringWithFormat:@"id=%ld&data=%ld", ID, (long)r];
    
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setHTTPBody:[params dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLSessionDataTask *uploadTask = [session dataTaskWithRequest:urlRequest];
    [uploadTask resume];
}

-(void)receiveDataClock:(NSTimer*)timer {
    [self queryGUIUpdate];
}

-(void)clearBufferClock:(NSTimer*)timer {
    
    NSURL *url = [NSURL URLWithString:@"http://10.0.1.121/souls/getr.php"];
    
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    
    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:url];
    NSString* params = [NSString stringWithFormat:@"id=%ld", self.userID];
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setHTTPBody:[params dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSError *error = nil;
    
    if (!error) {
        NSURLSessionDataTask *uploadTask = [session dataTaskWithRequest:urlRequest completionHandler:^(NSData *data,NSURLResponse *response,NSError *error) {
            NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
            NSInteger rVal = [str integerValue];
            
            if (rVal > 0) {
                [self clearBufferTo:rVal];
            }
        }];
        
        [uploadTask resume];
    }
}

-(void)clearBufferTo:(NSInteger)clearPoint {
    if (self.shouldEndClearTimer) {
        self.shouldEndClearTimer = NO;
        
        [self.clearBufferTimer invalidate];
        self.clearBufferTimer = nil;
    }
    
    NSUInteger len = [self.currentBuffer length];
    unichar buffer[len+1];
    
    [self.currentBuffer getCharacters:buffer range:NSMakeRange(0, len)];
    
    NSRange selectedRange = NSMakeRange(0, 0);
    BOOL setStart = YES;
    
    for(int i = 0; i < len; i++) {
        unichar thisChar = buffer[i];
        
        if (thisChar >= '0' && thisChar <= '9'){
            if (setStart) {
                selectedRange.location = i;
                setStart = NO;
            }
            selectedRange.length += 1;
        } else {
            NSInteger selectedNumber = [[self.currentBuffer substringWithRange:selectedRange] integerValue];
            
            if (selectedNumber == clearPoint) {
                i = (int)len;
            }
            
            if (thisChar == 's') {
                i += 7;
            } else if (thisChar == 'e') {
                i += 3;
            } else if (thisChar == 'p') {
                i += 6;
            } else if (thisChar == 'c'){
                i += 8;
            } else if (thisChar == 'o') {
                i += 5;
            }
        }
    }
    
    [self.currentBuffer deleteCharactersInRange:NSMakeRange(selectedRange.location, [self.currentBuffer length] - selectedRange.location)];
    [self setMatchData];
    
    [self setResetValue:0 forUser:self.awayID];
}

-(void)addBufferMessage:(NSString*)msg {
    NSString* fullMsg = [NSString stringWithFormat:@"%ld%@", self.messageIndex, msg];
    [self.currentBuffer appendString:fullMsg];
    
    [self setMatchData];
}

-(void)setMatchData {
    NSURL *url = [NSURL URLWithString:@"http://10.0.1.121/souls/uploadtomatch.php"];
    
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    
    NSString* params = [NSString stringWithFormat:@"id=%ld&data=%@", self.userID, self.currentBuffer];
    
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setHTTPBody:[params dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLSessionDataTask *uploadTask = [session dataTaskWithRequest:urlRequest];
    [uploadTask resume];
}

-(void)registerAddSoul:(NSString *)soulID toTarget:(NSInteger)target {
    NSString* cmd = [NSString stringWithFormat:@"o%ld%@", target, soulID];
    
    [self addBufferMessage:cmd];
}

-(void)registerCastSpell:(NSString *)spellID fromSource:(NSInteger)source toTarget:(Crystal *)target {
    NSInteger targetIndex;
    
    if (target == [self.awayPlayer crystal1]){
        targetIndex = 1;
    } else if (target == [self.awayPlayer crystal2]){
        targetIndex = 2;
    } else if (target == [self.awayPlayer crystal3]){
        targetIndex = 3;
    } else if (target == [self.awayPlayer crystal4]){
        targetIndex = 4;
    } else if (target == [self.awayPlayer crystal5]){
        targetIndex = 5;
    } else if (target == [self.homePlayer crystal1]){
        targetIndex = 6;
    } else if (target == [self.homePlayer crystal2]){
        targetIndex = 7;
    } else if (target == [self.homePlayer crystal3]){
        targetIndex = 8;
    } else if (target == [self.homePlayer crystal4]){
        targetIndex = 9;
    } else if (target == [self.homePlayer crystal5]){
        targetIndex = 10;
    } else {
        return;
    }
    
    NSString* cmd = [NSString stringWithFormat:@"p%ld%ld%@", source, targetIndex, spellID];
    
    [self addBufferMessage:cmd];
}

-(void)registerAddCrystal:(Crystal *)crystal atIndex:(NSInteger)index {
    NSString* cmd = [NSString stringWithFormat:@"c%ld%02d%02d%02d", index, (int)[crystal health]/2, (int)[crystal speed], (int)[crystal shield]];
    
    [self addBufferMessage:cmd];
}

/*
 new commands get added to the beginning of the text
 crystal index is 1 - 5 (not 0 - 4)
 for spell target, crystal index 6-10 is for their crystals (insead of ours)
 
 "n" + "command"
 
 "started" = this player gets turn 1 = 7 chars
 
 "end" = turn ended = 3 chars
 
 "p"+"1"+"2"+"sID" = cast spell, crystal caster #, crystal target #, spell ID = 6 chars
 
 "c"+"#"+"hp"+"sp"+"sh" = add crystal, crystal slot, hp, speed, shield = 8 chars
 
 "o"+"#"+"sID" = add soul, crystal #, soul ID = 5 chars
 */

@end
