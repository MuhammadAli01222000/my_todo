import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:my_todo/core/constants/app_icons.dart';
import 'package:my_todo/injcetion/locator.dart';
import 'package:my_todo/routes/path_router.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:uuid/uuid.dart';

import '../../../core/services/hive_service_impl.dart';
import '../../../core/utils/ui_helpers.dart';
import '../../../domain/entities/todo_entity.dart';
import '../../../domain/interfaces/hive_service.dart';
import '../../../l10n/app_localizations.dart';
import '../../widget/task_card.dart';
import '../../widget/todo_item_title.dart';

int _currentIndex = 0;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

final List<Widget> icons = [
  AppIcons.project,
  AppIcons.work,
  AppIcons.dailyTask,
  AppIcons.groceries,
];

class _HomePageState extends State<HomePage> {
  final ScrollController controller = ScrollController();
  final todoService = locator<ITodoService>();
  late Box<Todo> todoBox;

  @override
  void initState() {
    super.initState();
    todoBox = Hive.box<Todo>('todos');
  }

  Future<void> delete(String id) async {
    try {
      await todoService.deleteTodo(id);

    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Xatolik: $e'),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<String> tasks = [
      "${AppLocalizations.of(context)?.project}",
      " ${AppLocalizations.of(context)?.work}",
      "${AppLocalizations.of(context)?.dailyTasks}",
      "${AppLocalizations.of(context)?.groceries}",
    ];

    return Scaffold(
      bottomNavigationBar: _buildBottomNavigationBar(context),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await context.pushNamed(AppRouteName.addTask);
        },
        child: Icon(Icons.add),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          key: const PageStorageKey<String>('home_scroll_key'),
          controller: controller,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              SizedBox(
                height: 120,
                child: Stack(
                  children: [
                    Positioned(left: 10, top: 1, child: AppIcons.homePattern),
                    Positioned(
                      left: 50,
                      top: 50,
                      child: SizedBox(
                        width: 321,
                        height: 65,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "${AppLocalizations.of(context)?.userName}'",
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  '${AppLocalizations.of(context)?.youHave}',
                                ),
                              ],
                            ),
                            Spacer(),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: AppIcons.user,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              /// todo task cards
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                child: GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 2,
                  physics: const NeverScrollableScrollPhysics(),
                  children: List.generate(tasks.length, (index) {
                    return TaskCard(
                      icon: icons[index],
                      text: tasks[index],
                      count: (index + 1) * 2,
                      color: Colors
                          .primaries[index * 2 % Colors.primaries.length]
                          .shade200,
                    );
                  }),
                ),
              ),

              /// todo list task
              ValueListenableBuilder(
                valueListenable: todoBox.listenable(),
                builder: (context, Box<Todo> box, _) {
                  final todoList = box.values.toList();

                  return Padding(
                    padding: const EdgeInsets.all(6),
                    child: todoList.isEmpty
                        ? Center(
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Text(
                                "empty",
                                //'${AppLocalizations.of(context)?.crateNewTask}',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ),
                          )
                        : Column(
                            children: [
                              for (final item in todoList)
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: TodoItemTile(
                                    title: 'Title ${item.title ?? ''}',
                                    time: _formatTime(item),
                                    onEdit: () async {
                                      final result = await context.pushNamed(
                                        AppRouteName.edit,
                                        extra: item,
                                      );
                                    },
                                    onDelete: () async {
                                      await deleteTodoDialog(
                                        id: '${item.id}',
                                        context: context,
                                        onTap: () async {
                                          await delete(item.id);
                                          context.pop();
                                        },
                                      );

                                      //   await     delete(item.id);
                                    },
                                  ),
                                ),
                            ],
                          ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  BottomNavigationBar _buildBottomNavigationBar(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      onTap: (index) {
        setState(() {
          _currentIndex = index;
        });
        if (index != 0 ) {
          context.goNamed(AppRouteName.home);
        }
        if (index == 1) {
          context.pushNamed(AppRouteName.settings);
        }
        if (index == 2) {
          context.pushNamed(AppRouteName.cloud);
        }
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_today_outlined),
          label: "",
        ),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: ""),
        BottomNavigationBarItem(
          icon:Icon(Icons.cloud_download_outlined,color: Colors.blue,),
          label: "",
        ),

      ],
    );
  }

  String _formatTime(Todo item) {
    if (item.startTime != null && item.endTime != null) {
      return '${item.startTime!.hour} AM - ${item.endTime!.hour} PM';
    } else if (item.startTime != null) {
      return '${item.startTime!.hour} AM';
    } else if (item.endTime != null) {
      return '${item.endTime!.hour} PM';
    }
    return 'Vaqt belgilanmagan';
  }
}
