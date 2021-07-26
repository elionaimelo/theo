import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:theo/components/result_status/loading_status.dart';
import 'package:theo/models/file.dart';
import 'package:theo/services/api_client.dart';
import 'package:cached_network_image/cached_network_image.dart';

class LazyImage extends StatefulWidget {
  const LazyImage({
    Key? key,
    required this.file,
    this.defaultImage,
  }) : super(key: key);

  @override
  _LazyImageState createState() => _LazyImageState();

  final File? file;

  final AssetImage? defaultImage;
}

class _LazyImageState extends State<LazyImage> {
  late Future<void> _imageUrlPromisse;

  @override
  void initState() {
    super.initState();

    _imageUrlPromisse = getImageUrl();
  }

  Future<String> getImageUrl() async {
    var url = await widget.file?.getUrl(GetIt.I.get<APIClient>().fileService);

    return url ?? 'UNKNOW_IMAGE_URL';
  }

  @override
  Widget build(BuildContext context) {
    if (widget.file == null) {
      return _errorImage;
    }

    return FutureBuilder(
      future: _imageUrlPromisse,
      builder: (ctx, snap) {
        if (snap.connectionState == ConnectionState.waiting) {
          return LoadingStatus();
        } else if (snap.hasError) {
          return _errorImage;
        }

        var url = snap.data.toString();

        return _cachedNetworkImage(url);
      },
    );
  }

  Widget get _errorImage {
    if (widget.defaultImage != null) {
      return Image(
        image: widget.defaultImage!,
      );
    }

    return Icon(Icons.error);
  }

  Widget _cachedNetworkImage(String imageUrl) => CachedNetworkImage(
        imageUrl: imageUrl,
        fit: BoxFit.cover,
        placeholder: (context, url) => LoadingStatus(),
        errorWidget: (context, url, error) => Icon(Icons.error),
      );
}
