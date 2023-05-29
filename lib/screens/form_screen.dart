import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';

List localJsonList = [
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
    "title": "Would you consider exploring our center again?",
    "validations": {"required": true},
    "type": "yes_no",
    "label": "Exploring",
  },
  {
    "id": "a7PPrsreuH",
    "title": "Enter your surname",
    "validations": {"required": true},
    "type": "short_text",
    "label": "Surname",
  },
  {
    "id": "fg0YMIolWp",
    "title": "Would you consider exploring our website again?",
    "validations": {"required": true},
    "type": "yes_no",
    "label": "Website",
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
  late Map<String, dynamic> localvaluesMap;

  @override
  void initState() {
    super.initState();
    localvaluesMap = {};
    setLocalValues();
    itemss();
  }

  void setLocalValues() {
    for (var item in localJsonList) {
      if (item["type"] != "yes_no") {
        localvaluesMap[item["id"]] = "";
      } else {
        localvaluesMap[item["id"]] = "No";
      }
    }
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
            // Check for rating
            for (var mapItem in localvaluesMap.entries) {
              for (var listItem in localJsonList) {
                if (listItem['type'] == 'rating' &&
                    mapItem.key == listItem['id']) {
                  if (mapItem.value == '') {
                    const snackBar = SnackBar(
                      content: Text('Please choose a rating.'),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    return;
                  }
                }
              }
            }
            _formKey.currentState?.save();
            showDialog(
              context: context,
              builder: (context) {
                Map<String, dynamic> dialogDisplay = {};
                for (var item in localJsonList) {
                  for (var nestedItem in localvaluesMap.entries) {
                    if (nestedItem.key == item["id"]) {
                      dialogDisplay[item["label"]] = nestedItem.value;
                    }
                  }
                }
                return AlertDialog(
                  title: const Text("Details you filled"),
                  content:
                      const Text("Please check the details filled by you."),
                  actions: [
                    ...dialogDisplay.entries.map(
                      (entry) {
                        final userData = isEmail(entry.value)
                            ? entry.value
                            : entry.value[0].toUpperCase() +
                                entry.value.substring(1).toLowerCase();
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Row(
                            children: [
                              Text(
                                "${entry.key}: ",
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(
                                width: 12,
                              ),
                              Text(
                                userData,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ).toList(),
                    TextButton(
                      child: const Text("OK"),
                      onPressed: () {
                        // popping the dialog and screen to show new
                        // form screen
                        Navigator.pop(context);
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const FormScreen(),
                          ),
                        );
                      },
                    )
                  ],
                );
              },
            );
          } else {
            const snackBar = SnackBar(
              content: Text('Invalid data.'),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
    for (int index = 0; index < localJsonList.length; index++) {
      final currentItem = localJsonList[index];
      if (currentItem["type"] == "short_text" &&
          index == localJsonList.indexOf(currentItem)) {
        items.add(
          Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: TextFormField(
              validator: (value) {
                if (!currentItem["validations"]["required"]) return null;
                return value?.isEmpty ?? true
                    ? '${currentItem["label"]} is required.'
                    : null;
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
                for (var item in localvaluesMap.entries) {
                  if (item.key == currentItem["id"]) {
                    localvaluesMap[currentItem["id"]] = value;
                  }
                }
              },
            ),
          ),
        );
      }
      if (currentItem["type"] == "dropdown" &&
          index == localJsonList.indexOf(currentItem)) {
        items.add(
          Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: DropdownButtonFormField<String>(
              validator: (value) {
                if (!currentItem["validations"]["required"]) return null;
                return value == null
                    ? '${currentItem['label']} is required.'
                    : null;
              },
              value: null,
              icon: const Icon(Icons.arrow_downward),
              elevation: 16,
              style: const TextStyle(color: Colors.blue),
              decoration: InputDecoration(
                fillColor: Colors.grey.shade200,
                filled: true,
                hintText: currentItem['title'],
                border: InputBorder.none,
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
                for (var item in localvaluesMap.entries) {
                  if (item.key == currentItem["id"]) {
                    localvaluesMap[currentItem["id"]] = value;
                  }
                }
                setState(() {});
              },
              items: currentItem['properties']["choices"]
                  .map<DropdownMenuItem<String>>(
                (Map<String, String> value) {
                  return DropdownMenuItem<String>(
                    value: value['label'],
                    child: Text(value['label'].toString()),
                  );
                },
              ).toList(),
            ),
          ),
        );
      }
      if (currentItem['type'] == "number" &&
          index == localJsonList.indexOf(currentItem)) {
        items.add(
          Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: TextFormField(
              validator: (value) {
                if (!currentItem["validations"]["required"]) return null;
                return value?.isEmpty ?? true
                    ? '${currentItem["label"]} is required.'
                    : null;
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
                for (var item in localvaluesMap.entries) {
                  if (item.key == currentItem["id"]) {
                    localvaluesMap[currentItem["id"]] = value;
                  }
                }
              },
            ),
          ),
        );
      }
      if (currentItem['type'] == "email" &&
          index == localJsonList.indexOf(currentItem)) {
        items.add(
          Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: TextFormField(
              validator: (value) {
                if (!currentItem["validations"]["required"]) return null;
                if (value?.isEmpty ?? true) {
                  return '${currentItem["label"]} is required.';
                }
                if (!isEmail(value ?? '')) return 'Not a valid email';
                return null;
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
                for (var item in localvaluesMap.entries) {
                  if (item.key == currentItem["id"]) {
                    localvaluesMap[currentItem["id"]] = value;
                  }
                }
              },
            ),
          ),
        );
      }
      if (currentItem['type'] == "phone_number" &&
          index == localJsonList.indexOf(currentItem)) {
        items.add(
          Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: TextFormField(
              validator: (value) {
                if (!currentItem["validations"]["required"]) return null;
                if (value?.isEmpty ?? true) {
                  return '${currentItem["label"]} is required.';
                }
                if (value != null && value.length < 10) {
                  return 'Not a valid number. \nPlease enter 10 digits.';
                }
                return null;
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
                for (var item in localvaluesMap.entries) {
                  if (item.key == currentItem["id"]) {
                    localvaluesMap[currentItem["id"]] = value;
                  }
                }
              },
            ),
          ),
        );
      }
      if (currentItem["type"] == "rating" &&
          index == localJsonList.indexOf(currentItem)) {
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
                        for (var item in localvaluesMap.entries) {
                          if (item.key == currentItem["id"]) {
                            localvaluesMap[currentItem["id"]] =
                                rating.toString();
                          }
                        }
                        setState(() {});
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
          index == localJsonList.indexOf(currentItem)) {
        String initialValue = '';
        for (var item in localvaluesMap.entries) {
          if (item.key == currentItem["id"]) {
            initialValue = localvaluesMap[currentItem["id"]];
          }
        }
        items.add(
          Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: StatefulBuilder(
              builder: (context, stateSetter) {
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
                                for (var item in localvaluesMap.entries) {
                                  if (item.key == currentItem["id"]) {
                                    localvaluesMap[currentItem["id"]] = "Yes";
                                    initialValue = "Yes";
                                  }
                                }
                                stateSetter(() {});
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
                                for (var item in localvaluesMap.entries) {
                                  if (item.key == currentItem["id"]) {
                                    localvaluesMap[currentItem["id"]] = "No";
                                    initialValue = "No";
                                  }
                                }
                                stateSetter(() {});
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
              },
            ),
          ),
        );
      }
      if (currentItem['type'] == "date" &&
          index == localJsonList.indexOf(currentItem)) {
        String initialValue = '';
        for (var item in localvaluesMap.entries) {
          if (item.key == currentItem["id"]) {
            initialValue = localvaluesMap[currentItem["id"]];
          }
        }
        items.add(
          Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: StatefulBuilder(
              builder: (context, stateSetter) {
                return TextFormField(
                  controller: TextEditingController(text: initialValue),
                  validator: (value) {
                    return initialValue == ''
                        ? '${currentItem["label"]} is required.'
                        : null;
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
                    contentPadding: const EdgeInsets.only(
                        left: 14.0, bottom: 6.0, top: 8.0),
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
                      String formattedDate =
                          DateFormat('yyyy-MM-dd').format(pickedDate);
                      for (var item in localvaluesMap.entries) {
                        if (item.key == currentItem["id"]) {
                          localvaluesMap[currentItem["id"]] = formattedDate;
                          initialValue = formattedDate;
                        }
                      }
                      stateSetter(() {});
                    }
                  },
                );
              },
            ),
          ),
        );
      }
    }
  }

  bool isEmail(String value) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value);
  }
}
