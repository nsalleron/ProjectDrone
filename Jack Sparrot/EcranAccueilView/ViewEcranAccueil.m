//
//  EcranAccueil.m
//  Jack Sparrot
//
//  Created by Nicolas Salleron on 31/01/2017.
//
//

#import <Foundation/Foundation.h>
#import "ViewEcranAccueil.h"
#import "ViewControllerAcceuil.h"


@implementation ViewEcranAccueil



UIDevice *myDevice;
UINavigationController *myVC;



- (id) initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    if(self){
        
        myDevice = [UIDevice currentDevice];
        
        /* Allocation */
        _imgLogo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ParrotUniversal"]];
        _btnDrone = [UIButton buttonWithType:UIButtonTypeSystem];
        _btnOptions  = [UIButton buttonWithType:UIButtonTypeSystem];
        _btnAide = [UIButton buttonWithType:UIButtonTypeSystem];
        
        /* Personnalisation */
        [_btnDrone setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
        [_btnOptions setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
        [_btnAide setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
        
        /* Alignement du pauvre */
        [_btnDrone setTitle:@"   Contrôler drone" forState:UIControlStateNormal];
        [_btnOptions setTitle:@"   Options             " forState:UIControlStateNormal];
        [_btnAide setTitle:@"   Aide                    " forState:UIControlStateNormal];
        
        UIImage *btnImage = [UIImage imageNamed:@"ic_videogame_asset.png"];
        [_btnDrone setImage:btnImage forState:UIControlStateNormal];
        btnImage = [UIImage imageNamed:@"ic_settings.png"];
        [_btnOptions setImage:btnImage forState:UIControlStateNormal];
        btnImage = [UIImage imageNamed:@"ic_help.png"];
        [_btnAide setImage:btnImage forState:UIControlStateNormal];
        
        
        [[_btnDrone layer] setBorderWidth:1.0f];
        [[_btnDrone layer] setBorderColor:[UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:1.0].CGColor];
        [[_btnDrone layer] setCornerRadius:8.0f];
        [[_btnDrone layer] setBorderWidth:2.0f];
        
        [[_btnOptions layer] setBorderWidth:1.0f];
        [[_btnOptions layer] setBorderColor:[UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:1.0].CGColor];
        [[_btnOptions layer] setCornerRadius:8.0f];
        [[_btnOptions layer] setBorderWidth:2.0f];
        
        [[_btnAide layer] setBorderWidth:1.0f];
        [[_btnAide layer] setBorderColor:[UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:1.0].CGColor];
        [[_btnAide layer] setCornerRadius:8.0f];
        [[_btnAide layer] setBorderWidth:2.0f];
        
        
        _labelVersionApp = [[UILabel alloc] init];
        _labelBatteryDrone = [[UILabel alloc ]init];
        _labelBatterySmartphone = [[UILabel alloc ]init];
        _labelMontre = [[UILabel alloc ] init];
        
        
        [_labelBatterySmartphone setText:[NSString stringWithFormat:@"Niveau SmartPhone: %d%%",0]];
        [_labelBatteryDrone setText:@"Batterie drone : —"];
        [_labelVersionApp setText:@"Version 1"];
        [_labelMontre setText:@""];
        [_labelMontre setTintColor:[UIColor redColor]];
        
        [_labelVersionApp setFont:[UIFont systemFontOfSize:9]];
        [_labelBatteryDrone setFont:[UIFont systemFontOfSize:9]];
        [_labelBatterySmartphone setFont:[UIFont systemFontOfSize:9]];
        
        /* Selector */
        [_btnDrone addTarget:self.superview action:@selector(goToDroneControl:) forControlEvents:UIControlEventTouchUpInside];
        [_btnOptions addTarget:self.superview action:@selector(goToDroneOptions:) forControlEvents:UIControlEventTouchUpInside];
        [_btnAide addTarget:self.superview action:@selector(goToDroneHelp:) forControlEvents:UIControlEventTouchUpInside];
        
        /* Add to view */
        [self addSubview:_imgLogo];
        [self addSubview:_btnOptions];
        [self addSubview:_btnDrone];
        [self addSubview:_btnAide];
        [self addSubview:_labelVersionApp];
        [self addSubview:_labelBatteryDrone];
        [self addSubview:_labelBatterySmartphone];
        [self addSubview:_labelMontre];
       
        /* Force MAJ */
        [self setNeedsDisplay];
    }
    return self;
}


- (void)setBattery:(NSString*) battery{
    _labelBatteryDrone.text = battery;
}

-(void) setFrame:(CGRect)frame{
    [super setFrame:frame];
}

-(void) timerUpdate:(CGSize) format{
    
    _tailleIcones = format.height/3;
    
    if ([UIApplication sharedApplication].statusBarOrientation == 3 || [UIApplication sharedApplication].statusBarOrientation == 4)
    {
        
        
        /* Mise en place du logo et des boutons */
        [_imgLogo setFrame:CGRectMake (format.width/9,
                                       (format.height)/7, _tailleIcones*2, _tailleIcones*2)];
        
        
        [_btnDrone setFrame:CGRectMake(format.width/9 + _tailleIcones*2 + 10,
                                       (format.height/5),
                                       _tailleIcones*2.1, _tailleIcones/2)];
        
        
        [_btnOptions setFrame:CGRectMake(format.width/9 + _tailleIcones*2 + 10,
                                         format.height/5 + _tailleIcones/2 + 10,
                                         _tailleIcones*2.1, _tailleIcones/2)];
        
        [_btnAide setFrame:CGRectMake(format.width/9 + _tailleIcones*2 + 10,
                                      format.height/5 + _tailleIcones + 20,
                                      _tailleIcones*2.1, _tailleIcones/2)];
        
        /* Mise en place des labels */
        /* LabelBatterySmartphone */
        
        [_labelBatterySmartphone setFrame:CGRectMake(format.width - _tailleIcones*1.1,0,_tailleIcones*1.2,_tailleIcones/3)];
        
        /* LabelBatteryDrone */
        [_labelBatteryDrone setFrame:CGRectMake(5,0,_tailleIcones*1.2,_tailleIcones/3)];
        
        /* LabelVersionApp*/
        [_labelVersionApp setFrame:CGRectMake(format.width - _tailleIcones + (_tailleIcones/3) ,format.height - _tailleIcones/2 + 10,_tailleIcones,_tailleIcones/2)];
        [_labelVersionApp setTextAlignment:NSTextAlignmentLeft];
        
        [_labelMontre setFrame:CGRectMake(5, format.height - _tailleIcones/2 + 10, _tailleIcones,_tailleIcones/2)];
        
        [_labelBatterySmartphone setText:[NSString stringWithFormat:@"Niveau SmartPhone: %d%%",(int)[self battery]]];
        
    }else{
        
        /* Mise en place du logo et des boutons */
        [_imgLogo setFrame:CGRectMake (format.width/9.0,
                                       (format.height)/9.0, _tailleIcones*1.3, _tailleIcones*1.3)];
        
        
        [_btnDrone setFrame:CGRectMake(format.width/9.0 ,
                                       (format.height/6.0) + _tailleIcones*1.2,
                                       _tailleIcones*1.3, _tailleIcones/3)];
        
        
        [_btnOptions setFrame:CGRectMake(format.width/9.0,
                                         format.height/6.0 + _tailleIcones*1.2 + 70 ,
                                         _tailleIcones*1.3, _tailleIcones/3)];
        
        [_btnAide setFrame:CGRectMake(format.width/9.0,
                                      format.height/6.0 + (_tailleIcones*1.2) + 140 ,
                                      _tailleIcones*1.3, _tailleIcones/3)];
        
        /* Mise en place des labels */
        /* LabelBatterySmartphone */
        
        [_labelBatterySmartphone setFrame:CGRectMake(format.width - _tailleIcones/1.5,-10,_tailleIcones,_tailleIcones/3)];
        [_labelBatterySmartphone setText:[NSString stringWithFormat:@"Niveau SmartPhone: %d%%",(int)[self battery]]];
        /* LabelBatteryDrone */
        [_labelBatteryDrone setFrame:CGRectMake(10,
                                                -10,
                                                _tailleIcones,
                                                _tailleIcones/3)];
        /* Label montre */
        [_labelMontre setFrame:CGRectMake(10,format.height -_tailleIcones/3, _tailleIcones,
                                          _tailleIcones/2)];
        /* LabelVersionApp */
        [_labelVersionApp setFrame:CGRectMake(format.width - _tailleIcones - 10 ,
                                              format.height -_tailleIcones/3,
                                              _tailleIcones,
                                              _tailleIcones/2)];
        [_labelVersionApp setTextAlignment:NSTextAlignmentRight];
        
        
    }

}


- (void)updateView:(CGSize)format{
    
    NSLog(@"Passage %d",[UIApplication sharedApplication].statusBarOrientation);
    
    _tailleIcones = format.height/3;
    
    if (UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation))
    {
        
        
        /* Mise en place du logo et des boutons */
        [_imgLogo setFrame:CGRectMake (format.width/9,
                            (format.height)/7, _tailleIcones*2, _tailleIcones*2)];
        
        
        [_btnDrone setFrame:CGRectMake(format.width/9 + _tailleIcones*2 + 10,
                                       (format.height/5),
                                       _tailleIcones*2.1, _tailleIcones/2)];
        
              
        [_btnOptions setFrame:CGRectMake(format.width/9 + _tailleIcones*2 + 10,
                                       format.height/5 + _tailleIcones/2 + 10,
                                       _tailleIcones*2.1, _tailleIcones/2)];
        
        [_btnAide setFrame:CGRectMake(format.width/9 + _tailleIcones*2 + 10,
                                         format.height/5 + _tailleIcones + 20,
                                         _tailleIcones*2.1, _tailleIcones/2)];
        
        /* Mise en place des labels */
            /* LabelBatterySmartphone */
        
        [_labelBatterySmartphone setFrame:CGRectMake(format.width - _tailleIcones*1.1,0,_tailleIcones*1.2,_tailleIcones/3)];
        
            /* LabelBatteryDrone */
        [_labelBatteryDrone setFrame:CGRectMake(5,0,_tailleIcones*1.2,_tailleIcones/3)];
        
            /* LabelVersionApp*/
        [_labelVersionApp setFrame:CGRectMake(format.width - _tailleIcones + (_tailleIcones/3) ,format.height - _tailleIcones/2 + 10,_tailleIcones,_tailleIcones/2)];
        [_labelVersionApp setTextAlignment:NSTextAlignmentLeft];
        
        [_labelMontre setFrame:CGRectMake(5, format.height - _tailleIcones/2 + 10, _tailleIcones,_tailleIcones/2)];
        
        [_labelBatterySmartphone setText:[NSString stringWithFormat:@"Niveau SmartPhone: %d%%",(int)[self battery]]];
        
    }else{
        
        /* Mise en place du logo et des boutons */
        [_imgLogo setFrame:CGRectMake (format.width/9.0,
                                       (format.height)/9.0, _tailleIcones*1.3, _tailleIcones*1.3)];
        
        
        [_btnDrone setFrame:CGRectMake(format.width/9.0 ,
                                       (format.height/6.0) + _tailleIcones*1.2,
                                       _tailleIcones*1.3, _tailleIcones/3)];
        
        
        [_btnOptions setFrame:CGRectMake(format.width/9.0,
                                         format.height/6.0 + _tailleIcones*1.2 + 70 ,
                                         _tailleIcones*1.3, _tailleIcones/3)];
        
        [_btnAide setFrame:CGRectMake(format.width/9.0,
                                         format.height/6.0 + (_tailleIcones*1.2) + 140 ,
                                         _tailleIcones*1.3, _tailleIcones/3)];
        
        /* Mise en place des labels */
        /* LabelBatterySmartphone */
        
        [_labelBatterySmartphone setFrame:CGRectMake(format.width - _tailleIcones/1.5,-10,_tailleIcones,_tailleIcones/3)];
        [_labelBatterySmartphone setText:[NSString stringWithFormat:@"Niveau SmartPhone: %d%%",(int)[self battery]]];
        /* LabelBatteryDrone */
        [_labelBatteryDrone setFrame:CGRectMake(10,
                                                -10,
                                                _tailleIcones,
                                                _tailleIcones/3)];
        /* Label montre */
        [_labelMontre setFrame:CGRectMake(10,format.height -_tailleIcones/3, _tailleIcones,
                                          _tailleIcones/2)];
        /* LabelVersionApp */
        [_labelVersionApp setFrame:CGRectMake(format.width - _tailleIcones - 10 ,
                                              format.height -_tailleIcones/3,
                                              _tailleIcones,
                                              _tailleIcones/2)];
        [_labelVersionApp setTextAlignment:NSTextAlignmentRight];
        
        
    }
}

-(double)battery{
    UIDevice *myDevice = [UIDevice currentDevice];
    [myDevice setBatteryMonitoringEnabled:YES];
    
    int state = [myDevice batteryState];
    NSLog(@"battery status: %d",state); // 0 unknown, 1 unplegged, 2 charging, 3 full
    
    double batLeft = (float)[myDevice batteryLevel] * 100;
    NSLog(@"battery left: %f", batLeft);
    return batLeft;
}


-(void) drawRect:(CGRect)rect{
    [self updateView:rect.size];
}


@end
