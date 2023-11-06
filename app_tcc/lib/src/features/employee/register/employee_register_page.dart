import 'package:flutter/material.dart';
import 'package:tcc_app/src/core/ui/constants.dart';
import 'package:tcc_app/src/core/ui/widgets/hours_widget.dart';
import 'package:tcc_app/src/core/ui/widgets/user_avatar_widget.dart';
import 'package:tcc_app/src/core/ui/widgets/weekdays_widget.dart';

class EmployeeRegisterPage extends StatefulWidget {

  const EmployeeRegisterPage({ super.key });

  @override
  State<EmployeeRegisterPage> createState() => _EmployeeRegisterPageState();
}

class _EmployeeRegisterPageState extends State<EmployeeRegisterPage> {
  var isAdm = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cadastrar novo colaborador'),),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Column(
              children: [
                const UserAvatarWidget(),
                const SizedBox(
                   height: 30,
                ),
                Row(
                  children: [
                    Checkbox.adaptive(
                      activeColor:AppColors.colorGreen,
                      checkColor: Colors.white,
                      value: isAdm,
                      onChanged: (value) {
                        setState(() {
                          isAdm = !isAdm;
                          // employeeeRegisterVM.setRegisterADM(isAdm);
                        });
                      }
                    ),
                    const Expanded(
                      child: Text(
                        'Sou administrador e quero me cadastrar como colaborador',
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    )
                  ],
                ),
                Offstage(
                  offstage: isAdm,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 24,
                      ),
                      TextFormField(
                        // controller: nameEC,
                        // validator: registerADM
                        //     ? null
                        //     : Validatorless.required(
                        //         'Nome obrigatório'),
                        decoration: const InputDecoration(
                            label: Text('Nome')),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      TextFormField(
                        // controller: emailEC,
                        // validator: registerADM
                        //     ? null
                        //     : Validatorless.multiple([
                        //         Validatorless.required(
                        //             'E-mail obrigatório'),
                        //         Validatorless.email(
                        //             'E-mail obrigatório')
                        //       ]),
                        decoration: const InputDecoration(
                            label: Text('E-mail')),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      TextFormField(
                        // controller: passwordEC,
                        // validator: registerADM
                        //     ? null
                        //     : Validatorless.multiple([
                        //         Validatorless.required(
                        //             'Senha Obrigatório'),
                        //         Validatorless.min(6,
                        //             'Senha deve ter no minimo 6 caracteres'),
                        //       ]),
                        decoration: const InputDecoration(
                            label: Text('Senha')),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                   height: 25,
                ),
                WeekdaysWidget(
                  onDayPressed: (String day){

                  }
                ),

                const SizedBox(
                   height: 25,
                ),
                HoursPanel(
                  startTime: 8, 
                  endTime: 19, 
                  onHourPressed: (int hour){
                    
                  }
                ),

                const SizedBox(
                   height: 25,
                ),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size.fromHeight(55)
                  ),
                  onPressed: (){}, 
                  child: Text('Cadastrar')
                )
                

              ],
            ),
          ),
        )
      ),
    );
  }
}