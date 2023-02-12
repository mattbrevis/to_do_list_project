import 'package:flutter/material.dart';


class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * .8,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * .20,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                    image: AssetImage("assets/images/taskico.png"),
                  )),
                ),
                SizedBox(
                  height: 120,
                  child: ElevatedButton(
                    onPressed: (() {
                      Navigator.pushNamed(context, 'new_task');
                    }),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                      Text(
                        'New Task',
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(width: 10,),
                      Icon(Icons.add, size: 35,),
                    ]),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 120,
                  child: ElevatedButton(
                    onPressed: (() {
                      Navigator.pushNamed(context, 'list_task');
                    }),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const[
                       Text(
                          'List Task',
                          style: TextStyle(fontSize: 20),
                        ),
                        SizedBox(width: 10,),
                        Icon(Icons.edit_note_outlined, size: 35,),
                      ],
                    ),
                    
                  ),
                  
                ),
                const SizedBox(
                  height: 10,
                ),
              ]),
        ),
      ),
    );
  }
}
