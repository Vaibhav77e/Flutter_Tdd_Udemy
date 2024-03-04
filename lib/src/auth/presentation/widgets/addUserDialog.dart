import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tdd_tutorial/src/auth/presentation/cubit/authenication_cubit.dart';

class AddUserDialog extends StatelessWidget {
   AddUserDialog({required this.nameController});
   final TextEditingController nameController;

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white
          ),
          child:   Column(
            mainAxisSize: MainAxisSize.min,
            children:[
              TextField(
                controller:nameController ,
                decoration:const InputDecoration(
                  labelText: 'Username',
                  floatingLabelBehavior:FloatingLabelBehavior.never
                ),
              ),
              ElevatedButton(
                onPressed: (){
                final String name = nameController.text.trim();
                print('Name : ${name}');
                const String avatar = 'https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/827.jpg';
                context.read<AuthenticationCubit>().createUser(
                  createdAt: DateTime.now().toString(),
                  name: name, 
                  avatar: avatar
                );
                Navigator.of(context).pop();
              }, 
              child: const Text('Create Users'))
            ]
          ),
        ),
      ),
    );
  }
}
