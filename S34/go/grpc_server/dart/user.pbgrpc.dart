// This is a generated file - do not edit.
//
// Generated from user.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'package:protobuf/protobuf.dart' as $pb;

import 'user.pb.dart' as $0;

export 'user.pb.dart';

@$pb.GrpcServiceName('Students')
class StudentsClient extends $grpc.Client {
  /// The hostname for this service.
  static const $core.String defaultHost = '';

  /// OAuth scopes needed for the client.
  static const $core.List<$core.String> oauthScopes = [
    '',
  ];

  StudentsClient(super.channel, {super.options, super.interceptors});

  $grpc.ResponseFuture<$0.GetUserResponse> getUser(
    $0.GetUserRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getUser, request, options: options);
  }

  $grpc.ResponseStream<$0.GetUserResponse> streamUsers(
    $0.StreamUsersRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createStreamingCall(
        _$streamUsers, $async.Stream.fromIterable([request]),
        options: options);
  }

  // method descriptors

  static final _$getUser =
      $grpc.ClientMethod<$0.GetUserRequest, $0.GetUserResponse>(
          '/Students/GetUser',
          ($0.GetUserRequest value) => value.writeToBuffer(),
          $0.GetUserResponse.fromBuffer);
  static final _$streamUsers =
      $grpc.ClientMethod<$0.StreamUsersRequest, $0.GetUserResponse>(
          '/Students/StreamUsers',
          ($0.StreamUsersRequest value) => value.writeToBuffer(),
          $0.GetUserResponse.fromBuffer);
}

@$pb.GrpcServiceName('Students')
abstract class StudentsServiceBase extends $grpc.Service {
  $core.String get $name => 'Students';

  StudentsServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.GetUserRequest, $0.GetUserResponse>(
        'GetUser',
        getUser_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetUserRequest.fromBuffer(value),
        ($0.GetUserResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.StreamUsersRequest, $0.GetUserResponse>(
        'StreamUsers',
        streamUsers_Pre,
        false,
        true,
        ($core.List<$core.int> value) =>
            $0.StreamUsersRequest.fromBuffer(value),
        ($0.GetUserResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.GetUserResponse> getUser_Pre($grpc.ServiceCall $call,
      $async.Future<$0.GetUserRequest> $request) async {
    return getUser($call, await $request);
  }

  $async.Future<$0.GetUserResponse> getUser(
      $grpc.ServiceCall call, $0.GetUserRequest request);

  $async.Stream<$0.GetUserResponse> streamUsers_Pre($grpc.ServiceCall $call,
      $async.Future<$0.StreamUsersRequest> $request) async* {
    yield* streamUsers($call, await $request);
  }

  $async.Stream<$0.GetUserResponse> streamUsers(
      $grpc.ServiceCall call, $0.StreamUsersRequest request);
}
