import 'package:flutter/material.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Colors.white,            
            Colors.indigoAccent,
            Colors.indigo,
          ],
        )),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
            height: MediaQuery.of(context).size.height * .30,
            decoration: const BoxDecoration(
                image: DecorationImage(
              fit: BoxFit.contain,
              image: AssetImage("assets/images/taskhome.png"),
            )),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            'To Do List App',
            style: TextStyle
            (
              shadows: <Shadow>[
                Shadow(color: Colors.black, blurRadius: 15,)
              ],
                fontSize: 35, color: Colors.white, fontStyle: FontStyle.italic),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 100,
            width: MediaQuery.of(context).size.width * .8,
            child: ElevatedButton(
              onPressed: (() {
                Navigator.pushNamed(context, 'new_task');
              }),
              child: Row(children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'New Task',
                        style: TextStyle(fontSize: 25),
                      ),
                      Text(
                        'You can organize your tasks \nby adding your tasks into separate categories and include date validity',
                        style: TextStyle(
                            fontSize: 13, fontStyle: FontStyle.italic),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                const Icon(
                  Icons.add,
                  size: 35,
                ),
              ]),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 100,
            width: MediaQuery.of(context).size.width * .8,
            child: ElevatedButton(
              onPressed: (() {
                Navigator.pushNamed(context, 'list_task');
              }),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'List Task',
                          style: TextStyle(fontSize: 25),
                        ),
                        Text(
                          'You can check all your pending/running/in progress tasks here',
                          style: TextStyle(
                              fontSize: 13, fontStyle: FontStyle.italic),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Icon(
                    Icons.edit_note_outlined,
                    size: 35,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
        ]),
      ),
    );
  }
}
