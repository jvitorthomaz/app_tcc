import 'package:flutter/material.dart';

class UserRegisterPage extends StatefulWidget {

  const UserRegisterPage({ super.key });

  @override
  State<UserRegisterPage> createState() => _UserRegisterPageState();
}

class _UserRegisterPageState extends State<UserRegisterPage> {

   @override
   Widget build(BuildContext context) {
       return Scaffold(
           appBar: AppBar(title: const Text('Criar nova conta'),),
           body: Padding(
             padding: const EdgeInsets.all(30.0),
             child: SingleChildScrollView(
              child: Column(
                children: [

                  const SizedBox(
                     height: 20,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      label: Text('Nome')
                    ),
                  ),

                  // const SizedBox(
                  //   height: 25,
                  // ),
                  // TextFormField(
                  //   decoration: InputDecoration(
                  //     label: Text('CPF')
                  //   ),
                  // ),

                  // const SizedBox(
                  //   height: 25,
                  // ),
                  // TextFormField(
                  //   decoration: InputDecoration(
                  //     label: Text('Numero do Celular')
                  //   ),
                  // ),

                  const SizedBox(
                    height: 25,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      label: Text('E-mail')
                    ),
                  ),

                  const SizedBox(
                    height: 25,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      label: Text('Senha')
                    ),
                  ),

                   const SizedBox(
                    height: 25,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      label: Text('Confirmar Senha')
                    ),
                  ),

                  const SizedBox(
                     height: 25,
                  ),

                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(55)
                    ),
                    onPressed: () {},
                    child: const Text('CADASTRAR'),
                  )


                ],
              ),
             ),
           ),
       );
  }
}