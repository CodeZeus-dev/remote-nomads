import 'package:flutter/material.dart';
import 'package:remote_nomads/tools/authentication/email_password_auth.dart';
import 'package:remote_nomads/tools/helpers/fetch_daily_quote.dart';
import 'package:remote_nomads/tools/models/Quote.dart';
import 'package:http/http.dart' as http;

class QuotePage extends StatefulWidget {
  const QuotePage({super.key});

  @override
  State<QuotePage> createState() => _QuotePageState();
}

class _QuotePageState extends State<QuotePage> {
  late Future<Quote> futureQuote;

  @override
  void initState() {
    super.initState();
    futureQuote = fetchDailyQuote(http.Client());
  }

  // To reload the API in response to an InheritedWidget changing,
  // put the fetchDailyQuote() into the didChangeDependencies() method.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Remote Nomads"),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              signOut();
            },
            icon: Icon(
              Icons.logout,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/quote_background_profile.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: FutureBuilder<Quote>(
            future: futureQuote,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(snapshot.data!.quote);
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
