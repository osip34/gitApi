//
//  AppDelegate.h
//  gitApiTest
//
//  Created by Andrii Osipchuk on 24.11.2020.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

