import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../../../core/presentation/state/state_result_switcher.dart';
import '../../../core/presentation/components/rounded_button.dart';
import '../../../core/design/text_style.dart';
import '../../../core/failures/failure.dart';
import '../controllers/home_controller.dart';
import '../entity/character.dart';
import 'widgets/character_card.dart';
import 'widgets/loading_home_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeController _controller = HomeController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(
      () {
        if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent) {
          if (!_controller.paginationError &&
              !_controller.isLoading &&
              _controller.totalElements > _controller.limit &&
              _controller.totalElements >
                  (_controller.offset / _controller.limit) *
                      _controller.limit) {
            _controller.getCharactersPaged();
          }
        }
      },
    );
    _controller.getCharacters();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      return getStateResultSwitcher<List<Character>>(
        state: _controller.state,
        buildLoadingState: _getBodyLoading,
        buildFailureState: _getBodyFailure,
        buildExceptionState: _getBodyException,
        buildSuccessState: _getBodySucess,
      );
    });
  }

  Widget _getBodyLoading() {
    return Scaffold(
      appBar: _appBar(),
      backgroundColor: Color.fromARGB(255, 34, 34, 34),
      body: LoadingHomePage(),
    );
  }

  Widget _getBodyException(Exception exception) => errorPage;

  Widget _getBodyFailure(Failure failure) => errorPage;

  Widget get errorPage => Scaffold(
      appBar: _appBar(),
      backgroundColor: Color(0x222222),
      body: Container(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Request failed. \nTry again later",
              style: AppTextStyle.h1,
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: RoundedButton(
                text: "Try again",
                onTap: _controller.getCharacters,
              ),
            ),
          ],
        ),
      ));

  Widget _getBodySucess(List<Character> characters) {
    final int listLength = characters.length;
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 34, 34, 34),
        appBar: _appBar(),
        body: CustomScrollView(
          controller: _scrollController,
          slivers: [
            SliverList(
              delegate: SliverChildBuilderDelegate(
                  childCount: listLength,
                  addAutomaticKeepAlives: true, (_, index) {
                var character = characters[index];

                if (listLength == (index + 1) &&
                    _controller.totalElements > _controller.limit &&
                    _controller.totalElements >
                        _controller.offset * _controller.limit) {
                  return Observer(builder: (context) {
                    return _controller.paginationError
                        ? _getFailurePaging(character)
                        : _getLoadingInPaging(character);
                  });
                }

                return Padding(
                    padding:
                        const EdgeInsets.only(bottom: 12, left: 12, right: 12),
                    child: CharacterCard(character: character));
              }),
            ),
          ],
        ));
  }

  AppBar _appBar() {
    return AppBar(
      title: Text(
        'Marvel Characters',
        style: AppTextStyle.h2,
      ),
      elevation: 2,
      backgroundColor: Color.fromARGB(255, 34, 34, 34),
      systemOverlayStyle: SystemUiOverlayStyle.light,
    );
  }

  Widget _getLoadingInPaging(Character character) => Column(children: [
        Padding(
          padding: const EdgeInsets.only(
            left: 12,
            right: 12,
            bottom: 24,
          ),
          child: CharacterCard(character: character),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: CircularProgressIndicator(color: Colors.white),
        ),
      ]);

  Widget _getFailurePaging(Character character) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        children: [
          CharacterCard(character: character),
          SizedBox(
            height: 12,
          ),
          Text(
            "Ops, it looks like an error occurred when loading more characters.",
            textAlign: TextAlign.center,
            style: AppTextStyle.p2Regular,
          ),
          SizedBox(
            height: 16,
          ),
          RoundedButton(
            text: "Try again",
            onTap: _controller.getCharactersPaged,
          ),
          SizedBox(
            height: 24,
          ),
        ],
      ),
    );
  }
}
