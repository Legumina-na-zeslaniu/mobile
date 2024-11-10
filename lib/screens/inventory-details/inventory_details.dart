import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:junction_frame/api/schemas/inventory.dart';
import 'package:junction_frame/screens/inventory-details/inventory_details_connector.dart';
import 'package:junction_frame/store/app_state.dart';
import 'package:junction_frame/widgets/added_picture_widgets/added_pictures_widget.dart';
import 'package:junction_frame/widgets/bottom_container.dart';
import 'package:junction_frame/widgets/buttons.dart';
import 'package:junction_frame/widgets/input_item.dart';
import 'package:junction_frame/widgets/text_widgets.dart';

class InventoryDetails extends StatefulWidget {
  const InventoryDetails({super.key});

  @override
  State<InventoryDetails> createState() => _InventoryDetailsState();
}

class _InventoryDetailsState extends State<InventoryDetails> {
  List<TextEditingController> controllers = [];
  final commentAddController = TextEditingController();
  bool isEditing = false;

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

  Widget renderCommentAddArea(Inventory inventory) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: kElevationToShadow[4],
          borderRadius: const BorderRadius.all(Radius.circular(20))),
      child: InputItem(
        isMultiline: true,
        title: 'Comments',
        controller: commentAddController,
        isEditing: isEditing,
        titleIcon: isEditing
            ? IconButton(
                onPressed: () => commentAddController.clear(),
                icon: const Icon(
                  Icons.cancel_sharp,
                ))
            : null,
        value: inventory.comments ?? '',
      ),
    );
  }

  Widget renderBottomContainer(Function() goNextCallback) {
    return BottomContainer(
      children: [
        const HeaderText(
            'You can update the asset information by clicking the "Edit" button below.'),
        const SizedBox(
          height: 10,
        ),
        const SubHeaderText('You can delete the asset from the database.'),
        const SizedBox(
          height: 15,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            LightButton(height: 50, title: 'Delete', onPress: () => {}),
            InversedButton(
              title: 'Edit',
              height: 50,
              onPress: () => setState(
                () {
                  isEditing = !isEditing;
                },
              ),
            )
          ]),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, InventoryDetailsConnector>(
      converter: (store) => InventoryDetailsConnector.fromStore(store),
      builder: (BuildContext context, InventoryDetailsConnector connector) {
        return Scaffold(
            body: SafeArea(
                bottom: false,
                child: Stack(children: [
                  SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                IconButton(
                                    onPressed: () => context.pop(),
                                    icon:
                                        const Icon(Icons.chevron_left_rounded)),
                                const SizedBox(width: 60),
                                const Text(
                                  'Inventory details',
                                  style: TextStyle(fontSize: 20),
                                )
                              ],
                            ),
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
                            renderCommentAddArea(connector.inventory),
                            const SizedBox(
                              height: 180,
                            ),
                          ]),
                    ),
                  ),
                  renderBottomContainer(() {
                    var values =
                        controllers.map((contr) => contr.value.text).toList();
                    List<Properties> properties = [];
                    var i = 0;

                    connector.inventory!.properties!.forEach((element) {
                      properties.add(
                          Properties(field: element.field, value: values[i]));
                      i++;
                    });

                    connector.updateProperties(properties);
                    connector.updateComment(commentAddController.value.text);

                    connector.upsert(() => context.goNamed('place-selection'));
                  }),
                ])));
      },
    );
  }
}
