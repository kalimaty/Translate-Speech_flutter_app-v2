import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_models/translation_view_model.dart';
import 'flag_button.dart';

class LanguageListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Consumer<TranslationViewModel>(
        builder: (context, viewModel, child) {
          return ListView.builder(
            physics: BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            itemCount: viewModel.languagesCode.length,
            itemBuilder: (context, index) {
              return FlagButton(
                text: viewModel.showTranslation[index]
                    ? viewModel.translatedTexts[index]
                    : viewModel.defaultTexts[index],
                flag: viewModel
                    .flags[index], // Use flag image path from _flags list
                onTap: () {
                  if (viewModel.translatedTexts.isNotEmpty) {
                    viewModel.speak(viewModel.languagesCode[index],
                        viewModel.translatedTexts[index]);
                    viewModel.toggleTranslation(index);
                  }
                },
              );
            },
          );
        },
      ),
    );
  }
}
