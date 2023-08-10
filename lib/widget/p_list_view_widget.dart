import 'package:flutter/material.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

class PListViewWidget extends StatelessWidget {
  final double? height;
  final double? width;
  final Axis scrollDirection;
  final Function(int index) onBuildItem;
  final bool isLoading;
  final bool firstLoadingScreen;
  final int count;
  final Widget? header;
  final Widget? footer;
  final Widget? loadingItem;
  final void Function()? onEndOfPage;
  final void Function()? onPullToRefresh;
  final Widget? emptyListMessage;
  final ScrollPhysics? physics;
  final bool primary;
  final bool useFade;
  final bool isRevers;
  final bool bottomUseFade;
  final EdgeInsetsGeometry? padding;
  final ScrollController? scrollController;

  const PListViewWidget({
    this.height,
    this.scrollDirection = Axis.vertical,
    required this.count,
    required this.onBuildItem,
    Key? key,
    this.isLoading = false,
    this.header,
    this.footer,
    this.loadingItem,
    this.width,
    this.onEndOfPage,
    this.onPullToRefresh,
    this.firstLoadingScreen = false,
    this.emptyListMessage,
    this.physics,
    this.primary = true,
    this.useFade = false,
    this.isRevers = false,
    this.scrollController,
    this.bottomUseFade = false,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: showEmpty
          ? Center(
              child: emptyListMessage,
            )
          : body(),
    );
  }

  Widget body() {
    if (firstLoadingScreen || isLoading) {
      return loadingPanel();
    } else {
      return useFade ? shader() : content();
    }
  }

  Widget loadingPanel() {
    return loadingItem == null
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : loadingItem!;
  }

  Widget shader() {
    return ShaderMask(
      blendMode: BlendMode.dstOut,
      shaderCallback: (Rect rect) {
        return LinearGradient(
          begin: bottomUseFade ? Alignment.topCenter : Alignment.centerLeft,
          end: bottomUseFade ? Alignment.bottomCenter : Alignment.centerRight,
          colors: [
            Colors.transparent,
            Colors.white.withOpacity(1),
          ],
          stops: const [.7, 1],
        ).createShader(rect);
      },
      child: content(),
    );
  }

  Widget content() {
    if (onEndOfPage == null && onPullToRefresh == null) {
      return list();
    }

    if (onEndOfPage == null) {
      return RefreshIndicator(
        onRefresh: () async => onPullToRefresh!(),
        child: list(),
      );
    }

    return lazy(
      child: list(),
    );
  }

  Widget lazy({required Widget child}) {
    return LazyLoadScrollView(
      onEndOfPage: onEndOfPage!,
      isLoading: isLoading,
      scrollDirection: scrollDirection,
      child: onPullToRefresh == null
          ? list()
          : RefreshIndicator(
              onRefresh: () async =>
                  onPullToRefresh == null ? () {} : onPullToRefresh!(),
              child: list(),
            ),
    );
  }

  Widget list() {
    return ListView.builder(
      padding: padding,
      scrollDirection: scrollDirection,
      itemCount: itemCount,
      shrinkWrap: true,
      reverse: isRevers,
      physics: physics,
      primary: primary,
      controller: scrollController,
      itemBuilder: (BuildContext context, int index) {
        if (index == 0 && header != null) {
          return header!;
        }

        if (index == itemCount - 1 && footer != null) {
          return footer!;
        }

        return onBuildItem(index);
      },
    );
  }

  bool get showEmpty => emptyListMessage != null && !isLoading && count == 0;

  int get itemCount =>
      count +
      (header == null || showEmpty ? 0 : 1) +
      (footer == null || showEmpty ? 0 : 1) +
      (showEmpty ? 1 : 0);
}
