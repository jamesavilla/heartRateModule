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

#import <XCTest/XCTestCase.h>

/*
 A TestResult collects the results of executing a test. The test framework distinguishes between %failures which are anticipated and checked for problems like a test that failed; and %{unexpected failures} which are unforeseen (catastrophic) problems, like an exception.
 */
@interface XCTestRun : NSObject {
#ifndef __OBJC2__
@private
    NSTimeInterval startDate;
    NSTimeInterval stopDate;
    XCTest * test;
#endif
}

+ (id) testRunWithTest:(XCTest *) aTest;
- (id) initWithTest:(XCTest *) aTest;

- (XCTest *) test;

- (void) start;
- (void) stop;

- (NSDate *) startDate;
- (NSDate *) stopDate;
- (NSTimeInterval) totalDuration; 
- (NSTimeInterval) testDuration;

/// The number of test cases in the run.
- (NSUInteger) testCaseCount;

/// The number of test failures recorded during the run.
- (NSUInteger) failureCount;

/// The number of uncaught exceptions recorded during the run.
- (NSUInteger) unexpectedExceptionCount;

/// The total number of test failures and uncaught exceptions recorded during the run.
- (NSUInteger) totalFailureCount;

- (BOOL) hasSucceeded;

@end
