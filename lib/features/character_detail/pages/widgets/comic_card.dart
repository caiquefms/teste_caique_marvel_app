import 'package:flutter/material.dart';
import '../../../../core/presentation/components/custom_network_image.dart';
import '../../../../core/design/text_style.dart';
import '../../entity/comic.dart';
import 'comic_detail_dialog.dart';

class ComicCard extends StatelessWidget {
  final Comic comic;
  const ComicCard({
    required this.comic,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        ComicDetailDialog.show(context: context, comic: comic);
      },
      child: Container(
        width: (MediaQuery.of(context).size.width - 24) * 0.85,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
                color: Color(0x0A000000),
                offset: Offset(0, 4),
                blurRadius: 16,
                spreadRadius: 0),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomNetworkImage(
              path: "${comic.thumbnail}/standard_fantastic.jpg",
              width: (MediaQuery.of(context).size.width - 24) * 0.85,
              height: (MediaQuery.of(context).size.width - 24) * 0.85,
            ),
            Text(
              comic.title,
              style: AppTextStyle.p1Semibold,
              textAlign: TextAlign.center,
              softWrap: true,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget infoCharacterChip(String detail) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Text(
        detail,
        style: AppTextStyle.p3Regular,
      ),
      decoration: BoxDecoration(
        color: Colors.black12,
        borderRadius: BorderRadius.circular(50),
        border: Border.all(
          color: Colors.black12,
          width: 1,
        ),
      ),
    );
  }
}
