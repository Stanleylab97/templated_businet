import 'package:flutter/material.dart';
import 'package:news_app/pages/entrepreneur/posts/widgets/home_bloc.dart';
import 'package:news_app/pages/entrepreneur/posts/widgets/widgets.dart';
import 'package:provider/provider.dart';

class Posts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Stack(children: [
        const _Body(), /*const NavBar()*/
      ]),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<HomeBLoC>(context, listen: false);
    return Positioned.fill(
      child: CustomScrollView(
        controller: provider.controller,
        slivers: [const Header(), const NewPost(), const ListPost()],
      ),
    );
  }
}
