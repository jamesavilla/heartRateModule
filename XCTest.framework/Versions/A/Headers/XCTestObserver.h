//
// Copyright (c) 2013 Apple Inc. All rights reserved.
//
// Copyright (c) 1997-2005, Sen:te (Sente SA).  All rights reserved.
//
// Use of this source code is governed by the following license:
// 
// Redistribution and use in source and binary forms, with or without modification, 
// are permitted provided that the following conditions are met:
// 
// (1) Redistributions of source code must retain the above copyright notice, 
// this list of conditions and the following disclaimer.
// 
// (2) Redistributions in binary form must reproduce the above copyright notice, 
// this list of conditions and the following disclaimer in the documentation 
// and/or other materials provided with the distribution.
// 
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS ``AS IS'' 
// AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED 
// WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. 
// IN NO EVENT SHALL Sente SA OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, 
// SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT 
// OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) 
// HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, 
// OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, 
// EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
// 
// Note: this license is equivalent to the FreeBSD license.
// 
// This notice may not be removed from this file.

#import <Foundation/Foundation.h>

#import <XCTest/XCTestDefines.h>

@class XCTestRun;

/*! An XCTestObserver monitors the progress of tests as they're run.
 
 An instance of each XCTestObserver subclass specified via the XCTestObserverClass user default will be instantiated prior to running tests, and cleaned up after tests are run. However, subclasses should do their primary setup and teardown in -startObserving and -stopObserving rather than -init and -dealloc so it occurs immediately before and after tests are run.
 */
@interface XCTestObserver : NSObject

/*! Sent immediately before running tests to inform the observer that it's time to start observing test progress. Subclasses can override this method, but they must invoke super's implementation. */
- (void) startObserving;

/*! Sent immediately after running tests to inform the observer that it's time to stop observing test progress. Subclasses can override this method, but they must invoke super's implementation. */
- (void) stopObserving;

- (void) testSuiteDidStart:(XCTestRun *) testRun;
- (void) testSuiteDidStop:(XCTestRun *) testRun;

- (void) testCaseDidStart:(XCTestRun *) testRun;
- (void) testCaseDidStop:(XCTestRun *) testRun;

- (void) testCaseDidFail:(XCTestRun *) testRun withDescription:(NSString *)description inFile:(NSString *) filePath atLine:(NSUInteger) lineNumber;

@end

/*! Setting the XCTestObserverClass user default to the name of a subclass of XCTestObserver indicates that XCTest should use that subclass for reporting test results rather than the default, XCTestLog. You can specify multiple subclasses of XCTestObserver by specifying a comma between each one, for example @"XCTestLog,FooObserver". */
XCT_EXPORT NSString * const XCTestObserverClassKey;
