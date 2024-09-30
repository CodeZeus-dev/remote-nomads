import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:remote_nomads/tools/models/Quote.dart';

Future<Quote> fetchDailyQuote(http.Client client) async {
  final url =
      Uri.parse('https://api.api-ninjas.com/v1/quotes?category=inspirational');

  final headers = {
    'Content-Type': 'application/json',
    'x-api-key':
        "MU9/lzgjqm49kIyksybC1g==1T5vC9ag5AK1VOKM", //dotenv.env['API_NINJAS_KEY']!,
  };

  try {
    final response = await client.get(
      url,
      headers: headers,
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = jsonDecode(response.body);
      if (jsonResponse.isNotEmpty) {
        return Quote.fromJson(jsonResponse[0] as Map<String, dynamic>);
      } else {
        throw Exception('No quotes found.');
      }
    } else {
      throw Exception('Failed to load Quote: ${response.statusCode}');
    }
  } catch (e) {
    if (e is FormatException) {
      rethrow;
    }
    throw Exception('Error occurred while fetching quote: $e');
  }
}
