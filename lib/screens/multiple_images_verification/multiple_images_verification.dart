import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:junction_frame/api/schemas/inventory.dart';
import 'package:junction_frame/screens/multiple_images_verification/mulitple_images_verification_connector.dart';
import 'package:junction_frame/store/app_state.dart';
import 'package:junction_frame/themes/colors.dart';
import 'package:junction_frame/widgets/added_picture_widgets/added_pictures_widget.dart';
import 'package:junction_frame/widgets/bottom_container.dart';
import 'package:junction_frame/widgets/buttons.dart';
import 'package:junction_frame/widgets/input_item.dart';
import 'package:junction_frame/widgets/text_widgets.dart';

class MultipleImagesVerification extends StatefulWidget {
  MultipleImagesVerification({super.key});

  final TextEditingController commentAddController = TextEditingController();

  @override
  State<MultipleImagesVerification> createState() =>
      _MultipleImagesVerificationState();
}

class _MultipleImagesVerificationState
    extends State<MultipleImagesVerification> {
  bool isEditing = false;
  bool isAddCommentTriggered = false;
  List<TextEditingController> controllers = [];

  Widget renderInputContent(BuildContext context, bool isEditing,
      Inventory inventory, Function(int) removeProperty) {
    for (int i = 0; i < inventory.properties!.length; i++) {
      controllers
          .add(TextEditingController(text: inventory.properties![i].value));
    }

    return Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: kElevationToShadow[4],
            borderRadius: const BorderRadius.all(Radius.circular(20))),
        child: ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          separatorBuilder: (context, index) => const SizedBox(
            height: 15,
          ),
          itemCount: inventory.properties?.length ?? 0,
          itemBuilder: (context, index) {
            final property = inventory.properties![index];
            if (isEditing) {
              return InputItem(
                controller: controllers[index],
                titleIcon: IconButton(
                    onPressed: () => removeProperty(index),
                    icon: const Icon(
                      Icons.cancel_sharp,
                    )),
                title: property.field,
                value: property.value,
                isMultiline: true,
                isEditing: isEditing,
              );
            } else {
              return InputItem(
                title: property.field,
                value: property.value,
                isMultiline: true,
                isEditing: isEditing,
              );
            }
          },
        ));
  }

  Widget renderBottomContainer(Function() goNextCallback) {
    return BottomContainer(
      children: [
        const HeaderText('If informations was correctly identified go to the'),
        const SizedBox(
          height: 10,
        ),
        const HeaderText('next step.'),
        const SizedBox(
          height: 10,
        ),
        const SubHeaderText('If not change the input manualy.'),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            LightButton(
              height: 50,
              title: 'Change',
              onPress: () => setState(
                () {
                  isEditing = !isEditing;
                },
              ),
            ),
            InversedButton(
                title: 'Next', height: 50, onPress: () => goNextCallback())
          ]),
        )
      ],
    );
  }

  Widget renderCommentAddArea() {
    if (!isAddCommentTriggered) {
      return SizedBox(
          height: 50,
          width: double.infinity,
          child: RawMaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              fillColor: CustomColors.orange,
              onPressed: () => setState(() {
                    isAddCommentTriggered = !isAddCommentTriggered;
                  }),
              child: const Text(
                'Add Comment',
                style: TextStyle(color: Colors.white),
              )));
    }
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: kElevationToShadow[4],
          borderRadius: const BorderRadius.all(Radius.circular(20))),
      child: InputItem(
        isMultiline: true,
        title: 'Comments',
        controller: widget.commentAddController,
        isEditing: true,
        value:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, MulitpleImagesVerificationConnector>(
      converter: (store) =>
          MulitpleImagesVerificationConnector.fromStore(store),
      builder: (BuildContext context,
              MulitpleImagesVerificationConnector connector) =>
          Scaffold(
              body: SafeArea(
        bottom: false,
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(children: [
                      renderInputContent(
                          context,
                          isEditing,
                          connector.inventory!,
                          (index) => connector.removeProperty(index)),
                      const SizedBox(
                        height: 20,
                      ),
                      const AddedPicturesWidget(),
                      const SizedBox(
                        height: 20,
                      ),
                      renderCommentAddArea(),
                      const SizedBox(
                        height: 180,
                      ),
                    ])),
              ),
              renderBottomContainer(() {
                var values =
                    controllers.map((contr) => contr.value.text).toList();
                List<Properties> properties = [];
                var i = 0;

                connector.inventory!.properties!.forEach((element) {
                  properties
                      .add(Properties(field: element.field, value: values[i]));
                  i++;
                });

                connector.updateProperties(properties);

                connector.upsert(widget.commentAddController.value.text);
                context.goNamed('place-selection');
              }),
            ],
          ),
        ),
      )),
    );
  }
}
