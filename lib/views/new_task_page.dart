import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';

class NewTaskPage extends StatefulWidget {
  const NewTaskPage({super.key});

  @override
  State<NewTaskPage> createState() => _NewTaskPageState();
}

class _NewTaskPageState extends State<NewTaskPage> {
  @override
  Widget build(BuildContext context) {
    final taskDescriptionController = TextEditingController();
    final listStatusTask = ['PENDING', 'FINISHED', 'IN PROGRESS', 'CANCELLED'];    

    String statusTask = listStatusTask.first;
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                readOnly: false,
                controller: taskDescriptionController,
                decoration: const InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    labelText: 'Title',
                    labelStyle: TextStyle(fontSize: 22),
                    floatingLabelStyle: TextStyle(fontSize: 16),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(width: 1),
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    )),
                keyboardType: TextInputType.name,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Title is required';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 25,
              ),
              TextFormField(
                maxLines: 5,
                readOnly: false,
                decoration: const InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    labelText: 'Description',
                    labelStyle: TextStyle(fontSize: 22),
                    floatingLabelStyle: TextStyle(fontSize: 16),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(width: 1),
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    )),
                keyboardType: TextInputType.name,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Description is required';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 25,
              ),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(border: OutlineInputBorder()),
                value: statusTask,
                icon: const Icon(Icons.arrow_downward),
                elevation: 16,
                style: const TextStyle(color: Colors.deepPurple),
                onChanged: (String? value) {
                  setState(() {
                    statusTask = value!;
                  });
                },
                items: listStatusTask
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              const SizedBox(
                height: 25,
              ),
              SizedBox(                  
                  width: MediaQuery.of(context).size.width * .8,
                  child: DateTimePicker(
                    decoration: const InputDecoration(border: OutlineInputBorder(), floatingLabelAlignment: FloatingLabelAlignment.center),
                    initialValue: DateTime.now().toString(),
//                    dateMask: 'dd/MM/yyy',
                    type: DateTimePickerType.date,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2020),
                    fieldLabelText: 'Date',                    
                    onChanged: (val) {},
                    validator: (val) {
                      return null;
                    },
                    onSaved: (val) {},
                  )),
            ],
          ),
        ),
      ),
      appBar: AppBar(title: const Text('Nova Task')),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            Navigator.pop(context);
          }),
    );
  }
}
