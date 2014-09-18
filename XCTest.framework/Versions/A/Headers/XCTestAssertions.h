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

#import <XCTest/XCTestAssertionsImpl.h>

/// \def XCTFail(format...)
/// \brief Generates a failure unconditionally.
/// \param format An NSString object that contains a printf-style string containing an error message describing the failure condition and placeholders for the arguments.
/// \param ... The arguments displayed in the format string.
#define XCTFail(format...) \
    _XCTPrimitiveFail(format)

/// \def XCTAssertNil(a1, format...)
/// \brief Generates a failure when \a1 is not nil.
/// \param a1 The object that is tested.
/// \param format An NSString object that contains a printf-style string containing an error message describing the failure condition and placeholders for the arguments.
/// \param ... The arguments displayed in the format string.
#define XCTAssertNil(a1, format...) \
    _XCTPrimitiveAssertNil(a1, ## format)

/// \def XCTAssertNotNil(a1, format...)
/// \brief Generates a failure when a1 is nil.
/// \param a1 The object that is tested.
/// \param format An NSString object that contains a printf-style string containing an error message describing the failure condition and placeholders for the arguments.
/// \param ... The arguments displayed in the format string.
#define XCTAssertNotNil(a1, format...) \
    _XCTPrimitiveAssertNotNil(a1, ## format)

/// \def XCTAssert(expression, format...)
/// \brief Generates a failure when expression evaluates to false.
/// \param expression The expression that is tested.
/// \param format An NSString object that contains a printf-style string containing an error message describing the failure condition and placeholders for the arguments.
/// \param ... The arguments displayed in the format string.
#define XCTAssert(expression, format...) \
    _XCTPrimitiveAssertTrue(expression, ## format)

/// \def XCTAssertTrue(expression, format...)
/// \brief Generates a failure when expression evaluates to false.
/// \param expression The expression that is tested.
/// \param format An NSString object that contains a printf-style string containing an error message describing the failure condition and placeholders for the arguments.
/// \param ... The arguments displayed in the format string.
#define XCTAssertTrue(expression, format...) \
    _XCTPrimitiveAssertTrue(expression, ## format)

/// \def XCTAssertFalse(expression, format...)
/// \brief Generates a failure when the expression evaluates to true.
/// \param expression The expression that is tested.
/// \param format An NSString object that contains a printf-style string containing an error message describing the failure condition and placeholders for the arguments.
/// \param ... The arguments displayed in the format string.
#define XCTAssertFalse(expression, format...) \
    _XCTPrimitiveAssertFalse(expression, ## format)

/// \def XCTAssertEqualObjects(a1, a2, format...)
/// \brief Generates a failure when !{ [a1 isEqual:a2] } is false (or one is nil and the other is not).
/// \param a1 The first object argument.
/// \param a2 The second object argument.
/// \param format An NSString object that contains a printf-style string containing an error message describing the failure condition and placeholders for the arguments.
/// \param ... The arguments displayed in the format string.
#define XCTAssertEqualObjects(a1, a2, format...) \
    _XCTPrimitiveAssertEqualObjects(a1, a2, ## format)

/// \def XCTAssertNotEqualObjects(a1, a2, format...)
/// \brief Generates a failure when { [a1 isEqual:a2] } is false (or both are nil).
/// \param a1 The first object argument.
/// \param a2 The second object argument.
/// \param format An NSString object that contains a printf-style string containing an error message describing the failure condition and placeholders for the arguments.
/// \param ... The arguments displayed in the format string.
#define XCTAssertNotEqualObjects(a1, a2, format...) \
    _XCTPrimitiveAssertNotEqualObjects(a1, a2, ## format)

/// \def XCTAssertEqual(a1, a2, format...)
/// \brief Generates a failure when a1 is not equal to a2. This test is for C scalars.
/// \param a1 The first argument.
/// \param a2 The second argument.
/// \param format An NSString object that contains a printf-style string containing an error message describing the failure condition and placeholders for the arguments.
/// \param ... The arguments displayed in the format string.
#define XCTAssertEqual(a1, a2, format...) \
    _XCTPrimitiveAssertEqual(a1, a2, ## format)

/// \def XCTAssertNotEqual(a1, a2, format...)
/// \brief Generates a failure when a1 is equal to a2. This test is for C scalars.
/// \param a1 The first argument.
/// \param a2 The second argument.
/// \param format An NSString object that contains a printf-style string containing an error message describing the failure condition and placeholders for the arguments.
/// \param ... The arguments displayed in the format string.
#define XCTAssertNotEqual(a1, a2, format...) \
    _XCTPrimitiveAssertNotEqual(a1, a2, ## format)

/// \def XCTAssertEqualWithAccuracy(a1, a2, format...)
/// \brief Generates a failure when a1 is not equal to a2 within + or - accuracy. This test is for scalars such as floats and doubles, where small differences could make these items not exactly equal, but works for all scalars.
/// \param a1 The first argument.
/// \param a2 The second argument.
/// \param accuracy The maximum difference between a1 and a2 for these values to be considered equal.
/// \param format An NSString object that contains a printf-style string containing an error message describing the failure condition and placeholders for the arguments.
/// \param ... The arguments displayed in the format string.
#define XCTAssertEqualWithAccuracy(a1, a2, accuracy, format...) \
    _XCTPrimitiveAssertEqualWithAccuracy(a1, a2, accuracy, ## format)

/// \def XCTAssertNotEqualWithAccuracy(a1, a2, format...)
/// \brief Generates a failure when a1 is equal to a2 within + or - accuracy. This test is for scalars such as floats and doubles, where small differences could make these items not exactly equal, but works for all scalars.
/// \param a1 The first argument.
/// \param a2 The second argument.
/// \param accuracy The maximum difference between a1 and a2 for these values to be considered equal.
/// \param format An NSString object that contains a printf-style string containing an error message describing the failure condition and placeholders for the arguments.
/// \param ... The arguments displayed in the format string.
#define XCTAssertNotEqualWithAccuracy(a1, a2, accuracy, format...) \
    _XCTPrimitiveAssertNotEqualWithAccuracy(a1, a2, accuracy, ## format)

/// \def XCTAssertThrows(expression, format...)
/// \brief Generates a failure when expression does not throw an exception.
/// \param expression The expression that is evaluated.
/// \param format An NSString object that contains a printf-style string containing an error message describing the failure condition and placeholders for the arguments.
/// \param ... The arguments displayed in the format string.
#define XCTAssertThrows(expression, format...) \
    _XCTPrimitiveAssertThrows(expression, ## format)

/// \def XCTAssertThrowsSpecific(expression, specificException, format...)
/// \brief Generates a failure when expression does not throw an exception of a specific class.
/// \param expression The expression that is evaluated.
/// \param specificException The specified class of the exception.
/// \param format An NSString object that contains a printf-style string containing an error message describing the failure condition and placeholders for the arguments.
/// \param ... The arguments displayed in the format string.
#define XCTAssertThrowsSpecific(expression, specificException, format...) \
    _XCTPrimitiveAssertThrowsSpecific(expression, specificException, ## format)

/// \def XCTAssertThrowsSpecificNamed(expression, specificException, exception_name, format...)
/// \brief Generates a failure when expression does not throw an exception of a specific class with a specific name.  Useful for those frameworks like AppKit or Foundation that throw generic NSException w/specific names (NSInvalidArgumentException, etc).
/// \param expression The expression that is evaluated.
/// \param specificException The specified class of the exception.
/// \param exception_name The name of the specified exception.
/// \param format An NSString object that contains a printf-style string containing an error message describing the failure condition and placeholders for the arguments.
/// \param ... The arguments displayed in the format string.
#define XCTAssertThrowsSpecificNamed(expression, specificException, exception_name, format...) \
    _XCTPrimitiveAssertThrowsSpecificNamed(expression, specificException, exception_name, ## format)

/// \def XCTAssertNoThrow(expression, format...)
/// \brief Generates a failure when expression does throw an exception.
/// \param expression The expression that is evaluated.
/// \param format An NSString object that contains a printf-style string containing an error message describing the failure condition and placeholders for the arguments.
/// \param ... The arguments displayed in the format string.
#define XCTAssertNoThrow(expression, format...) \
    _XCTPrimitiveAssertNoThrow(expression, ## format)

/// \def XCTAssertNoThrowSpecific(expression, specificException, format...)
/// \brief Generates a failure when expression does throw an exception of the specitied class. Any other exception is okay (i.e. does not generate a failure).
/// \param expression The expression that is evaluated.
/// \param specificException The specified class of the exception.
/// \param format An NSString object that contains a printf-style string containing an error message describing the failure condition and placeholders for the arguments.
/// \param ... The arguments displayed in the format string.
#define XCTAssertNoThrowSpecific(expression, specificException, format...) \
    _XCTPrimitiveAssertNoThrowSpecific(expression, specificException, ## format)

/// \def XCTAssertNoThrowSpecificNamed(expression, specificException, exception_name, format...)
/// \brief Generates a failure when expression does throw an exception of a specific class with a specific name.  Useful for those frameworks like AppKit or Foundation that throw generic NSException w/specific names (NSInvalidArgumentException, etc).
/// \param expression The expression that is evaluated.
/// \param specificException The specified class of the exception.
/// \param exception_name The name of the specified exception.
/// \param format An NSString object that contains a printf-style string containing an error message describing the failure condition and placeholders for the arguments.
/// \param ... The arguments displayed in the format string.
#define XCTAssertNoThrowSpecificNamed(expression, specificException, exception_name, format...) \
    _XCTPrimitiveAssertNoThrowSpecificNamed(expression, specificException, exception_name, ## format)
