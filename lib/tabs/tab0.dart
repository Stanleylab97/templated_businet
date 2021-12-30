import 'package:flutter/material.dart';
import 'package:news_app/blocs/featured_bloc.dart';
import 'package:news_app/blocs/popular_articles_bloc.dart';
import 'package:news_app/blocs/recent_articles_bloc.dart';
import 'package:news_app/pages/entrepreneur/posts/widgets/home_bloc.dart';
import 'package:news_app/pages/entrepreneur/posts/widgets/widgets.dart';
import 'package:provider/provider.dart';

class Tab0 extends StatefulWidget {
  Tab0({Key key}) : super(key: key);

  @override
  _Tab0State createState() => _Tab0State();
}

class _Tab0State extends State<Tab0> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<HomeBLoC>(context, listen: false);

    return RefreshIndicator(
        onRefresh: () async {
          context.read<FeaturedBloc>().onRefresh();
          context.read<PopularBloc>().onRefresh();
          context.read<RecentBloc>().onRefresh(mounted);
        },
        child: Positioned.fill(
          child: CustomScrollView(
            controller: provider.controller,
            slivers: [NewPost(), const ListPost()],
          ),
        ));
  }
}
