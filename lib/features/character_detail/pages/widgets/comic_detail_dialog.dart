import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import '../../../../core/presentation/components/rounded_button.dart';
import '../../../../core/design/text_style.dart';
import '../../../../core/presentation/components/horizontal_divisor.dart';
import '../../entity/comic.dart';

class ComicDetailDialog {
  static void show({
    required Comic comic,
    required BuildContext context,
  }) {
    showDialog(
        context: context,
        builder: (ctx) {
          return Dialog(
            backgroundColor: Color.fromARGB(255, 34, 34, 34),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16.0)),
            ),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: InkWell(
                          onTap: () {
                            Navigator.of(ctx).pop();
                          },
                          child: Icon(
                            Icons.close,
                            color: Colors.white,
                            size: 24,
                          )),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text(
                            "Comic Info",
                            style: AppTextStyle.h2,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        HorizontalDivisor(),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          comic.title,
                          style: AppTextStyle.p1Semibold,
                        ),
                        Text(
                          "Issue Number : ${comic.issueNumber}",
                          style: AppTextStyle.p3Regular,
                        ),
                        Text(
                          "Number of pages : ${comic.pageCount}",
                          style: AppTextStyle.p3Regular,
                        ),
                        ...comic.prices.map(
                          (price) => Text(
                            "${price.type} : \$${price.price}",
                            style: AppTextStyle.p3Regular,
                          ),
                        ),
                        ...getDescription(comic.description),
                        ...getCreators(comic.creators),
                      ],
                    ),
                    SizedBox(height: 20),
                    Flexible(
                      child: RoundedButton(
                        text: "Ok",
                        onTap: () {
                          Navigator.of(ctx).pop();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  static List<Widget> getDescription(String description) => description
          .isNotEmpty
      ? [
          SizedBox(
            height: 5,
          ),
          HorizontalDivisor(),
          SizedBox(
            height: 5,
          ),
          Text(
            description,
            style: AppTextStyle.p3Regular.copyWith(fontStyle: FontStyle.italic),
          ),
        ]
      : [];

  static List<Widget> getCreators(List<String> creators) => creators.isNotEmpty
      ? [
          SizedBox(
            height: 5,
          ),
          HorizontalDivisor(),
          SizedBox(
            height: 5,
          ),
          Wrap(
            children: [
              Text(
                "Creators : ",
                style: AppTextStyle.p3Semibold
                    .copyWith(fontStyle: FontStyle.italic),
              ),
              ...creators
                  .mapIndexed(
                    (index, creator) => Text(
                      "$creator" +
                          (index != (creators.length - 1) ? " - " : ""),
                      style: AppTextStyle.p3Regular
                          .copyWith(fontStyle: FontStyle.italic),
                    ),
                  )
                  .toList()
            ],
          ),
        ]
      : [];
}
