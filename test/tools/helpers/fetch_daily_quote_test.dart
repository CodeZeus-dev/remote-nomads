import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:remote_nomads/tools/helpers/fetch_daily_quote.dart';
import 'package:remote_nomads/tools/models/Quote.dart';
import 'package:test/test.dart';

import 'fetch_daily_quote_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  final url =
      Uri.parse('https://api.api-ninjas.com/v1/quotes?category=inspirational');

  final headers = {
    'Content-Type': 'application/json',
    'x-api-key':
        "MU9/lzgjqm49kIyksybC1g==1T5vC9ag5AK1VOKM", //dotenv.env['API_NINJAS_KEY']!,
  };

  late MockClient client;

  setUp(() {
    client = MockClient();
  });

  group('fetchDailyQuote', () {
    test('returns a Quote if the http call completes successfully', () async {
      when(
        client.get(url, headers: headers),
      ).thenAnswer((_) async => http.Response(
          '[{"quote": "Keep moving forward","author": "Walt Disney","category": "inspiration"}]',
          200));

      expect(await fetchDailyQuote(client), isA<Quote>());
    });

    test('throws an exception if the response is empty', () async {
      when(
        client.get(url, headers: headers),
      ).thenAnswer(
        (_) async => http.Response('[]', 200),
      );

      expect(fetchDailyQuote(client), throwsException);
    });

    test('throws an exception if the http call completes with an error', () {
      when(
        client.get(url, headers: headers),
      ).thenAnswer((_) async => http.Response('Not Found', 404));

      expect(fetchDailyQuote(client), throwsException);
    });

    test('throws an exception if the response status code is not 200',
        () async {
      when(client.get(url, headers: headers)).thenAnswer(
        (_) async => http.Response('Not Found', 404),
      );

      expect(fetchDailyQuote(client), throwsException);
    });

    test('throws an exception on network error', () async {
      when(client.get(url, headers: headers)).thenThrow(
        Exception('Network error'),
      );

      expect(fetchDailyQuote(client), throwsException);
    });

    test('throws an exception if the JSON is invalid', () async {
      when(client.get(url, headers: headers)).thenAnswer(
        (_) async => http.Response('Invalid JSON', 200),
      );

      expect(fetchDailyQuote(client), throwsA(isA<FormatException>()));
    });

    test('handles missing fields in the response', () async {
      when(client.get(url, headers: headers)).thenAnswer(
        (_) async => http.Response(
          '[{"quote": "Keep moving forward.","category": "inspiration"}]', // Missing author
          200,
        ),
      );

      final quote = await fetchDailyQuote(client);
      expect(quote.author, 'Unknown'); // Check default value
    });

    test('handles null values in the response', () async {
      when(client.get(url, headers: headers)).thenAnswer(
        (_) async => http.Response(
          '[{"quote": null,"author": null,"category": null}]', // Null values
          200,
        ),
      );

      final quote = await fetchDailyQuote(client);
      expect(quote.quote, 'No quote available'); // Check default value
      expect(quote.author, 'Unknown'); // Check default value
      expect(quote.category, 'General'); // Check default value
    });
  });
}
