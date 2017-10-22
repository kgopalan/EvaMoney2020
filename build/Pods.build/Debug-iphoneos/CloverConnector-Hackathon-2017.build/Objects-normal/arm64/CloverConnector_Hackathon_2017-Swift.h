// Generated by Apple Swift version 4.0 (swiftlang-900.0.65 clang-900.0.37)
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wgcc-compat"

#if !defined(__has_include)
# define __has_include(x) 0
#endif
#if !defined(__has_attribute)
# define __has_attribute(x) 0
#endif
#if !defined(__has_feature)
# define __has_feature(x) 0
#endif
#if !defined(__has_warning)
# define __has_warning(x) 0
#endif

#if __has_attribute(external_source_symbol)
# define SWIFT_STRINGIFY(str) #str
# define SWIFT_MODULE_NAMESPACE_PUSH(module_name) _Pragma(SWIFT_STRINGIFY(clang attribute push(__attribute__((external_source_symbol(language="Swift", defined_in=module_name, generated_declaration))), apply_to=any(function, enum, objc_interface, objc_category, objc_protocol))))
# define SWIFT_MODULE_NAMESPACE_POP _Pragma("clang attribute pop")
#else
# define SWIFT_MODULE_NAMESPACE_PUSH(module_name)
# define SWIFT_MODULE_NAMESPACE_POP
#endif

#if __has_include(<swift/objc-prologue.h>)
# include <swift/objc-prologue.h>
#endif

#pragma clang diagnostic ignored "-Wauto-import"
#include <objc/NSObject.h>
#include <stdint.h>
#include <stddef.h>
#include <stdbool.h>

#if !defined(SWIFT_TYPEDEFS)
# define SWIFT_TYPEDEFS 1
# if __has_include(<uchar.h>)
#  include <uchar.h>
# elif !defined(__cplusplus) || __cplusplus < 201103L
typedef uint_least16_t char16_t;
typedef uint_least32_t char32_t;
# endif
typedef float swift_float2  __attribute__((__ext_vector_type__(2)));
typedef float swift_float3  __attribute__((__ext_vector_type__(3)));
typedef float swift_float4  __attribute__((__ext_vector_type__(4)));
typedef double swift_double2  __attribute__((__ext_vector_type__(2)));
typedef double swift_double3  __attribute__((__ext_vector_type__(3)));
typedef double swift_double4  __attribute__((__ext_vector_type__(4)));
typedef int swift_int2  __attribute__((__ext_vector_type__(2)));
typedef int swift_int3  __attribute__((__ext_vector_type__(3)));
typedef int swift_int4  __attribute__((__ext_vector_type__(4)));
typedef unsigned int swift_uint2  __attribute__((__ext_vector_type__(2)));
typedef unsigned int swift_uint3  __attribute__((__ext_vector_type__(3)));
typedef unsigned int swift_uint4  __attribute__((__ext_vector_type__(4)));
#endif

#if !defined(SWIFT_PASTE)
# define SWIFT_PASTE_HELPER(x, y) x##y
# define SWIFT_PASTE(x, y) SWIFT_PASTE_HELPER(x, y)
#endif
#if !defined(SWIFT_METATYPE)
# define SWIFT_METATYPE(X) Class
#endif
#if !defined(SWIFT_CLASS_PROPERTY)
# if __has_feature(objc_class_property)
#  define SWIFT_CLASS_PROPERTY(...) __VA_ARGS__
# else
#  define SWIFT_CLASS_PROPERTY(...)
# endif
#endif

#if __has_attribute(objc_runtime_name)
# define SWIFT_RUNTIME_NAME(X) __attribute__((objc_runtime_name(X)))
#else
# define SWIFT_RUNTIME_NAME(X)
#endif
#if __has_attribute(swift_name)
# define SWIFT_COMPILE_NAME(X) __attribute__((swift_name(X)))
#else
# define SWIFT_COMPILE_NAME(X)
#endif
#if __has_attribute(objc_method_family)
# define SWIFT_METHOD_FAMILY(X) __attribute__((objc_method_family(X)))
#else
# define SWIFT_METHOD_FAMILY(X)
#endif
#if __has_attribute(noescape)
# define SWIFT_NOESCAPE __attribute__((noescape))
#else
# define SWIFT_NOESCAPE
#endif
#if __has_attribute(warn_unused_result)
# define SWIFT_WARN_UNUSED_RESULT __attribute__((warn_unused_result))
#else
# define SWIFT_WARN_UNUSED_RESULT
#endif
#if __has_attribute(noreturn)
# define SWIFT_NORETURN __attribute__((noreturn))
#else
# define SWIFT_NORETURN
#endif
#if !defined(SWIFT_CLASS_EXTRA)
# define SWIFT_CLASS_EXTRA
#endif
#if !defined(SWIFT_PROTOCOL_EXTRA)
# define SWIFT_PROTOCOL_EXTRA
#endif
#if !defined(SWIFT_ENUM_EXTRA)
# define SWIFT_ENUM_EXTRA
#endif
#if !defined(SWIFT_CLASS)
# if __has_attribute(objc_subclassing_restricted)
#  define SWIFT_CLASS(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) __attribute__((objc_subclassing_restricted)) SWIFT_CLASS_EXTRA
#  define SWIFT_CLASS_NAMED(SWIFT_NAME) __attribute__((objc_subclassing_restricted)) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
# else
#  define SWIFT_CLASS(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
#  define SWIFT_CLASS_NAMED(SWIFT_NAME) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
# endif
#endif

#if !defined(SWIFT_PROTOCOL)
# define SWIFT_PROTOCOL(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) SWIFT_PROTOCOL_EXTRA
# define SWIFT_PROTOCOL_NAMED(SWIFT_NAME) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_PROTOCOL_EXTRA
#endif

#if !defined(SWIFT_EXTENSION)
# define SWIFT_EXTENSION(M) SWIFT_PASTE(M##_Swift_, __LINE__)
#endif

#if !defined(OBJC_DESIGNATED_INITIALIZER)
# if __has_attribute(objc_designated_initializer)
#  define OBJC_DESIGNATED_INITIALIZER __attribute__((objc_designated_initializer))
# else
#  define OBJC_DESIGNATED_INITIALIZER
# endif
#endif
#if !defined(SWIFT_ENUM_ATTR)
# if defined(__has_attribute) && __has_attribute(enum_extensibility)
#  define SWIFT_ENUM_ATTR __attribute__((enum_extensibility(open)))
# else
#  define SWIFT_ENUM_ATTR
# endif
#endif
#if !defined(SWIFT_ENUM)
# define SWIFT_ENUM(_type, _name) enum _name : _type _name; enum SWIFT_ENUM_ATTR SWIFT_ENUM_EXTRA _name : _type
# if __has_feature(generalized_swift_name)
#  define SWIFT_ENUM_NAMED(_type, _name, SWIFT_NAME) enum _name : _type _name SWIFT_COMPILE_NAME(SWIFT_NAME); enum SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_ENUM_ATTR SWIFT_ENUM_EXTRA _name : _type
# else
#  define SWIFT_ENUM_NAMED(_type, _name, SWIFT_NAME) SWIFT_ENUM(_type, _name)
# endif
#endif
#if !defined(SWIFT_UNAVAILABLE)
# define SWIFT_UNAVAILABLE __attribute__((unavailable))
#endif
#if !defined(SWIFT_UNAVAILABLE_MSG)
# define SWIFT_UNAVAILABLE_MSG(msg) __attribute__((unavailable(msg)))
#endif
#if !defined(SWIFT_AVAILABILITY)
# define SWIFT_AVAILABILITY(plat, ...) __attribute__((availability(plat, __VA_ARGS__)))
#endif
#if !defined(SWIFT_DEPRECATED)
# define SWIFT_DEPRECATED __attribute__((deprecated))
#endif
#if !defined(SWIFT_DEPRECATED_MSG)
# define SWIFT_DEPRECATED_MSG(...) __attribute__((deprecated(__VA_ARGS__)))
#endif
#if __has_feature(attribute_diagnose_if_objc)
# define SWIFT_DEPRECATED_OBJC(Msg) __attribute__((diagnose_if(1, Msg, "warning")))
#else
# define SWIFT_DEPRECATED_OBJC(Msg) SWIFT_DEPRECATED_MSG(Msg)
#endif
#if __has_feature(modules)
@import ObjectiveC;
@import Foundation;
@import clovergoclient;
@import Starscream;
#endif

#pragma clang diagnostic ignored "-Wproperty-attribute-mismatch"
#pragma clang diagnostic ignored "-Wduplicate-method-arg"
#if __has_warning("-Wpragma-clang-attribute")
# pragma clang diagnostic ignored "-Wpragma-clang-attribute"
#endif
#pragma clang diagnostic ignored "-Wunknown-pragmas"
#pragma clang diagnostic ignored "-Wnullability"

SWIFT_MODULE_NAMESPACE_PUSH("CloverConnector_Hackathon_2017")

SWIFT_CLASS("_TtC30CloverConnector_Hackathon_20177Message")
@interface Message : NSObject
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
@end


SWIFT_CLASS("_TtC30CloverConnector_Hackathon_201722AcknowledgementMessage")
@interface AcknowledgementMessage : Message
@end


SWIFT_CLASS("_TtC30CloverConnector_Hackathon_201725BaseActivityRemoteMessage")
@interface BaseActivityRemoteMessage : Message
@end


SWIFT_CLASS("_TtC30CloverConnector_Hackathon_201727ActivityMessageFromActivity")
@interface ActivityMessageFromActivity : BaseActivityRemoteMessage
@end


SWIFT_CLASS("_TtC30CloverConnector_Hackathon_201725ActivityMessageToActivity")
@interface ActivityMessageToActivity : BaseActivityRemoteMessage
@end


SWIFT_CLASS("_TtC30CloverConnector_Hackathon_201715ActivityRequest")
@interface ActivityRequest : Message
@end


SWIFT_CLASS("_TtC30CloverConnector_Hackathon_201723ActivityResponseMessage")
@interface ActivityResponseMessage : Message
@end


/// Provides base capabilities for TransactionRequests like SaleRequest, AuthRequest, PreAuthRequest, etc.
SWIFT_CLASS("_TtC30CloverConnector_Hackathon_201718TransactionRequest")
@interface TransactionRequest : NSObject
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
@end


/// The request sent to the Auth method. ‘amount’ is the only field required.
SWIFT_CLASS("_TtC30CloverConnector_Hackathon_201711AuthRequest")
@interface AuthRequest : TransactionRequest
@end


/// A base response for
SWIFT_CLASS("_TtC30CloverConnector_Hackathon_201712BaseResponse")
@interface BaseResponse : NSObject
- (nonnull instancetype)init OBJC_DESIGNATED_INITIALIZER;
@end


SWIFT_CLASS("_TtC30CloverConnector_Hackathon_201715PaymentResponse")
@interface PaymentResponse : BaseResponse
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
@end


/// The response to an auth request
SWIFT_CLASS("_TtC30CloverConnector_Hackathon_201712AuthResponse")
@interface AuthResponse : PaymentResponse
@end


/// Base message used for exchanging messages between the POS and a Custom Activity
SWIFT_CLASS("_TtC30CloverConnector_Hackathon_201719BaseActivityMessage")
@interface BaseActivityMessage : NSObject
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
@end




SWIFT_CLASS("_TtC30CloverConnector_Hackathon_201712BreakMessage")
@interface BreakMessage : Message
@end


/// options for capturing a pre-auth
SWIFT_CLASS("_TtC30CloverConnector_Hackathon_201721CapturePreAuthRequest")
@interface CapturePreAuthRequest : NSObject
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
@end


SWIFT_CLASS("_TtC30CloverConnector_Hackathon_201728CapturePreAuthRequestMessage")
@interface CapturePreAuthRequestMessage : Message
@end


/// response to a capturePreAuth request
SWIFT_CLASS("_TtC30CloverConnector_Hackathon_201722CapturePreAuthResponse")
@interface CapturePreAuthResponse : BaseResponse
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
@end


SWIFT_CLASS("_TtC30CloverConnector_Hackathon_201729CapturePreAuthResponseMessage")
@interface CapturePreAuthResponseMessage : Message
@end

@class NSCoder;

SWIFT_CLASS("_TtC30CloverConnector_Hackathon_20178CardData")
@interface CardData : NSObject <NSCoding>
- (void)encodeWithCoder:(NSCoder * _Nonnull)aCoder;
- (nonnull instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
- (nonnull instancetype)init OBJC_DESIGNATED_INITIALIZER;
@end


SWIFT_CLASS("_TtC30CloverConnector_Hackathon_201722CardDataRequestMessage")
@interface CardDataRequestMessage : Message
@end


SWIFT_CLASS("_TtC30CloverConnector_Hackathon_201723CardDataResponseMessage")
@interface CardDataResponseMessage : Message
@end


SWIFT_CLASS("_TtC30CloverConnector_Hackathon_201723CashbackSelectedMessage")
@interface CashbackSelectedMessage : Message
@end


SWIFT_CLASS("_TtC30CloverConnector_Hackathon_201715CloseoutRequest")
@interface CloseoutRequest : NSObject
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
@end


SWIFT_CLASS("_TtC30CloverConnector_Hackathon_201722CloseoutRequestMessage")
@interface CloseoutRequestMessage : Message
@end


/// response to a closeout request
SWIFT_CLASS("_TtC30CloverConnector_Hackathon_201716CloseoutResponse")
@interface CloseoutResponse : BaseResponse
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
@end


SWIFT_CLASS("_TtC30CloverConnector_Hackathon_201723CloseoutResponseMessage")
@interface CloseoutResponseMessage : Message
@end


/// generic message for unanticipated or unexpected errors
SWIFT_CLASS("_TtC30CloverConnector_Hackathon_201722CloverDeviceErrorEvent")
@interface CloverDeviceErrorEvent : NSObject
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
@end


SWIFT_CLASS("_TtC30CloverConnector_Hackathon_201717CloverDeviceEvent")
@interface CloverDeviceEvent : NSObject
- (nonnull instancetype)init OBJC_DESIGNATED_INITIALIZER;
@end

@class ReaderInfo;

SWIFT_CLASS("_TtC30CloverConnector_Hackathon_201717CloverGoConnector")
@interface CloverGoConnector : NSObject <CardReaderDelegate>
/// This delegate method is called when the card reader is detected and selected from the readers list
/// \param readers List of connected readers
///
- (void)onCardReaderDiscoveredWithReaders:(NSArray<ReaderInfo *> * _Nonnull)readers;
/// This delegate method is called after the card reader is connected
/// \param cardReaderInfo ReaderInfo object contains all the details about the reader
///
- (void)onConnectedWithCardReaderInfo:(ReaderInfo * _Nonnull)cardReaderInfo;
/// This delegate method is called after the card reader is disconnected from the app
/// \param cardReaderInfo ReaderInfo object contains all the details about the reader
///
- (void)onDisconnectedWithCardReaderInfo:(ReaderInfo * _Nonnull)cardReaderInfo;
/// This delegate method is called if we get any error with the card reader
/// \param event Gives the details about the event which caused the reader error
///
- (void)onErrorWithEvent:(enum CardReaderErrorEvent)event;
/// This delegate method is called when the card reader is undergoing a reader reset
/// \param event Gives the details about the CardReaderEvent during reader reset process
///
- (void)onReaderResetProgressWithEvent:(enum CardReaderEvent)event;
/// This delegate method is called when the reader is ready to start a new transaction. Start transaction should be called after this method.
/// \param cardReaderInfo ReaderInfo object contains details about the connected reader
///
- (void)onReadyWithCardReaderInfo:(ReaderInfo * _Nonnull)cardReaderInfo;
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
@end


SWIFT_CLASS("_TtC30CloverConnector_Hackathon_201727CloverGoDeviceConfiguration")
@interface CloverGoDeviceConfiguration : NSObject
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
@end


SWIFT_CLASS("_TtC30CloverConnector_Hackathon_201715CloverTransport")
@interface CloverTransport : NSObject
- (nonnull instancetype)init OBJC_DESIGNATED_INITIALIZER;
@end


SWIFT_CLASS("_TtC30CloverConnector_Hackathon_201721ConfirmPaymentMessage")
@interface ConfirmPaymentMessage : Message
@end


SWIFT_CLASS("_TtC30CloverConnector_Hackathon_201721ConfirmPaymentRequest")
@interface ConfirmPaymentRequest : NSObject
- (nonnull instancetype)init OBJC_DESIGNATED_INITIALIZER;
@end


SWIFT_CLASS("_TtC30CloverConnector_Hackathon_201718CreditPrintMessage")
@interface CreditPrintMessage : Message
@end


SWIFT_CLASS("_TtC30CloverConnector_Hackathon_201721CustomActivityRequest")
@interface CustomActivityRequest : BaseActivityMessage
@end


/// response when a custom activity is finished
SWIFT_CLASS("_TtC30CloverConnector_Hackathon_201722CustomActivityResponse")
@interface CustomActivityResponse : BaseResponse
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
@end


SWIFT_CLASS("_TtC30CloverConnector_Hackathon_201725DeclineCreditPrintMessage")
@interface DeclineCreditPrintMessage : Message
@end


SWIFT_CLASS("_TtC30CloverConnector_Hackathon_201726DeclinePaymentPrintMessage")
@interface DeclinePaymentPrintMessage : Message
@end


SWIFT_CLASS("_TtC30CloverConnector_Hackathon_201730DefaultCloverConnectorListener")
@interface DefaultCloverConnectorListener : NSObject
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
@end


/// Contains information about the connected device
SWIFT_CLASS("_TtC30CloverConnector_Hackathon_201710DeviceInfo")
@interface DeviceInfo : NSObject
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
@end


SWIFT_CLASS("_TtC30CloverConnector_Hackathon_201723DiscoveryRequestMessage")
@interface DiscoveryRequestMessage : Message
@end


SWIFT_CLASS("_TtC30CloverConnector_Hackathon_201724DiscoveryResponseMessage")
@interface DiscoveryResponseMessage : Message
@end


SWIFT_CLASS("_TtC30CloverConnector_Hackathon_201712DisplayOrder")
@interface DisplayOrder : NSObject
- (nonnull instancetype)init OBJC_DESIGNATED_INITIALIZER;
@end


SWIFT_CLASS("_TtC30CloverConnector_Hackathon_201719FinishCancelMessage")
@interface FinishCancelMessage : Message
@end


SWIFT_CLASS("_TtC30CloverConnector_Hackathon_201715FinishOkMessage")
@interface FinishOkMessage : Message
@end


SWIFT_CLASS("_TtC30CloverConnector_Hackathon_201717ImagePrintMessage")
@interface ImagePrintMessage : Message
@end


SWIFT_CLASS("_TtC30CloverConnector_Hackathon_201711InputOption")
@interface InputOption : NSObject
@property (nonatomic, copy) NSString * _Nonnull description;
- (nonnull instancetype)init OBJC_DESIGNATED_INITIALIZER;
@end


SWIFT_CLASS("_TtC30CloverConnector_Hackathon_201715KeyPressMessage")
@interface KeyPressMessage : Message
@end


/// options for a manual refund
SWIFT_CLASS("_TtC30CloverConnector_Hackathon_201719ManualRefundRequest")
@interface ManualRefundRequest : TransactionRequest
@end


/// response to a manual refund
SWIFT_CLASS("_TtC30CloverConnector_Hackathon_201720ManualRefundResponse")
@interface ManualRefundResponse : BaseResponse
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
@end


/// Contains merchant information as well as some high level capabilities
SWIFT_CLASS("_TtC30CloverConnector_Hackathon_201712MerchantInfo")
@interface MerchantInfo : NSObject
- (nonnull instancetype)init OBJC_DESIGNATED_INITIALIZER;
@end



/// Contains the message information send from a custom Activity
SWIFT_CLASS("_TtC30CloverConnector_Hackathon_201719MessageFromActivity")
@interface MessageFromActivity : BaseActivityMessage
@end


/// Contains the message information sent to a custom Activity
SWIFT_CLASS("_TtC30CloverConnector_Hackathon_201717MessageToActivity")
@interface MessageToActivity : BaseActivityMessage
@end


SWIFT_CLASS("_TtC30CloverConnector_Hackathon_201721OpenCashDrawerMessage")
@interface OpenCashDrawerMessage : Message
@end


SWIFT_CLASS("_TtC30CloverConnector_Hackathon_201721OpenCashDrawerRequest")
@interface OpenCashDrawerRequest : NSObject
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
@end


SWIFT_CLASS("_TtC30CloverConnector_Hackathon_201729OrderActionAddDiscountMessage")
@interface OrderActionAddDiscountMessage : Message
@end


SWIFT_CLASS("_TtC30CloverConnector_Hackathon_201726OrderActionLineItemMessage")
@interface OrderActionLineItemMessage : Message
@end


SWIFT_CLASS("_TtC30CloverConnector_Hackathon_201732OrderActionRemoveDiscountMessage")
@interface OrderActionRemoveDiscountMessage : Message
@end


SWIFT_CLASS("_TtC30CloverConnector_Hackathon_201732OrderActionRemoveLineItemMessage")
@interface OrderActionRemoveLineItemMessage : Message
@end


SWIFT_CLASS("_TtC30CloverConnector_Hackathon_201726OrderActionResponseMessage")
@interface OrderActionResponseMessage : Message
@end


SWIFT_CLASS("_TtC30CloverConnector_Hackathon_201718OrderUpdateMessage")
@interface OrderUpdateMessage : Message
@end


SWIFT_CLASS("_TtC30CloverConnector_Hackathon_201718PartialAuthMessage")
@interface PartialAuthMessage : Message
@end


SWIFT_CLASS("_TtC30CloverConnector_Hackathon_201723PaymentConfirmedMessage")
@interface PaymentConfirmedMessage : Message
@end


SWIFT_CLASS("_TtC30CloverConnector_Hackathon_201731PaymentPrintMerchantCopyMessage")
@interface PaymentPrintMerchantCopyMessage : Message
@end


SWIFT_CLASS("_TtC30CloverConnector_Hackathon_201719PaymentPrintMessage")
@interface PaymentPrintMessage : Message
@end


SWIFT_CLASS("_TtC30CloverConnector_Hackathon_201722PaymentRejectedMessage")
@interface PaymentRejectedMessage : Message
@end



SWIFT_CLASS("_TtC30CloverConnector_Hackathon_201720PaymentVoidedMessage")
@interface PaymentVoidedMessage : Message
@end


SWIFT_CLASS("_TtC30CloverConnector_Hackathon_201719PendingPaymentEntry")
@interface PendingPaymentEntry : NSObject <NSCoding>
- (void)encodeWithCoder:(NSCoder * _Nonnull)aCoder;
- (nonnull instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
- (nonnull instancetype)init OBJC_DESIGNATED_INITIALIZER;
@end


/// options for a pre-authorization request
SWIFT_CLASS("_TtC30CloverConnector_Hackathon_201714PreAuthRequest")
@interface PreAuthRequest : TransactionRequest
@end


/// response to a pre-auth request
SWIFT_CLASS("_TtC30CloverConnector_Hackathon_201715PreAuthResponse")
@interface PreAuthResponse : PaymentResponse
@end


SWIFT_CLASS("_TtC30CloverConnector_Hackathon_201721PrintJobStatusRequest")
@interface PrintJobStatusRequest : NSObject
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
@end


SWIFT_CLASS("_TtC30CloverConnector_Hackathon_201728PrintJobStatusRequestMessage")
@interface PrintJobStatusRequestMessage : Message
@end


SWIFT_CLASS("_TtC30CloverConnector_Hackathon_201722PrintJobStatusResponse")
@interface PrintJobStatusResponse : NSObject
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
@end


SWIFT_CLASS("_TtC30CloverConnector_Hackathon_201729PrintJobStatusResponseMessage")
@interface PrintJobStatusResponseMessage : Message
@end


/// Callback to the POS to request a manual refund declined receipt
SWIFT_CLASS("_TtC30CloverConnector_Hackathon_201738PrintManualRefundDeclineReceiptMessage")
@interface PrintManualRefundDeclineReceiptMessage : NSObject
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
@end


/// Callback to request the POS print a refund for a
/// ManualRefund
SWIFT_CLASS("_TtC30CloverConnector_Hackathon_201731PrintManualRefundReceiptMessage")
@interface PrintManualRefundReceiptMessage : NSObject
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
@end


/// Callback to the POS to request a payment declined receipt
SWIFT_CLASS("_TtC30CloverConnector_Hackathon_201733PrintPaymentDeclineReceiptMessage")
@interface PrintPaymentDeclineReceiptMessage : NSObject
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
@end


/// <ul>
///   <li>
///     Callback to the POS to request a merchant copy of the payment receipt
///   </li>
/// </ul>
SWIFT_CLASS("_TtC30CloverConnector_Hackathon_201738PrintPaymentMerchantCopyReceiptMessage")
@interface PrintPaymentMerchantCopyReceiptMessage : NSObject
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
@end


/// Callback to the POS to request a payment receipt be printed
SWIFT_CLASS("_TtC30CloverConnector_Hackathon_201726PrintPaymentReceiptMessage")
@interface PrintPaymentReceiptMessage : NSObject
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
@end


/// <ul>
///   <li>
///     Callback to the POS to request a refund payment receipt
///   </li>
/// </ul>
SWIFT_CLASS("_TtC30CloverConnector_Hackathon_201732PrintRefundPaymentReceiptMessage")
@interface PrintRefundPaymentReceiptMessage : NSObject
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
@end


SWIFT_CLASS("_TtC30CloverConnector_Hackathon_201712PrintRequest")
@interface PrintRequest : NSObject
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
@end


/// options for a request to read card data
SWIFT_CLASS("_TtC30CloverConnector_Hackathon_201719ReadCardDataRequest")
@interface ReadCardDataRequest : NSObject
- (nonnull instancetype)init OBJC_DESIGNATED_INITIALIZER;
@end


/// response to a read card data request
SWIFT_CLASS("_TtC30CloverConnector_Hackathon_201720ReadCardDataResponse")
@interface ReadCardDataResponse : BaseResponse
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
@end


SWIFT_CLASS("_TtC30CloverConnector_Hackathon_201725RefundPaymentPrintMessage")
@interface RefundPaymentPrintMessage : Message
@end


/// options for refunding a payment
SWIFT_CLASS("_TtC30CloverConnector_Hackathon_201720RefundPaymentRequest")
@interface RefundPaymentRequest : NSObject
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
@end


/// response to a refund payment request
SWIFT_CLASS("_TtC30CloverConnector_Hackathon_201721RefundPaymentResponse")
@interface RefundPaymentResponse : BaseResponse
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
@end


SWIFT_CLASS("_TtC30CloverConnector_Hackathon_201720RefundRequestMessage")
@interface RefundRequestMessage : Message
@end


SWIFT_CLASS("_TtC30CloverConnector_Hackathon_201721RefundResponseMessage")
@interface RefundResponseMessage : Message
@end


/// response to a resetDevice request. It contains the state
/// of the device
SWIFT_CLASS("_TtC30CloverConnector_Hackathon_201719ResetDeviceResponse")
@interface ResetDeviceResponse : BaseResponse
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
@end


SWIFT_CLASS("_TtC30CloverConnector_Hackathon_201726ResetDeviceResponseMessage")
@interface ResetDeviceResponseMessage : Message
@end


SWIFT_CLASS("_TtC30CloverConnector_Hackathon_201734RetrieveDeviceStatusRequestMessage")
@interface RetrieveDeviceStatusRequestMessage : Message
@end


/// response to a retrieve device status request
SWIFT_CLASS("_TtC30CloverConnector_Hackathon_201728RetrieveDeviceStatusResponse")
@interface RetrieveDeviceStatusResponse : BaseResponse
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
@end


SWIFT_CLASS("_TtC30CloverConnector_Hackathon_201735RetrieveDeviceStatusResponseMessage")
@interface RetrieveDeviceStatusResponseMessage : Message
@end


SWIFT_CLASS("_TtC30CloverConnector_Hackathon_201729RetrievePaymentRequestMessage")
@interface RetrievePaymentRequestMessage : Message
@end


/// response to a retrieve payment request
SWIFT_CLASS("_TtC30CloverConnector_Hackathon_201723RetrievePaymentResponse")
@interface RetrievePaymentResponse : BaseResponse
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
@end


SWIFT_CLASS("_TtC30CloverConnector_Hackathon_201730RetrievePaymentResponseMessage")
@interface RetrievePaymentResponseMessage : Message
@end


SWIFT_CLASS("_TtC30CloverConnector_Hackathon_201737RetrievePendingPaymentsRequestMessage")
@interface RetrievePendingPaymentsRequestMessage : Message
@end


/// resopnse to a retrieve pending payments request
SWIFT_CLASS("_TtC30CloverConnector_Hackathon_201731RetrievePendingPaymentsResponse")
@interface RetrievePendingPaymentsResponse : BaseResponse
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
@end


SWIFT_CLASS("_TtC30CloverConnector_Hackathon_201723RetrievePrintersRequest")
@interface RetrievePrintersRequest : NSObject
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
@end


SWIFT_CLASS("_TtC30CloverConnector_Hackathon_201730RetrievePrintersRequestMessage")
@interface RetrievePrintersRequestMessage : Message
@end


SWIFT_CLASS("_TtC30CloverConnector_Hackathon_201724RetrievePrintersResponse")
@interface RetrievePrintersResponse : NSObject
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
@end


SWIFT_CLASS("_TtC30CloverConnector_Hackathon_201731RetrievePrintersResponseMessage")
@interface RetrievePrintersResponseMessage : Message
@end


/// Contains configuration options for processing a sale.
SWIFT_CLASS("_TtC30CloverConnector_Hackathon_201711SaleRequest")
@interface SaleRequest : TransactionRequest
@end


/// response to a sale request
SWIFT_CLASS("_TtC30CloverConnector_Hackathon_201712SaleResponse")
@interface SaleResponse : PaymentResponse
@end


SWIFT_CLASS("_TtC30CloverConnector_Hackathon_201732ShowPaymentReceiptOptionsMessage")
@interface ShowPaymentReceiptOptionsMessage : Message
@end


SWIFT_CLASS("_TtC30CloverConnector_Hackathon_201725ShowThankYouScreenMessage")
@interface ShowThankYouScreenMessage : Message
@end


SWIFT_CLASS("_TtC30CloverConnector_Hackathon_201724ShowWelcomeScreenMessage")
@interface ShowWelcomeScreenMessage : Message
@end


SWIFT_CLASS("_TtC30CloverConnector_Hackathon_201724SignatureVerifiedMessage")
@interface SignatureVerifiedMessage : Message
@end


SWIFT_CLASS("_TtC30CloverConnector_Hackathon_201715TerminalMessage")
@interface TerminalMessage : Message
@end


SWIFT_CLASS("_TtC30CloverConnector_Hackathon_201716TextPrintMessage")
@interface TextPrintMessage : Message
@end


SWIFT_CLASS("_TtC30CloverConnector_Hackathon_201715TipAddedMessage")
@interface TipAddedMessage : Message
@end


/// options for a tip adjust request
SWIFT_CLASS("_TtC30CloverConnector_Hackathon_201720TipAdjustAuthRequest")
@interface TipAdjustAuthRequest : NSObject
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
@end


/// response to a tip adjust request
SWIFT_CLASS("_TtC30CloverConnector_Hackathon_201721TipAdjustAuthResponse")
@interface TipAdjustAuthResponse : BaseResponse
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
@end


SWIFT_CLASS("_TtC30CloverConnector_Hackathon_201716TipAdjustMessage")
@interface TipAdjustMessage : Message
@end


SWIFT_CLASS("_TtC30CloverConnector_Hackathon_201724TipAdjustResponseMessage")
@interface TipAdjustResponseMessage : Message
@end



SWIFT_CLASS("_TtC30CloverConnector_Hackathon_201721TxStartRequestMessage")
@interface TxStartRequestMessage : Message
@end


SWIFT_CLASS("_TtC30CloverConnector_Hackathon_201722TxStartResponseMessage")
@interface TxStartResponseMessage : Message
@end


SWIFT_CLASS("_TtC30CloverConnector_Hackathon_201714TxStateMessage")
@interface TxStateMessage : Message
@end


SWIFT_CLASS("_TtC30CloverConnector_Hackathon_201714UiStateMessage")
@interface UiStateMessage : Message
@end


SWIFT_CLASS("_TtC30CloverConnector_Hackathon_201716VaultCardMessage")
@interface VaultCardMessage : Message
@end


/// options for a vault card request
SWIFT_CLASS("_TtC30CloverConnector_Hackathon_201716VaultCardRequest")
@interface VaultCardRequest : NSObject
- (nonnull instancetype)init OBJC_DESIGNATED_INITIALIZER;
@end


/// resonse to a vault card request
SWIFT_CLASS("_TtC30CloverConnector_Hackathon_201717VaultCardResponse")
@interface VaultCardResponse : BaseResponse
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
@end


SWIFT_CLASS("_TtC30CloverConnector_Hackathon_201724VaultCardResponseMessage")
@interface VaultCardResponseMessage : Message
@end


/// request information for a request initiated by the device
/// for a transaction
SWIFT_CLASS("_TtC30CloverConnector_Hackathon_201722VerifySignatureRequest")
@interface VerifySignatureRequest : NSObject
- (nonnull instancetype)init OBJC_DESIGNATED_INITIALIZER;
@end


SWIFT_CLASS("_TtC30CloverConnector_Hackathon_201718VoidPaymentMessage")
@interface VoidPaymentMessage : Message
@end


/// options for void payment request
SWIFT_CLASS("_TtC30CloverConnector_Hackathon_201718VoidPaymentRequest")
@interface VoidPaymentRequest : NSObject
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
@end


/// response to a void payment request
SWIFT_CLASS("_TtC30CloverConnector_Hackathon_201719VoidPaymentResponse")
@interface VoidPaymentResponse : BaseResponse
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
@end




SWIFT_CLASS("_TtC30CloverConnector_Hackathon_201728WebSocketDeviceConfiguration")
@interface WebSocketDeviceConfiguration : NSObject
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
@end

SWIFT_MODULE_NAMESPACE_POP
#pragma clang diagnostic pop
