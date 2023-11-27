import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const String title = 'Shortcuts and Actions Demo';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)),
      home: Shortcuts(
        shortcuts: <LogicalKeySet, Intent>{
          LogicalKeySet(LogicalKeyboardKey.escape): const ClearIntent(),
          LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.keyC):
              const CopyIntent(),
          LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.keyA):
              const SelectAllIntent()
        },
        child: const CopyableTextField(
          title: title,
        ),
      ),
    );
  }
}

class ClearIntent extends Intent {
  const ClearIntent();
}

class ClearAction extends Action<ClearIntent> {
  ClearAction(this.controller);
  final TextEditingController controller;

  @override
  Object? invoke(covariant ClearIntent intent) {
    controller.clear();
    return null;
  }
}

class CopyIntent extends Intent {
  const CopyIntent();
}

class CopyAction extends Action<CopyIntent> {
  CopyAction(this.controller);

  final TextEditingController controller;

  @override
  Object? invoke(covariant CopyIntent intent) {
    final String selectedString = controller.text.substring(
      controller.selection.baseOffset,
      controller.selection.extentOffset,
    );
    Clipboard.setData(ClipboardData(text: selectedString));
    return null;
  }
}

class SelectAllIntent extends Intent {
  const SelectAllIntent();
}

class SelectAllAction extends Action<SelectAllIntent> {
  SelectAllAction(this.controller);
  final TextEditingController controller;

  @override
  Object? invoke(covariant SelectAllIntent intent) {
    controller.selection = controller.selection.copyWith(
        baseOffset: 0,
        extentOffset: controller.text.length,
        affinity: controller.selection.affinity);
    return null;
  }
}

class LoggingActionDispatcher extends ActionDispatcher {
  @override
  Object? invokeAction(covariant Action<Intent> action, covariant Intent intent,
      [BuildContext? context]) {
    print('Action invoked: $action($intent) from $context');
    super.invokeAction(action, intent, context);
    return null;
  } 
}

class CopyableTextField extends StatefulWidget {
  const CopyableTextField({super.key, required this.title});

  final String title;

  @override
  State<CopyableTextField> createState() => _CopyableTextFieldState();
}

class _CopyableTextFieldState extends State<CopyableTextField> {
  late TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Actions(
      dispatcher: LoggingActionDispatcher(),
      actions: <Type, Action<Intent>>{
        ClearIntent: ClearAction(controller),
        CopyIntent: CopyAction(controller),
        SelectAllIntent: SelectAllAction(controller)
      },
      child: Builder(
        builder: (context) {
          return Scaffold(
            body: Center(
              child: Row(
                children: <Widget>[
                  const Spacer(),
                  Expanded(
                    child: TextField(
                      controller: controller,
                    ),
                  ),
                  IconButton(
                      onPressed: Actions.handler<CopyIntent>(
                          context, const CopyIntent()),
                      icon: const Icon(Icons.copy)),
                  IconButton(
                      onPressed:
                          Actions.handler(context, const SelectAllIntent()),
                      icon: Icon(Icons.select_all)),
                  const Spacer(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
