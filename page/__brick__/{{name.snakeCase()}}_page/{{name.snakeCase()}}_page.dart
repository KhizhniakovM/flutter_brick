import 'package:flutter/material.dart';

import 'widget/{{name.snakeCase()}}_view.dart';

class {{name.pascalCase()}}Page extends StatelessWidget {
  static const path = '{{name.pascalCase()}}';

  const {{name.pascalCase()}}Page({super.key});

  @override
  Widget build(BuildContext context) => LayoutBuilder(
          builder: (context, constraints) => const {{name.pascalCase()}}View(),
        ),
}

