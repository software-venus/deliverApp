// ignore_for_file: deprecated_member_use, duplicate_ignore, unnecessary_null_comparison

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:entrega/models/video_category_model.dart';
import 'package:entrega/models/video_model.dart';
import 'package:entrega/pages/video_list.dart';
import 'package:entrega/utils/firebase/firebase_custom_video.dart';
import 'package:entrega/utils/general/show_dialog_yes_no.dart';
import 'package:entrega/utils/general/sizes_helpers.dart';
import 'package:entrega/utils/list_transforms/video_category_list_transforms.dart'
    // ignore: library_prefixes
    as VideoCategoryTransforms;

import 'package:entrega/widgets/application_bar.dart';
import 'package:entrega/utils/general/abm.dart';
import 'package:entrega/utils/general/reference_Page_State.dart';
import 'package:flutter/material.dart';
import 'package:entrega/variables/globalvar.dart';
import 'package:entrega/widgets/drop_down_buttom_edit_format.dart';

// ignore: must_be_immutable
class VideoABM extends StatefulWidget {
  VideoListState videoListState;
  final bool isNew;
  bool isModify;
  VideoModel videoModel;

  VideoABM({
    Key? key,
    required this.videoListState,
    required this.isNew,
    required this.isModify,
    required this.videoModel,
  }) : super(key: key);

  @override
  State<VideoABM> createState() => _VideoABMState();
}

class _VideoABMState extends State<VideoABM> {
  final _categoryListController = TextEditingController();
  final _titleController = TextEditingController();
  final _urlController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  List<VideoCategoryModel> categoryLists = [];

  Future<bool> _onBackPressed() async {
    return abmOnBackPressed2(context, () {}, () {});
  }

  @override
  void initState() {
    if (widget.isModify) {
      _titleController.text = widget.videoModel.title;
      _urlController.text = widget.videoModel.url;

      super.initState();
    }

    loadCategorys();
  }

  void loadCategorys() {
    try {
      final firestoreInstance = FirebaseFirestore.instance;

      // Customer Category
      categoryLists.clear();

      CollectionReference categorys =
          firestoreInstance.collection(firebaseCustomVideoCategoryKey);

      categorys
          .limit(100)
          .orderBy("title", descending: false)
          .get()
          .then((querySnapshot) {
        for (var result in querySnapshot.docs) {
          setState(() {
            VideoCategoryTransforms.uniquedAdd(categoryLists,
                VideoCategoryModel.fromJSON(false, result.id, result.data()));
          });
        }
      });

      setState(() {});
    } on FirebaseAuthException catch (e) {
      e.stackTrace;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _onBackPressed,
        child: Scaffold(
            appBar: ApplicationBar(
              context: context,
              title: videoABMTitle,
              withShareButton: false,
            ),
            body: ListView(children: [
              Form(
                  key: _formKey,
                  child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
/* Video Category */
                            widget.isNew
                                ? dropDownButtomEditFormat(
                                    VideoABMReferenceState(this),
                                    context,
                                    videoABMFieldCategoryTitle,
                                    Icons.play_arrow_outlined,
                                    VideoCategoryTransforms
                                        .videoCategoryListToStringList(
                                            categoryLists),
                                    _categoryListController)
                                : Text(widget.videoModel.category.title,
                                    maxLines: 1,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    )),

/* Title */
                            TextFormField(
                              decoration: InputDecoration(
                                icon: const Icon(Icons.title_rounded),
                                hintText: videoABMFieldTitleHint,
                                labelText: videoABMFieldTitleLabel,
                              ),
                              controller: _titleController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return videoABMFieldTitleError;
                                }
                                return null;
                              },
                              onChanged: (value) {
                                widget.videoModel.title = value;
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),

/* Url */
                            TextFormField(
                              decoration: InputDecoration(
                                icon: const Icon(Icons.play_arrow_rounded),
                                hintText: videoABMFieldUrlHint,
                                labelText: videoABMFieldUrlLabel,
                              ),
                              controller: _urlController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return videoABMFieldUrlError;
                                }
                                return null;
                              },
                              onChanged: (value) {
                                widget.videoModel.url = value;
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
/* Photo */
                            ClipRRect(
                                borderRadius: BorderRadius.circular(
                                    200), //Reducir para la parte de view
                                child: SizedBox(
                                  width: 200,
                                  height: 200,
                                  child: isNewImage
                                      ? Image(
                                          image: imageToStore.image,
                                          fit: BoxFit.cover,
                                        )
                                      : CachedNetworkImage(
                                          imageUrl:
                                              widget.videoModel.urlPreview,
                                          placeholder: (context, url) =>
                                              const CircularProgressIndicator(),
                                          errorWidget: (context, url, error) =>
                                              const Icon(Icons.error),
                                          fit: BoxFit.cover,
                                        ),
                                )),
                            Padding(
                              padding: const EdgeInsets.all(5),
                              child: FloatingActionButton(
                                onPressed: () {
                                  onCaptureImage(ImageSource.gallery, context);
                                },
                                heroTag: captureImageGalleryHeroTag,
                                tooltip: captureImageGalleryTooltip,
                                child: const Icon(Icons.photo),
                              ),
                            ),

/* IsEnabled */
                            Row(
                              children: [
                                Checkbox(
                                    value: widget.videoModel.isEnabled,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        widget.videoModel.isEnabled = value!;
                                      });
                                    }),
                                Text(videoABMFieldIsEnabledLabel),
                              ],
                            ),

/* Finish */
                            Row(children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 16, top: 40, bottom: 20),
                                child: Center(
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.green,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 9),
                                        textStyle: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.normal)),
                                    onPressed: () async {
                                      if (_formKey.currentState!.validate()) {
/* Video video New */
                                        if (widget.isNew) {
                                          try {
                                            String error = "";

                                            if (_categoryListController
                                                .text.isEmpty) {
                                              error =
                                                  videoABMFieldCategoryError;
                                            }

                                            if (!isNewImage) {
                                              error =
                                                  videoAbmFieldNewImageError;
                                            }

                                            if (error.isEmpty) {
                                              widget.videoModel.category =
                                                  VideoCategoryTransforms
                                                      .videoCategoryStringTovideoCategoryModel(
                                                          categoryLists,
                                                          _categoryListController
                                                              .text);

                                              FirebaseCustomVideoHelper().add(
                                                  context: context,
                                                  category: widget
                                                      .videoModel.category,
                                                  title: _titleController.text,
                                                  url: _urlController.text,
                                                  pickedFile: pickedFileToStore,
                                                  isNewImage: isNewImage,
                                                  onFinished: () {
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                            SnackBar(
                                                      content: Text(
                                                        videoABMNewSaved,
                                                        style: const TextStyle(
                                                            fontSize: 16),
                                                      ),
                                                    ));
                                                    Navigator.pop(context);

                                                    if (widget.videoListState !=
                                                        null) {
                                                      widget.videoListState
                                                          .refreshList();
                                                    }
                                                  },
                                                  onError: (String error) {
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(SnackBar(
                                                      content: Text(
                                                        error,
                                                        style: const TextStyle(
                                                            fontSize: 16),
                                                      ),
                                                    ));
                                                  });
                                            } else {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(SnackBar(
                                                content: Text(
                                                  error,
                                                  style: const TextStyle(
                                                      fontSize: 16),
                                                ),
                                              ));
                                            }
                                          } catch (errorValue) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                              content: Text(
                                                errorValue.toString(),
                                                style: const TextStyle(
                                                    fontSize: 16),
                                              ),
                                            ));
                                          }
                                        }

/* Video video Modify */
                                        if (widget.isModify) {
                                          try {
                                            String error = "";

                                            if (error.isEmpty) {
                                              FirebaseCustomVideoHelper()
                                                  .modify(
                                                      context: context,
                                                      videoModel:
                                                          widget.videoModel,
                                                      pickedFile:
                                                          pickedFileToStore,
                                                      isNewImage: isNewImage,
                                                      onFinished: () {
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                                SnackBar(
                                                          content: Text(
                                                            videoABMModifySaved,
                                                            style: const TextStyle(
                                                                fontSize: 16),
                                                          ),
                                                        ));
                                                        Navigator.pop(context);

                                                        if (widget
                                                                .videoListState !=
                                                            null) {
                                                          widget.videoListState
                                                              .refreshList();
                                                        }
                                                      },
                                                      onError: (String error) {
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                                SnackBar(
                                                          content: Text(
                                                            error,
                                                            style:
                                                                const TextStyle(
                                                                    fontSize:
                                                                        16),
                                                          ),
                                                        ));
                                                      });
                                            } else {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(SnackBar(
                                                content: Text(
                                                  error,
                                                  style: const TextStyle(
                                                      fontSize: 16),
                                                ),
                                              ));
                                            }
                                          } catch (errorValue) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                              content: Text(
                                                errorValue.toString(),
                                                style: const TextStyle(
                                                    fontSize: 16),
                                              ),
                                            ));
                                          }
                                        }
                                      }
                                    },
                                    child: Text(videoABMSaveTitle),
                                  ),
                                ),
                              ),

/* Video video Delete */
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 16, top: 40, bottom: 20),
                                child: widget.isModify
                                    ? Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 16.0),
                                        child: Center(
                                            child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                    backgroundColor: Colors.red,
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 20,
                                                        vertical: 9),
                                                    textStyle: const TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.normal)),
                                                onPressed: () async {
                                                  ShowDialogYesNo
                                                      showDialogYesNo =
                                                      ShowDialogYesNo(
                                                          onClickYes: () {
                                                            FirebaseCustomVideoHelper()
                                                                .delete(
                                                                    context:
                                                                        context,
                                                                    videoModel:
                                                                        widget
                                                                            .videoModel,
                                                                    onFinished:
                                                                        () {
                                                                      ScaffoldMessenger.of(
                                                                              context)
                                                                          .showSnackBar(
                                                                              SnackBar(
                                                                        content:
                                                                            Text(
                                                                          videoABMModifySaved,
                                                                          style:
                                                                              const TextStyle(fontSize: 16),
                                                                        ),
                                                                      ));
                                                                      Navigator.pop(
                                                                          context);

                                                                      if (widget
                                                                              .videoListState !=
                                                                          null) {
                                                                        widget
                                                                            .videoListState
                                                                            .refreshList();
                                                                      }
                                                                    },
                                                                    onError: (String
                                                                        error) {
                                                                      ScaffoldMessenger.of(
                                                                              context)
                                                                          .showSnackBar(
                                                                              SnackBar(
                                                                        content:
                                                                            Text(
                                                                          error,
                                                                          style:
                                                                              const TextStyle(fontSize: 16),
                                                                        ),
                                                                      ));
                                                                    });
                                                          },
                                                          onClickNo: () {});

                                                  showDialogYesNo.show(
                                                      context,
                                                      abmDeleteAlertTitle,
                                                      abmDeleteAlertContent,
                                                      abmDeleteAlertPressedYes,
                                                      abmDeleteAlertPressedNo);
                                                },
                                                child: Text(
                                                  abmDeleteTitle,
                                                  style: const TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.white),
                                                ))))
                                    : Container(),
                              ),
                            ])
                          ])))
            ])));
  }

  Image imageToStore = Image.asset("assets/squeue.png");
  PickedFile pickedFileToStore = PickedFile("");
  bool isNewImage = false;

  void onCaptureImage(ImageSource source, BuildContext context) async {
    try {
      if (isWeb()) {
        // ignore: deprecated_member_use
        PickedFile? pickedFile = await ImagePicker().getImage(source: source);

        if (pickedFile != null) {
          pickedFileToStore = pickedFile;
          imageToStore = Image.memory(await pickedFile.readAsBytes());
          isNewImage = true;
        }

        setState(() {});
      }

      if (isMobile()) {
        // ignore: deprecated_member_use
        PickedFile? pickedFile = await ImagePicker().getImage(source: source);

        if (pickedFile != null) {
          pickedFileToStore = pickedFile;
          imageToStore = Image.memory(await pickedFile.readAsBytes());
          isNewImage = true;
        }

        setState(() {});
      }
    } catch (e) {
      e.toString();
    }
  }
}

class VideoABMReferenceState extends ReferencePageState {
  _VideoABMState videoABMState;

  VideoABMReferenceState(this.videoABMState);

  @override
  void setStates() {
    // ignore: invalid_use_of_protected_member
    videoABMState.setState(() {});
  }
}
