import 'dart:async';
import 'dart:io';

import 'package:BrandFarm/blocs/journal_create/bloc.dart';
import 'package:BrandFarm/models/journal/gallery_model.dart';
import 'package:BrandFarm/utils/themes/constants.dart';
import 'package:BrandFarm/widgets/customized_badge.dart';
import 'package:BrandFarm/widgets/loading/loading.dart';
import 'package:badges/badges.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:path_provider/path_provider.dart';

class PhotoAdd extends StatefulWidget {
  final List<GalleryModel> journalImg;

  const PhotoAdd({this.journalImg});

  State<PhotoAdd> createState() => _PhotoAdd();
}

class _PhotoAdd extends State<PhotoAdd> {
  Widget tIcon = Icon(
    Icons.add,
    color: Colors.black,
  );

  JournalCreateBloc _journalCreateBloc;
  List<Widget> gallery = [];
  List<GalleryModel> _journalImg;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _journalCreateBloc = BlocProvider.of<JournalCreateBloc>(context);
    _journalImg = widget.journalImg;

    if (_journalImg != null) {
      for (int i = 0; i < _journalImg.length; i++) {
        _journalCreateBloc.add(ImagePath(
          path: _journalImg[i].path,
        ));
        _journalCreateBloc.add(OriginalImagePath(
          path: _journalImg[i].path,
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return addPhoto(context);
  }

  Future getImage(ImageSource source, JournalCreateState state) async {
    LoadingDialog();
    var image = await ImagePicker.pickImage(source: source, imageQuality: 85);
    if (image == null) {}
    if (image != null) {
      _journalCreateBloc.add(AddImageFile(imgFile: image));
    }
  }

  getMultiImage(JournalCreateState state) async {
    List<Asset> resultImage = await MultiImagePicker.pickImages(
      maxImages: 10,
      enableCamera: true,
      selectedAssets: state.assetList,
    );
    _journalCreateBloc.add(AssetImageList(assetImage: resultImage));

    if (resultImage.isNotEmpty) {
      for (int i = 0; i < resultImage.length; i++) {
        ByteData a = await resultImage[i].requestOriginal();
        File file = await writeToFile(a, i);
        _journalCreateBloc.add(AddImageFile(imgFile: file));
      }
    }
  }

  Future<File> writeToFile(ByteData data, int i) async {
    final buffer = data.buffer;
    final String dttm = Timestamp.now().millisecondsSinceEpoch.toString();

    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    var filePath = tempPath +
        '/file_0${dttm}.tmp'; // file_01.tmp is dump file, can be anything
    return File(filePath).writeAsBytes(
        buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
  }

  void _showBottomModalSheet(BuildContext context, JournalCreateState state) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
        ),
        backgroundColor: Colors.white,
        context: context,
        builder: (BuildContext bc) {
          return new Wrap(
            children: <Widget>[
              ListTile(
                  leading: Text('앨범'),
                  title: Text(''),
                  onTap: () => {Navigator.pop(context), getMultiImage(state)}),
              Divider(height: 2, thickness: 2, color: Color(0xFFE0E0E0)),
              ListTile(
                leading: Text('카메라'),
                title: Text(''),
                onTap: () => {
                  Navigator.pop(context),
                  getImage(ImageSource.camera, state)
                },
              ),
              Divider(height: 2, thickness: 2, color: Color(0xFFE0E0E0)),
            ],
          );
        });
  }

  Widget addPhoto(BuildContext context) {
    return BlocBuilder<JournalCreateBloc, JournalCreateState>(
      cubit: _journalCreateBloc,
      builder: (context, state) {
        gallery.clear();
        if (state.filePath.isNotEmpty) {
          for (int i = 0; i < state.filePath.length; i++) {
            gallery.insert(
                0,
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Stack(
                    children: <Widget>[
                      Image.network(
                        state.filePath[i],
                        width: MediaQuery.of(context).size.width * 0.29,
                        height: MediaQuery.of(context).size.width * 0.29,
                        fit: BoxFit.fill,
                      ),
                      IconButton(
                        icon: Icon(Icons.cancel),
                        onPressed: () {
                          gallery.removeAt(state.filePath.length - i - 1);
                          _journalCreateBloc
                              .add(ImagePathDelete(path: state.filePath[i]));
                        },
                      ),
                    ],
                  ),
                ));
          }
        }

        if (state.imageList.isNotEmpty) {
          for (int i = 0; i < state.imageList.length; i++) {
            bool isNull = state.imageList[i] == null;
            int indexing = state.assetList.length - 1;
            gallery.insert(
                0,
              CustomizedBadge(
                onPressed: () {
                  gallery.removeAt(0);
                  _journalCreateBloc.add(DeleteImageFile(
                      removedFile: state.imageList[i],
                      assetFile: state.assetList[indexing - i]));
                },
                // padding: EdgeInsets.zero,
                toAnimate: false,
                badgeContent: Icon(
                  Icons.close,
                  color: Colors.white,
                  size: 11,
                ),
                position: BadgePosition.topEnd(top: 3, end: 3),
                badgeColor: Colors.black,
                shape: BadgeShape.circle,
                child: isNull
                    ? Stack(
                  children: [
                    Container(
                      height: 87.0,
                      width: 87.0,
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: Container(
                          height: 74.0,
                          width: 74.0,
                          color: Colors.grey,
                          child: Center(
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    Color.fromARGB(255, 0, 61, 165)),
                              )),
                        ),
                      ),
                    ),
                  ],
                )
                    : Stack(
                  children: [
                    Container(
                      height: 87.0,
                      width: 87.0,
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: Container(
                          height: 74.0,
                          width: 74.0,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: FileImage(
                                state.imageList[i],
                              ),
                              fit: BoxFit.cover,
                              // colorFilter: ColorFilter.mode(
                              //     Colors.black.withOpacity(0.5), BlendMode.srcATop),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ));
          }
        }

        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: defaultPadding),
              child: Text('사진첨부', style: Theme.of(context).textTheme.headline5),
            ),
            SizedBox(
              height: 5.0,
            ),
            Container(
              height: 100.0,
              child: ListView.builder(
                physics: ClampingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: (state?.imageList?.isEmpty ?? true)
                    ? 1
                    : state.imageList.length,
                itemBuilder: (BuildContext context, int index) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      (index == 0)
                          ? SizedBox(
                              width: defaultPadding,
                            )
                          : Container(),
                      (index == 0)
                          ? Center(
                        child: InkWell(
                            onTap: () {
                              _showBottomModalSheet(context, state);
                            },
                            child: Container(
                              height: 74.0,
                              width: 74.0,
                              decoration:
                              BoxDecoration(color: Color(0x1a000000)),
                              child: Center(
                                child: Icon(
                                  Icons.add,
                                  size: 34.0,
                                ),
                              ),
                            )),
                      )
                          : Container(),
                      (state?.imageList?.isNotEmpty ?? true)
                          ? SizedBox(
                        width: defaultPadding,
                      )
                          : Container(),
                      (state?.imageList?.isNotEmpty ?? true)
                          ? gallery[index]
                          : Container(),
                      (index == state.imageList.length - 1)
                          ? SizedBox(
                        width: defaultPadding,
                      )
                          : Container(),
                    ],
                  );
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        );
      },
    );
  }
}
