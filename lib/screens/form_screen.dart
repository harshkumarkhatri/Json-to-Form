import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';

List localJson = [
  {
    "id": "a7PPrsreuktH",
    "title": "Enter your name",
    "validations": {"required": true},
    "type": "short_text",
    "label": "Name",
  },
  {
    "id": "Z2sakg81mydT",
    "title": "Enter your gender",
    "properties": {
      "alphabetical_order": false,
      "choices": [
        {"label": "Male"},
        {"label": "Female"},
        {"label": "Rather not say"}
      ]
    },
    "validations": {"required": true},
    "type": "dropdown",
    "label": "Gender",
  },
  {
    "id": "peP1NwbWV5oC",
    "title": "Enter your age",
    "validations": {"required": true},
    "type": "number",
    "label": "Age",
  },
  {
    "id": "dTYFCBZNq3Ye",
    "title": "Enter your email address",
    "validations": {"required": true},
    "type": "email",
    "label": "Email",
  },
  {
    "id": "dTYFCBZNqe",
    "title": "Enter your second email address",
    "validations": {"required": true},
    "type": "email",
    "label": "Second Email",
  },
  {
    "id": "tNU4RLSOes46",
    "title": "Enter phone number (Optional)",
    "validations": {"required": false},
    "type": "phone_number",
    "label": "Number",
  },
  {
    "id": "UVuD3M9gjcg5",
    "title": "How was your experience at our gaming center",
    "properties": {"steps": 7},
    "validations": {"required": true},
    "type": "rating",
    "label": "Rating",
  },
  {
    "id": "YqoIovP8Xj3H",
    "title": "Enter date of visit",
    "properties": {"structure": "MMDDYYYY"},
    "validations": {"required": true},
    "type": "date",
    "label": "Date",
  },
  {
    "id": "fg0YM1yIolWp",
    "title": "Would you consider exploring our center again",
    "validations": {"required": true},
    "type": "yes_no",
    "label": "Exploring",
  },
  {
    "id": "a7PPrsreuH",
    "title": "Enter your name",
    "validations": {"required": true},
    "type": "short_text",
    "label": "Name",
  },
  {
    "id": "fg0YMIolWp",
    "title": "Would you consider exploring our center again",
    "validations": {"required": true},
    "type": "yes_no",
    "label": "Exploring",
  },
];

class FormScreen extends StatefulWidget {
  const FormScreen({super.key});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  List<Widget> items = [];
  final _formKey = GlobalKey<FormState>();

  // Value defined as dynamic as we can have int/strings both in them
  late Map<String, dynamic> localvalues;

  @override
  void initState() {
    super.initState();
    localvalues = {};
    setLocalValues();
    itemss();
  }

  @override
  void didUpdateWidget(covariant FormScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    log("Inside this");
  }

  void setLocalValues() {
    for (var item in localJson) {
      log(item["type"].toString());
      if (item["type"] != "yes_no") {
        localvalues[item["id"]] = "";
      } else {
        localvalues[item["id"]] = "No";
      }
    }
    log(localvalues.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Form Screen",
        ),
      ),
      body: SizedBox(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 12.0,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: items,
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: InkWell(
        onTap: () {
          if (_formKey.currentState!.validate()) {
            // TODO: Add check for rating
            _formKey.currentState?.save();
            showDialog(
              context: context,
              builder: (context) {
                Map<String, dynamic> dialogDisplay = {};
                for (var item in localJson) {
                  for (var nestedItem in localvalues.entries) {
                    if (nestedItem.key == item["id"]) {
                      dialogDisplay[item["label"]] = nestedItem.value;
                    }
                  }
                }
                log(dialogDisplay.toString());
                return AlertDialog(
                  title: const Text("My title"),
                  content: const Text("This is my message."),
                  actions: [
                    ...dialogDisplay.entries.map((entry) {
                      var w = Row(
                        children: [
                          Text(entry.key),
                          const SizedBox(
                            width: 12,
                          ),
                          Text(entry.value),
                        ],
                      );

                      return w;
                    }).toList(),
                    TextButton(
                      child: const Text("OK"),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    )
                  ],
                );
              },
            );
            log(localvalues.toString());
          } else {
            log("Invalid");
          }
        },
        child: Container(
          height: 56,
          decoration: const BoxDecoration(
            color: Colors.black,
          ),
          alignment: Alignment.center,
          child: const Text(
            "Submit",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  void itemss() {
    for (int i = 0; i < localJson.length; i++) {
      final currentItem = localJson[i];
      final index = i;
      if (currentItem["type"] == "short_text" &&
          index == localJson.indexOf(currentItem)) {
        items.add(
          Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: TextFormField(
              validator: (value) {
                if (!currentItem["validations"]["required"]) return null;
                return value?.isEmpty ?? true ? 'required' : null;
              },
              key: ValueKey(currentItem["id"]),
              style: const TextStyle(
                fontSize: 16.0,
                color: Colors.black,
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: currentItem["title"],
                filled: true,
                fillColor: Colors.grey.shade200,
                contentPadding:
                    const EdgeInsets.only(left: 14.0, bottom: 6.0, top: 8.0),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.blue,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.grey,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              onChanged: (String? value) {
                for (var item in localvalues.entries) {
                  if (item.key == currentItem["id"]) {
                    localvalues[currentItem["id"]] = value;
                  }
                }
              },
            ),
          ),
        );
      }
      if (currentItem["type"] == "dropdown" &&
          index == localJson.indexOf(currentItem)) {
        items.add(
          Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: DropdownButtonFormField<String>(
              validator: (value) {
                if (!currentItem["validations"]["required"]) return null;
                return value == null ? 'field required' : null;
              },
              value: null,
              icon: const Icon(Icons.arrow_downward),
              elevation: 16,
              style: const TextStyle(color: Colors.deepPurple),
              onChanged: (String? value) {
                for (var item in localvalues.entries) {
                  if (item.key == currentItem["id"]) {
                    localvalues[currentItem["id"]] = value;
                  }
                }

                setState(() {});
              },
              items: currentItem['properties']["choices"]
                  .map<DropdownMenuItem<String>>((Map<String, String> value) {
                return DropdownMenuItem<String>(
                  value: value['label'],
                  child: Text(value['label'].toString()),
                );
              }).toList(),
            ),
          ),
        );
      }
      if (currentItem['type'] == "number" &&
          index == localJson.indexOf(currentItem)) {
        items.add(
          Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: TextFormField(
              validator: (value) {
                if (!currentItem["validations"]["required"]) return null;
                return value?.isEmpty ?? true ? 'required' : null;
              },
              style: const TextStyle(
                fontSize: 16.0,
                color: Colors.black,
              ),
              key: ValueKey(currentItem["id"]),
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: currentItem["title"],
                filled: true,
                fillColor: Colors.grey.shade200,
                contentPadding:
                    const EdgeInsets.only(left: 14.0, bottom: 6.0, top: 8.0),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.blue,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.grey,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              onChanged: (String? value) {
                for (var item in localvalues.entries) {
                  if (item.key == currentItem["id"]) {
                    localvalues[currentItem["id"]] = value;
                  }
                }
              },
            ),
          ),
        );
      }
      if (currentItem['type'] == "email" &&
          index == localJson.indexOf(currentItem)) {
        items.add(
          Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: TextFormField(
              validator: (value) {
                if (!currentItem["validations"]["required"]) return null;
                return value?.isEmpty ?? true ? 'required' : null;
              },
              style: const TextStyle(
                fontSize: 16.0,
                color: Colors.black,
              ),
              key: ValueKey(currentItem["id"]),
              keyboardType: TextInputType.emailAddress,
              autofillHints: const [AutofillHints.email],
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: currentItem["title"],
                filled: true,
                fillColor: Colors.grey.shade200,
                contentPadding:
                    const EdgeInsets.only(left: 14.0, bottom: 6.0, top: 8.0),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.blue,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.grey,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              onChanged: (String? value) {
                for (var item in localvalues.entries) {
                  if (item.key == currentItem["id"]) {
                    localvalues[currentItem["id"]] = value;
                  }
                }
              },
            ),
          ),
        );
      }
      if (currentItem['type'] == "phone_number" &&
          index == localJson.indexOf(currentItem)) {
        items.add(
          Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: TextFormField(
              validator: (value) {
                if (!currentItem["validations"]["required"]) return null;
                return value?.isEmpty ?? true ? 'required' : null;
              },
              style: const TextStyle(
                fontSize: 16.0,
                color: Colors.black,
              ),
              key: ValueKey(currentItem["id"]),
              keyboardType: TextInputType.phone,
              autofillHints: const [
                AutofillHints.telephoneNumber,
              ],
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: currentItem["title"],
                filled: true,
                fillColor: Colors.grey.shade200,
                contentPadding:
                    const EdgeInsets.only(left: 14.0, bottom: 6.0, top: 8.0),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.blue,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.grey,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              onChanged: (String? value) {
                for (var item in localvalues.entries) {
                  if (item.key == currentItem["id"]) {
                    localvalues[currentItem["id"]] = value;
                  }
                }
              },
            ),
          ),
        );
      }
      if (currentItem["type"] == "rating" &&
          index == localJson.indexOf(currentItem)) {
        items.add(
          Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('${currentItem["title"]}'),
                  const SizedBox(
                    height: 8,
                  ),
                  Container(
                    key: ValueKey(currentItem["id"]),
                    child: RatingBar.builder(
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: false,
                      itemCount: 5,
                      itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (double rating) {
                        for (var item in localvalues.entries) {
                          if (item.key == currentItem["id"]) {
                            localvalues[currentItem["id"]] = rating.toString();
                          }
                        }
                        log(rating.toString());
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }
      if (currentItem["type"] == "yes_no" &&
          index == localJson.indexOf(currentItem)) {
        String initialValue = '';
        for (var item in localvalues.entries) {
          if (item.key == currentItem["id"]) {
            initialValue = localvalues[currentItem["id"]];
            setState(() {});
            log("Callled");
          }
        }
        items.add(
          Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: StatefulBuilder(builder: (context, stateSetter) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('${currentItem["title"]}'),
                  const SizedBox(
                    height: 8,
                  ),
                  SizedBox(
                    key: ValueKey(currentItem["id"]),
                    height: 40,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 5,
                          child: InkWell(
                            onTap: () {
                              for (var item in localvalues.entries) {
                                if (item.key == currentItem["id"]) {
                                  localvalues[currentItem["id"]] = "Yes";
                                  initialValue = "Yes";
                                }
                              }
                              stateSetter(() {});
                              log(localvalues.toString());
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: initialValue == "Yes"
                                    ? Colors.green
                                    : Colors.grey.shade200,
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(
                                    8,
                                  ),
                                  bottomLeft: Radius.circular(
                                    8,
                                  ),
                                ),
                              ),
                              alignment: Alignment.center,
                              child: const Text(
                                "Yes",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 5,
                          child: InkWell(
                            onTap: () {
                              for (var item in localvalues.entries) {
                                if (item.key == currentItem["id"]) {
                                  localvalues[currentItem["id"]] = "No";
                                  initialValue = "No";
                                }
                              }
                              stateSetter(() {});
                              log(localvalues.toString());
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color:
                                    initialValue == "No" || initialValue == ''
                                        ? Colors.green
                                        : Colors.grey.shade200,
                                borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(
                                    8,
                                  ),
                                  bottomRight: Radius.circular(
                                    8,
                                  ),
                                ),
                              ),
                              alignment: Alignment.center,
                              child: const Text(
                                "No",
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }),
          ),
        );
      }
      if (currentItem['type'] == "date" &&
          index == localJson.indexOf(currentItem)) {
        String initialValue = '';
        for (var item in localvalues.entries) {
          if (item.key == currentItem["id"]) {
            initialValue = localvalues[currentItem["id"]];
            setState(() {});
            log("Callled");
          }
        }
        items.add(
          Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: StatefulBuilder(builder: (context, stateSetter) {
              return TextFormField(
                controller: TextEditingController(text: initialValue),
                validator: (value) {
                  log("called");
                  return initialValue == '' ? 'required' : null;
                },
                style: const TextStyle(
                  fontSize: 16.0,
                  color: Colors.black,
                ),
                key: ValueKey(currentItem["id"]),
                decoration: InputDecoration(
                  icon: const Icon(Icons.calendar_today),
                  border: InputBorder.none,
                  hintText: currentItem["title"],
                  filled: true,
                  fillColor: Colors.grey.shade200,
                  contentPadding:
                      const EdgeInsets.only(left: 14.0, bottom: 6.0, top: 8.0),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.blue,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.grey,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                readOnly: true,
                onChanged: (String value) {
                  log("Value is $value");
                },
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: initialValue == ''
                        ? DateTime.now()
                        : DateTime.parse(initialValue),
                    firstDate: DateTime(1950),
                    lastDate: DateTime(2100),
                  );

                  if (pickedDate != null) {
                    log(pickedDate.toString());
                    String formattedDate =
                        DateFormat('yyyy-MM-dd').format(pickedDate);
                    log(formattedDate);
                    for (var item in localvalues.entries) {
                      if (item.key == currentItem["id"]) {
                        localvalues[currentItem["id"]] = formattedDate;
                        initialValue = formattedDate;
                      }
                    }
                    stateSetter(() {});
                  } else {
                    log("No date picked");
                  }
                },
              );
            }),
          ),
        );
      }
    }
    setState(() {});
  }
}
// TODO: Check for unnecessary setStates.
