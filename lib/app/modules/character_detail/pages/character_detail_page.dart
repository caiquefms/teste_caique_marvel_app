import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../../../core/presentation/components/custom_network_image.dart';
import '../../../core/presentation/components/horizontal_divisor.dart';
import '../../../core/presentation/state/state_result_switcher.dart';
import '../../../core/presentation/components/rounded_button.dart';
import '../../../core/design/text_style.dart';
import '../../../core/failures/failure.dart';
import '../../home/entity/character.dart';
import '../controllers/character_detail_controller.dart';
import '../entity/comic.dart';
import 'widgets/loading_character_detail_page.dart';
import 'widgets/comic_card.dart';

class CharacterDetailPage extends StatefulWidget {
  final Character character;

  CharacterDetailPage({
    required this.character,
    Key? key,
  }) : super(key: key);

  @override
  State<CharacterDetailPage> createState() => _CharacterDetailPageState();
}

class _CharacterDetailPageState extends State<CharacterDetailPage> {
  final CharacterDetailController _controller = CharacterDetailController();
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
              _controller.totalElements >=
                  (_controller.offset / _controller.limit) *
                      _controller.limit) {
            _controller.getComicsPaged();
          }
        }
      },
    );
    _controller.getComics(widget.character.characterId);
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      return getStateResultSwitcher<List<Comic>>(
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
      backgroundColor: Color(0x222222),
      body: LoadingCharacterDetailPage(),
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
                onTap: () =>
                    _controller.getComics(widget.character.characterId),
              ),
            ),
          ],
        ),
      ));

  Widget _getBodySucess(List<Comic> comics) {
    final int listLength = comics.length;
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 34, 34, 34),
        appBar: _appBar(),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 18),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: CustomNetworkImage(
                    path:
                        "${widget.character.thumbnail}/standard_fantastic.jpg",
                    width: (MediaQuery.of(context).size.width - 24) * 0.85,
                    height: (MediaQuery.of(context).size.width - 24) * 0.85,
                  ),
                ),
                if (widget.character.description.isNotEmpty)
                  ...getTitleSpace(
                    "Description",
                    Text(
                      widget.character.description,
                      style: AppTextStyle.p2Semibold,
                    ),
                  ),
                ...getTitleSpace(
                    "Comics Info",
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        getCountInfo(widget.character.numberComics, "comics"),
                        getCountInfo(widget.character.numberSeries, "series"),
                        getCountInfo(widget.character.numberStories, "stories"),
                        getCountInfo(widget.character.numberEvents, "events"),
                      ],
                    )),
                SizedBox(
                  height: 20,
                ),
                if (comics.isNotEmpty)
                  Container(
                    height: MediaQuery.of(context).size.height / 2,
                    child: CustomScrollView(
                      scrollDirection: Axis.horizontal,
                      controller: _scrollController,
                      shrinkWrap: true,
                      slivers: [
                        SliverList(
                          delegate: SliverChildBuilderDelegate(
                              childCount: listLength,
                              addAutomaticKeepAlives: true, (_, index) {
                            var comic = comics[index];

                            if (listLength == (index + 1) &&
                                _controller.totalElements > _controller.limit &&
                                _controller.totalElements >
                                    _controller.offset * _controller.limit) {
                              return Observer(builder: (context) {
                                return _controller.paginationError
                                    ? _getFailurePaging(comic)
                                    : getLoadingNaPaginacao(comic);
                              });
                            }

                            return Padding(
                                padding: const EdgeInsets.only(
                                    bottom: 12, right: 24),
                                child: ComicCard(comic: comic));
                          }),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ));
  }

  AppBar _appBar() {
    return AppBar(
      title: Text(
        widget.character.name,
        style: AppTextStyle.h1,
      ),
      centerTitle: true,
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(
          Icons.arrow_back,
          color: Colors.white,
        ),
      ),
      elevation: 2,
      backgroundColor: Color.fromARGB(255, 34, 34, 34),
      systemOverlayStyle: SystemUiOverlayStyle.light,
    );
  }

  Widget getLoadingNaPaginacao(Comic comic) => Row(children: [
        Padding(
          padding: const EdgeInsets.only(
            left: 12,
            right: 12,
            bottom: 24,
          ),
          child: ComicCard(
            comic: comic,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: CircularProgressIndicator(color: Colors.white),
        ),
      ]);

  Widget _getFailurePaging(Comic comic) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          children: [
            ComicCard(
              comic: comic,
            ),
            SizedBox(
              height: 12,
            ),
            Text(
              "Ops, parece que ocorreu um erro ao carregar mais personagens",
              textAlign: TextAlign.center,
              style: AppTextStyle.p2Regular,
            ),
            SizedBox(
              height: 16,
            ),
            RoundedButton(
              text: "Tentar novamente",
              onTap: _controller.getComicsPaged,
            ),
            SizedBox(
              height: 24,
            ),
          ],
        ),
      );

  Widget getCountInfo(int number, String type) => RichText(
        text: TextSpan(
          text: "$number ",
          style: AppTextStyle.p1Semibold.copyWith(color: Colors.red),
          children: <TextSpan>[
            TextSpan(
              text: "$type which ${widget.character.name} appears",
              style: AppTextStyle.p1Semibold,
            ),
          ],
        ),
      );

  List<Widget> getTitleSpace(String title, Widget text) => [
        SizedBox(
          height: 20,
        ),
        Center(
          child: Text(
            title,
            style: AppTextStyle.h3,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        HorizontalDivisor(),
        SizedBox(
          height: 10,
        ),
        text
      ];
}
