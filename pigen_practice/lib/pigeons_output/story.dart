// Autogenerated from Pigeon (v4.2.5), do not edit directly.
// See also: https://pub.dev/packages/pigeon
// ignore_for_file: public_member_api_docs, non_constant_identifier_names, avoid_as, unused_import, unnecessary_parenthesis, prefer_null_aware_operators, omit_local_variable_types, unused_shown_name, unnecessary_import
import 'dart:async';
import 'dart:typed_data' show Float64List, Int32List, Int64List, Uint8List;

import 'package:flutter/foundation.dart' show ReadBuffer, WriteBuffer;
import 'package:flutter/services.dart';

class Story {
  Story({
    this.title,
    this.author,
    this.comments,
    this.rates,
    this.year,
    this.isFavorite,
  });

  String? title;
  String? author;
  List<Comment?>? comments;
  double? rates;
  int? year;
  bool? isFavorite;

  Object encode() {
    final Map<Object?, Object?> pigeonMap = <Object?, Object?>{};
    pigeonMap['title'] = title;
    pigeonMap['author'] = author;
    pigeonMap['comments'] = comments;
    pigeonMap['rates'] = rates;
    pigeonMap['year'] = year;
    pigeonMap['isFavorite'] = isFavorite;
    return pigeonMap;
  }

  static Story decode(Object message) {
    final Map<Object?, Object?> pigeonMap = message as Map<Object?, Object?>;
    return Story(
      title: pigeonMap['title'] as String?,
      author: pigeonMap['author'] as String?,
      comments: (pigeonMap['comments'] as List<Object?>?)?.cast<Comment?>(),
      rates: pigeonMap['rates'] as double?,
      year: pigeonMap['year'] as int?,
      isFavorite: pigeonMap['isFavorite'] as bool?,
    );
  }
}

class Comment {
  Comment({
    this.user,
    this.body,
  });

  String? user;
  String? body;

  Object encode() {
    final Map<Object?, Object?> pigeonMap = <Object?, Object?>{};
    pigeonMap['user'] = user;
    pigeonMap['body'] = body;
    return pigeonMap;
  }

  static Comment decode(Object message) {
    final Map<Object?, Object?> pigeonMap = message as Map<Object?, Object?>;
    return Comment(
      user: pigeonMap['user'] as String?,
      body: pigeonMap['body'] as String?,
    );
  }
}

class _HostStoryApiCodec extends StandardMessageCodec{
  const _HostStoryApiCodec();
  @override
  void writeValue(WriteBuffer buffer, Object? value) {
    if (value is Comment) {
      buffer.putUint8(128);
      writeValue(buffer, value.encode());
    } else 
    if (value is Story) {
      buffer.putUint8(129);
      writeValue(buffer, value.encode());
    } else 
{
      super.writeValue(buffer, value);
    }
  }
  @override
  Object? readValueOfType(int type, ReadBuffer buffer) {
    switch (type) {
      case 128:       
        return Comment.decode(readValue(buffer)!);
      
      case 129:       
        return Story.decode(readValue(buffer)!);
      
      default:      
        return super.readValueOfType(type, buffer);
      
    }
  }
}

class HostStoryApi {
  /// Constructor for [HostStoryApi].  The [binaryMessenger] named argument is
  /// available for dependency injection.  If it is left null, the default
  /// BinaryMessenger will be used which routes to the host platform.
  HostStoryApi({BinaryMessenger? binaryMessenger}) : _binaryMessenger = binaryMessenger;
  final BinaryMessenger? _binaryMessenger;

  static const MessageCodec<Object?> codec = _HostStoryApiCodec();

  Future<Story?> respond() async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.HostStoryApi.respond', codec, binaryMessenger: _binaryMessenger);
    final Map<Object?, Object?>? replyMap =
        await channel.send(null) as Map<Object?, Object?>?;
    if (replyMap == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyMap['error'] != null) {
      final Map<Object?, Object?> error = (replyMap['error'] as Map<Object?, Object?>?)!;
      throw PlatformException(
        code: (error['code'] as String?)!,
        message: error['message'] as String?,
        details: error['details'],
      );
    } else {
      return (replyMap['result'] as Story?);
    }
  }
}