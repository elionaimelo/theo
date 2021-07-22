import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:theo/components/result_status/loading_status.dart';
import 'package:theo/models/story_category.dart';
import 'package:theo/services/file_service.dart';

class CategoryCard extends StatefulWidget {
  const CategoryCard({
    Key? key,
    required this.storyCategory,
    required this.fileService,
  }) : super(key: key);

  final StoryCategory storyCategory;
  final FileService fileService;

  @override
  _CategoryCardState createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard> {
  String _imageUrl = '';

  late Future<void> _lazyImageUrl;

  Future<void> setImageUrl() async {
    var url = await widget.storyCategory.imageFile!.getUrl(widget.fileService);

    setState(() {
      _imageUrl = url!;
    });
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void initState() {
    super.initState();

    _lazyImageUrl = setImageUrl();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Column(
        children: [
          SizedBox(
            width: 260,
            height: 180,
            child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(top: 20),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                  ),
                  clipBehavior: Clip.hardEdge,
                  child: _imageBuilder,
                ),
                Positioned.fill(
                  child: TextButton(
                    onPressed: () {},
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          widget.storyCategory.name!,
                          style:
                              Theme.of(context).textTheme.headline2!.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: 70,
                          height: 40,
                          padding: EdgeInsets.only(
                              top: 10, right: 12, bottom: 10, left: 12),
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            border: Border.all(
                              color: Colors.white,
                              width: 1,
                            ),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(30.0),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 8),
                                child: Text(
                                  'Ver',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline2!
                                      .copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                ),
                              ),
                              SvgPicture.asset(
                                  'assets/icons/icon-feather-chevron-right.svg'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget get _imageBuilder => FutureBuilder(
        future: _lazyImageUrl,
        builder: (ctx, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return LoadingStatus();
          }

          return Image.network(
            _imageUrl,
            fit: BoxFit.cover,
          );
        },
      );
}
