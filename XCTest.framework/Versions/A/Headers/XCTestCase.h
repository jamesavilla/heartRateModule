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

#import <XCTest/XCAbstractTest.h>

/*
 A test case defines the fixture to run multiple tests. To define a test case:
 
 1) Create a subclass of XCTestCase
 2) Implement test methods
 3) Optionally define instance variables that store the state of the fixture
 4) Optionally initialize the fixture state by overriding setUp
 5) Optionally clean-up after a test by overriding tearDown.
 
 Test methods with no parameters, returning no value, and prefixed with 'test', such as:

 - (void) testSomething;
 
 ...are automatically recognized as test cases by the XCTest framework. Each XCTestCase subclass' defaultTestSuite is a XCTestSuite which includes theses tests.
 
 Test methods implementations usually contains assertions that must be verified for the test to pass: the XCTAssertTrue() macro defined below. Here is an example:
 
 @interface MathTest : XCTestCase {
 @private
    float f1;
    float f2;
 }
 
 - (void) testAddition;
 
 @end
 
 @implementation MathTest
 
 - (void) setUp
 {
    f1 = 2.0;
    f2 = 3.0;
 }
 
 - (void) testAddition
 {
    XCTAssertTrue (f1 + f2 == 5.0, @"%f + %f should equal 5.0", f1, f2);
 }
 @end
 */

@class XCTestSuite;
@class XCTestCaseRun;

@interface XCTestCase : XCTest {
#ifndef __OBJC2__
@private
    NSInvocation *_invocation;
    XCTestCaseRun *_testCaseRun;
    BOOL _continueAfterFailure;
#endif
}

/*
 Creating test cases
 */
+ (id) testCaseWithInvocation:(NSInvocation *) anInvocation;
- (id) initWithInvocation:(NSInvocation *) anInvocation;

+ (id) testCaseWithSelector:(SEL) aSelector;
- (id) initWithSelector:(SEL) aSelector;

/*
 Setting and returning invocation and selector
 */
- (void) setInvocation:(NSInvocation *) anInvocation;
- (NSInvocation *) invocation;
- (SEL) selector;

/*
 Invoking a test performs only its setUp, invocation, and tearDown, outside the context of a run; it's the primitive method used by -performTest:.
 */
- (void) invokeTest;

/*
 Setting test case behavior after a failure
 */
@property (readwrite) BOOL continueAfterFailure;

/*
 Failing a test, used by all macros
 */
- (void) recordFailureWithDescription:(NSString *) description inFile:(NSString *) filename atLine:(NSUInteger) lineNumber expected:(BOOL) expected;

/*
 Returning the class' test methods
 */
+ (NSArray *) testInvocations;

@end

@interface XCTestCase (XCTestSuiteExtensions)

/*
 Returning a test suite with all the test cases
 */
+ (id) defaultTestSuite;

/// Setup method called before the invocation of any test method in the class.
+ (void) setUp;

/// Teardown method called after the invocation of every test method in the class.
+ (void) tearDown;

@end
