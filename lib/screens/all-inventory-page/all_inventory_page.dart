import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:junction_frame/api/schemas/inventory.dart';
import 'package:junction_frame/screens/all-inventory-page/all_inventory_page_connector.dart';
import 'package:junction_frame/store/app_state.dart';
import 'package:junction_frame/themes/colors.dart';
import 'package:junction_frame/widgets/buttons.dart';

class AllInventoryPage extends StatefulWidget {
  const AllInventoryPage({super.key});

  @override
  State<AllInventoryPage> createState() => _AllInventoryPageState();
}

class _AllInventoryPageState extends State<AllInventoryPage> {
  var currentPage = 0;
  var itemsPerPage = 7;

  List<Inventory> getPageItems(List<Inventory> inventoryList) {
    final start = currentPage * itemsPerPage;
    final end = start + itemsPerPage;
    return inventoryList.sublist(
      start,
      end > inventoryList.length ? inventoryList.length : end,
    );
  }

  Widget buildPaginationControls(int totalItems) {
    final totalPages = (totalItems / itemsPerPage).ceil();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ElevatedButton(
          onPressed:
              currentPage > 0 ? () => setState(() => currentPage--) : null,
          child: const Text('Previous'),
        ),
        Text('Page ${currentPage + 1} of $totalPages'),
        ElevatedButton(
          onPressed: currentPage < totalPages - 1
              ? () => setState(() => currentPage++)
              : null,
          child: const Text('Next'),
        ),
      ],
    );
  }

  buildDetails(List<Inventory> inventoryList, Function callback) {
    // debugPrint('Current Page: $currentPage');
    // debugPrint('Items Per Page: $itemsPerPage');
    // debugPrint(
    //     'Remaining Items: ${(inventoryList.length % itemsPerPage).toInt()}');

    return ListView.builder(
        shrinkWrap: true,
        itemCount: itemsPerPage,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            onTap: () => callback(inventoryList[index],
                () => context.pushNamed('inventory-details')),
            title: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'Asset',
                    style: TextStyle(fontWeight: FontWeight.w400),
                  ),
                  Text(
                    'Floor',
                    style: TextStyle(fontWeight: FontWeight.w400),
                  ),
                ]),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AllInventoryPageConnector>(
      converter: (store) => AllInventoryPageConnector.fromStore(store),
      builder: (BuildContext context, AllInventoryPageConnector vm) {
        return Scaffold(
          body: SafeArea(
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
                        icon: const Icon(Icons.chevron_left_rounded)),
                    const SizedBox(width: 75),
                    const Text(
                      'List of assets',
                      style: TextStyle(fontSize: 20),
                    )
                  ],
                ),
                Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: kElevationToShadow[4],
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Column(children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Text('Building:'),
                            LightButton(
                                width: 200,
                                height: 50,
                                title: 'All buildings',
                                onPress: () => debugPrint('All buildings'))
                          ]),
                      const SizedBox(height: 8),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Text('Sort by:'),
                            LightButton(
                                width: 200,
                                height: 50,
                                title: 'default',
                                onPress: () => debugPrint('default'))
                          ]),
                      const SizedBox(height: 8),
                      const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              'Asset',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'Floor',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ]),
                      const SizedBox(height: 8),
                      const Divider(
                        color: CustomColors.orange,
                        thickness: 2,
                      ),
                      buildDetails(vm.inventoryList, vm.selectInventory),
                      buildPaginationControls(vm.inventoryList.length)
                    ])),
              ],
            ),
          )),
        );
      },
    );
  }
}
