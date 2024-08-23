import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../../../router.router.dart';
import '../../../widgets/full_screen_loader.dart';
import '../../../widgets/text_button.dart';
import 'list_member_model.dart';

class TeamMemberList extends StatelessWidget {
  const TeamMemberList({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ListTeamMemberModel>.reactive(
      viewModelBuilder: () => ListTeamMemberModel(),
      onViewModelReady: (model) => model.initialise(context),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: const Text("Employees"),
        ),
        body: fullScreenLoader(
          loader: model.isBusy,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                model.memberlist.isNotEmpty
                    ? Expanded(
                        child: RefreshIndicator(
                          onRefresh: model.refreshList,
                          child: ListView.separated(
                            itemCount: model.memberlist.length,
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
                                      child: Icon(Icons.person,
                                          color: Colors.white),
                                    ),
                                    title: AutoSizeText(
                                      "${model.memberlist[index].firstName ?? ""} ${model.memberlist[index].lastName ?? ""}",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    subtitle: AutoSizeText(
                                      model.memberlist[index].company ?? "",
                                      style: const TextStyle(fontSize: 14),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    trailing: IconButton.filled(
                                      icon: const Icon(
                                        Icons.delete_forever_outlined,
                                        color: Colors.white,
                                      ),
                                      onPressed: () {
                                        model.deleteLead(
                                            context,
                                            model.memberlist[index].name
                                                .toString());
                                      },
                                    ),
                                    onTap: () async {
                                      final result = await Navigator.pushNamed(
                                        context,
                                        Routes.addTeamMember,
                                        arguments: AddTeamMemberArguments(
                                          memberid: model
                                              .memberlist[index].name
                                              .toString(),
                                        ),
                                      );

                                      // If an employee was added/updated, refresh the list immediately
                                      if (result != null && result == true) {
                                        model.refreshList(); // Add or update the member in the list
                                      }
                                    },
                                  ),
                                ),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return const Divider();
                            },
                          ),
                        ),
                      )
                    : Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Text(
                                "You haven't created a employee yet"),
                            CtextButton(
                              onPressed: () async {
                                final result = await Navigator.pushNamed(
                                  context,
                                  Routes.addTeamMember,
                                  arguments: const AddTeamMemberArguments(
                                      memberid: ""),
                                );

                                // If a new employee was added, refresh the list immediately
                                if (result != null && result == true) {
                                  model.refreshList();
                                }
                              },
                              text: 'Create Employee',
                              buttonColor: Colors.black,
                            )
                          ],
                        ),
                      ),
              ],
            ),
          ),
          context: context,
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Theme.of(context).colorScheme.surface,
          onPressed: () async {
            final result = await Navigator.pushNamed(
              context,
              Routes.addTeamMember,
              arguments: const AddTeamMemberArguments(memberid: ""),
            );

            // If a new employee was added, refresh the list immediately
            if (result != null && result == true) {
              model.refreshList();
            }
          },
          child: const Icon(Icons.person_add_alt_1),
        ),
      ),
    );
  }
}
