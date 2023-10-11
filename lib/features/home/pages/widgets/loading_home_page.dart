import 'package:flutter/material.dart';
import '../../../../core/presentation/components/skeleton_loading.dart';

class LoadingHomePage extends StatelessWidget {
  const LoadingHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 24),
          ...List<Widget>.generate(
                  10,
                  (int index) => Padding(
                        padding: const EdgeInsets.only(
                            bottom: 12, left: 12, right: 12),
                        child: SkeletonLoading(
                            height: 100, width: double.maxFinite),
                      ),
                  growable: true)
              .toList()
        ],
      ),
    );
  }
}
