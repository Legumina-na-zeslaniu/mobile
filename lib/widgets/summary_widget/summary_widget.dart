import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:junction_frame/api/schemas/inventory.dart';
import 'package:junction_frame/store/app_state.dart';
import 'package:junction_frame/utils/types/function.dart';
import 'package:junction_frame/widgets/added_picture_widgets/added_pictures_widget.dart';
import 'package:junction_frame/widgets/bottom_container.dart';
import 'package:junction_frame/widgets/buttons.dart';
import 'package:junction_frame/widgets/input_item.dart';
import 'package:junction_frame/widgets/summary_widget/summary_widget_connector.dart';
import 'package:junction_frame/widgets/text_widgets.dart';

class SummaryWidget extends StatefulWidget {
  final Funct goFurtherAction;

  const SummaryWidget({super.key, required this.goFurtherAction});

  @override
  State<SummaryWidget> createState() => _SummaryWidgetState();
}

class _SummaryWidgetState extends State<SummaryWidget> {
  bool isEditing = false;
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
        const HeaderText('If object was identified correctly go to the next'),
        const SizedBox(
          height: 10,
        ),
        const HeaderText('step.'),
        const SizedBox(
          height: 10,
        ),
        const SubHeaderText('If not change the input manualy. '),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            LightButton(
              title: 'Change',
              onPress: () => setState(
                () {
                  isEditing = !isEditing;
                },
              ),
              height: 50,
            ),
            InversedButton(
                title: "Next", height: 50, onPress: () => goNextCallback())
          ]),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, SummaryWidgetConnector>(
      converter: (store) => SummaryWidgetConnector.fromStore(store),
      builder: (BuildContext context, SummaryWidgetConnector connector) =>
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
                        height: 180,
                      )
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
                widget.goFurtherAction();
              }),
            ],
          ),
        ),
      )),
    );
  }
}
