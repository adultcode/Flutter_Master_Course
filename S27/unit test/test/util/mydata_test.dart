import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:unit/util/mydata.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import 'mydata_test.mocks.dart';
@GenerateMocks([MyData,Dio])
void main(){

  group('Mock tests', () {
    late MockMyData mockEx;
    late Dio mockDio;
    late MyData myData;
    setUp(() {
      mockEx = MockMyData();
      mockDio = MockDio();
      myData = MyData(mockDio);
    });

    // test dio
    test('Create new post', () async{
      when(mockDio.post(
          'https://jsonplaceholder.typicode.com/posts',
          data: anyNamed('data')
      )).thenAnswer((realInvocation) =>Future.value(Response(
        statusCode: 200,
        data: {'status':'post created'},
        requestOptions: RequestOptions(path:'https://jsonplaceholder.typicode.com/posts' )
      ))
      );

      expect(await myData.getData(title: 'Post title'), true);

    });

    // test power two
    test('PowerTwo test', (){


      when(mockEx.PowerTwo(any)).thenReturn(5);

      final result = mockEx.PowerTwo(2);

      expect(result, 5);
    });
  });
}