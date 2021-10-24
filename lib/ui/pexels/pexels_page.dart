import 'package:alpha_store/models/list_model.dart';
import 'package:alpha_store/models/loading_state.dart';
import 'package:alpha_store/models/photo.dart';
import 'package:alpha_store/ui/pexels/pexel_item.dart';
import 'package:alpha_store/viewmodels/pexels_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PexelsPage extends StatefulWidget {
  const PexelsPage();

  @override
  State<PexelsPage> createState() => _PexelsPageState();
}

class _PexelsPageState extends State<PexelsPage> {
  late PexelsViewModel _pexelsViewModel;
  late ScrollController _controller;

  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  late ListModel<Photo> _photosList;
  late int _nextItem; // The next item inserted when the user presses the '+' button.

  bool isLoading = false;

  List<Photo> photos = [];

  @override
  void initState() {
    super.initState();

    _controller = ScrollController()..addListener(_loadMore);

    _photosList = ListModel<Photo>(
      listKey: _listKey,
      initialItems: [],
      removedItemBuilder: _buildRemovedItem,
    );

    _nextItem = 3;

    Future.microtask(() {
      if (_pexelsViewModel.photosResponse.item2 == null) {
        _pexelsViewModel.fetchImages();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  // Used to build list items that haven't been removed.
  Widget _buildItem(BuildContext context, int index, Animation<double> animation) {
    return PexelsItem(
      animation: animation,
      item: _photosList[index],
      selected: false,
      onTap: () {},
    );
  }

  Widget _buildRemovedItem(Photo item, BuildContext context, Animation<double> animation) {
    return PexelsItem(
      animation: animation,
      item: item,
      selected: false,
      // No gesture detector here: we don't want removed items to be interactive.
    );
  }

  // Insert the "next item" into the list model.
  void _insert(Photo item) {
    _photosList.insert(_photosList.length, item);
  }

  void _loadMore() async {
    if (_controller.position.extentAfter < 300) {

      if (_pexelsViewModel.loadingState != LoadingState.loading) {
        debugPrint('will loadMore...');
        _pexelsViewModel.fetchImages();
      }
    }
  }

  Widget loadingStatus() {
    return Consumer<PexelsViewModel>(builder: (context, viewModel, child) {
      Widget view = const Text('Idle!');

      if (_pexelsViewModel.loadingState == LoadingState.loading) {
        view = const CircularProgressIndicator();
      } else if (_pexelsViewModel.loadingState == LoadingState.finished) {
        if (_pexelsViewModel.photosResponse.item1 == null) {
          Future.microtask(() {
            debugPrint('will add more photos...');

            setState(() {
              photos.addAll(_pexelsViewModel.photosResponse.item2!);
              _pexelsViewModel.rest();
            });
            // List<Photo> photos = _pexelsViewModel.photosResponse.item2!;
            // for (var element in photos) {
            //   _insert(element);
            // }
            // _controller.animateTo(_controller.offset + 400,
            //     duration: const Duration(milliseconds: 300), curve: Curves.fastOutSlowIn);
          });

          view = Container();
        } else {
          view = Text('Error!');
        }
      }

      return view;
    });
  }

  @override
  Widget build(BuildContext context) {
    _pexelsViewModel = Provider.of<PexelsViewModel>(context, listen: false);

    return Scaffold(
        body: Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        // AnimatedList(
        //   key: _listKey,
        //   controller: _controller,
        //   initialItemCount: _photosList.length,
        //   itemBuilder: _buildItem,
        // ),
        ListView.builder(
          itemBuilder: (_context, index) => PhotoItemView(item: photos[index]),
          controller: _controller,
          itemCount: photos.length,
        ),
        loadingStatus(),
      ],
    ));
  }
}
