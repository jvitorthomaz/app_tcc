import 'package:flutter/material.dart';
import 'package:tcc_app/src/core/ui/widgets/hours_widget.dart';
import 'package:tcc_app/src/core/ui/widgets/weekdays_widget.dart';

class PlaceRegisterPage extends StatefulWidget {

  const PlaceRegisterPage({ super.key });

  @override
  State<PlaceRegisterPage> createState() => _PlaceRegisterPageState();
}

class _PlaceRegisterPageState extends State<PlaceRegisterPage> {

   @override
   Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cadastrar estabelecimento'),),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: SingleChildScrollView(
          child: Column(
          children: [
            const SizedBox(
                height: 15,
            ),


            TextFormField(
              decoration: const InputDecoration(
                label: Text('Nome')
              ),
            ),

            const SizedBox(
               height: 25,
            ),


            TextFormField(
              decoration: const InputDecoration(
                label: Text('E-mail')
              ),
            ),

            const SizedBox(
               height: 25,
            ),

            WeekdaysWidget(
              onDayPressed: (String value) {

              },
            ),
            const SizedBox(
               height: 25,
            ),

            HoursPanel(startTime: 8, endTime: 19, onHourPressed: (int value){}),
            const SizedBox(
               height: 25,
            ),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(55)
              ),
              onPressed: () {

              }, 
              child: const Text('CADASTRAR'),
            ),
          ],
          ),
        ),
      ),
    );
  }
}