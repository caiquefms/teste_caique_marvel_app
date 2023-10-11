import 'package:flutter/material.dart';
import '../../../../core/presentation/components/skeleton_loading.dart';

class LoadingCharacterDetailPage extends StatelessWidget {
  const LoadingCharacterDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 12, left: 12, right: 12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            Center(
              child: SkeletonLoading(
                  height: (MediaQuery.of(context).size.width - 24) * 0.85,
                  width: (MediaQuery.of(context).size.width - 24) * 0.85),
            ),
            SizedBox(
              height: 20,
            ),
            SkeletonLoading(
                height: 1, width: MediaQuery.of(context).size.width),
            SizedBox(
              height: 20,
            ),
            SkeletonLoading(
                height: 10, width: MediaQuery.of(context).size.width / 2),
            SizedBox(
              height: 10,
            ),
            SkeletonLoading(
                height: 10, width: MediaQuery.of(context).size.width / 2),
            SizedBox(
              height: 10,
            ),
            SkeletonLoading(
                height: 10, width: MediaQuery.of(context).size.width / 2),
            SizedBox(
              height: 10,
            ),
            SkeletonLoading(
                height: 10, width: MediaQuery.of(context).size.width / 2),
            SizedBox(
              height: 10,
            ),
            Container(
              height: MediaQuery.of(context).size.height / 4,
              child: CustomScrollView(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                slivers: [
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                        childCount: 10,
                        addAutomaticKeepAlives: true, (_, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12, right: 24),
                        child: SkeletonLoading(
                            height: MediaQuery.of(context).size.height / 4,
                            width: MediaQuery.of(context).size.width / 2),
                      );
                    }),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
