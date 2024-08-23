import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:stacked/stacked.dart';
import '../../../router.router.dart';
import '../../../widgets/full_screen_loader.dart';
import 'list_page_sheet_viewmodel.dart';

class ListPageSheetScreen extends StatelessWidget {
  const ListPageSheetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ListPageSheetViewmodel>.reactive(
      viewModelBuilder: () => ListPageSheetViewmodel(),
      onViewModelReady: (model) => model.initialise(context),
      builder: (context, model, child) => Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text("Facebook Integration"),
        ),
        body: fullScreenLoader(
          loader: model.isBusy,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                model.filterPageSheetList.isNotEmpty
                    ? Expanded(
                        child: RefreshIndicator(
                          onRefresh: model.refreshList,
                          child: ListView.separated(
                            itemCount: model.filterPageSheetList.length,
                            itemBuilder: (context, index) {
                              return Card(
                                elevation: 1,
                                color: Colors.white,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 5.0),
                                  child: ListTile(
                                    selectedTileColor: Colors.blueAccent,
                                    leading: const CircleAvatar(
                                      backgroundColor: Colors.blue,
                                      child: Icon(Icons.pages,
                                          color: Colors.white),
                                    ),
                                    title: AutoSizeText(
                                      model.filterPageSheetList[index]
                                              .pageName ??
                                          "",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    subtitle: AutoSizeText(
                                      model.filterPageSheetList[index]
                                              .company ??
                                          "",
                                      style: const TextStyle(fontSize: 14),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    trailing: const Icon(
                                        Icons.arrow_forward_ios_outlined),
                                    onTap: () async {
                                      final result =
                                          await Navigator.pushNamed(
                                        context,
                                        Routes.addPageSheetScreen,
                                        arguments: AddPageSheetScreenArguments(
                                          pageSheetId: model
                                              .filterPageSheetList[index].name
                                              .toString(),
                                        ),
                                      );

                                      if (result == true) {
                                        model.refreshList();
                                      }
                                    },
                                  ),
                                ),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return const SizedBox(
                                height: 2,
                              );
                            },
                          ),
                        ),
                      )
                    : const Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                                "You haven't created a Page Sheet yet"),
                          ],
                        ),
                      ),
              ],
            ),
          ),
          context: context,
        ),
        floatingActionButton: SpeedDial(
          icon: Icons.add,
          activeIcon: Icons.close,
          children: [
            SpeedDialChild(
              child: const Icon(Icons.integration_instructions_outlined,
                  color: Colors.white),
              label: 'Get Integration Support',
              backgroundColor: Colors.blue,
              onTap: () async {
                model.whatsapp(
                    model.masters.supportMobile, model.masters.supportSms);
              },
            ),
            SpeedDialChild(
              child: const Icon(Icons.person_add, color: Colors.white),
              label: 'Integrate Now',
              backgroundColor: Colors.blue,
              onTap: () async {
                final result = await Navigator.pushNamed(
                  context,
                  Routes.addPageSheetScreen,
                  arguments: const AddPageSheetScreenArguments(
                      pageSheetId: ""),
                );

                // If a new page sheet is added, add it to the list
                if (result != null) {
                  model.refreshList();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
