library search;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart' show Provider;
import 'package:long_life_burning/pages/announce/detail_page.dart';
import 'package:long_life_burning/utils/providers/all.dart' show Provider, EventProvider;
import '../event/events.dart'
  show
    Event,
    EventCallback;

part './widgets.dart';

enum SearchWhere { title, subtitle, category, province }

class SearchEventDelegate extends SearchDelegate<Event> {

  SearchEventDelegate({
    String searchFieldLabel,
    TextInputType keyboardType,
    TextInputAction textInputAction,
  }) : super(
    searchFieldLabel: searchFieldLabel,
    keyboardType: keyboardType,
    textInputAction: textInputAction,
  );

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.arrow_back_ios,
      ),
      onPressed: () async => close(context, null),
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      query.isEmpty
        ? IconButton(
            icon: Icon(Icons.search),
            onPressed: () async => showSuggestions(context),
          )
        : IconButton(
            icon: Icon(Icons.clear),
            onPressed: () async {
              query = '';
              showSuggestions(context);
            },
          ),
    ];
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final EventProvider provider = Provider.of<EventProvider>(context);
    Map<Event, SearchWhere> _map = <Event, SearchWhere>{};

    final Iterable<Event> suggestions = query.isNotEmpty
      ? provider?.events?.where((Event e) {
          if (e.title.toLowerCase().trim().startsWith(query.toLowerCase().trim())) {
            _map[e] = SearchWhere.title;
            return true;
          }
          if (e.subtitle.toLowerCase().trim().startsWith(query.toLowerCase().trim())) {
            _map[e] = SearchWhere.subtitle;
            return true;
          }
          if (e.province.toLowerCase().trim().startsWith(query.toLowerCase().trim())) {
            _map[e] = SearchWhere.province;
            return true;
          }
          if (e.category.toLowerCase().trim().startsWith(query.toLowerCase().trim())) {
            _map[e] = SearchWhere.category;
            return true;
          }
          return false;
        }) ?? <Event>[]
      : <Event>[];

    if (query.isNotEmpty && suggestions.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.search,
              size: 100.0,
            ),
            Text(
              'No Result',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Try a more general keyword.\nSearch try again.',
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      );
    }

    return _SuggestionList(
      query: query,
      mapCategory: _map,
      suggestions: suggestions.toList(),
      onSelected: (Event data) async => await Navigator.of(context).pushNamed(EventDetailPage.routeName, arguments: data),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

}
