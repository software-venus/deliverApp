import 'package:entrega/utils/list_transforms/list_transforms.dart';
import 'package:entrega/utils/general/reference_Page_State.dart';
import 'package:flutter/material.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:translator/translator.dart';
import 'package:entrega/variables/globalvar.dart';

Widget multiSelectDropDownButtomEditFormat(
  ReferencePageState referencePageState,
  BuildContext context,
  String title,
  IconData icon,
  List<String> list,
  TextEditingController textEditingController,
) {
  if (list.isEmpty) list.add("");

  String inputText = textEditingController.text;
  if (inputText.isEmpty) inputText = list[0];
  inputText = listIntoOrReset(list, inputText);

  return FutureBuilder<List<ValueItem>>(
    future: Future.wait(list.map((value) async {
      if(value == ""||value == " "){return const ValueItem(label: " ", value: " ");}
      String translated = await getTranslatedDetail(value, languageStatus);
      return ValueItem(label: translated, value: value);
    })),
    builder: (context, snapshot) {
      if (!snapshot.hasData) {
        return const Padding(
          padding: EdgeInsets.all(10),
          child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
        );
      }

      List<ValueItem> translatedOptions = snapshot.data!;

      return Padding(
        padding: const EdgeInsets.only(left: 5, right: 5, top: 15, bottom: 5),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(5),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  title,
                  maxLines: 1,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5, bottom: 5, left: 0, right: 10),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: const BorderRadius.all(Radius.circular(40)),
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 5, bottom: 5, left: 5, right: 10),
                      child: Icon(icon, size: 30),
                    ),
                    Expanded(
                      child: MultiSelectDropDown(
                        showClearIcon: true,
                        onOptionSelected: (options) {
                          textEditingController.text = "";
                          for (ValueItem item in options) {
                            if (textEditingController.text.isNotEmpty) {
                              textEditingController.text += ",";
                            }
                            textEditingController.text += item.value.toString().replaceAll(",", " ");
                          }
                        },
                        options: translatedOptions,
                        selectionType: SelectionType.multi,
                        chipConfig: const ChipConfig(wrapType: WrapType.wrap),
                        dropdownHeight: 300,
                        optionTextStyle: const TextStyle(fontSize: 16),
                        selectedOptionIcon: const Icon(Icons.check_circle),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}

// Translator
Future<String> getTranslatedDetail(String text, int languageStatus) async {
  final translator = GoogleTranslator();
  return languageStatus == 0
      ? text
      : await translator.translate(text, to: "en").then((t) => t.text);
}
