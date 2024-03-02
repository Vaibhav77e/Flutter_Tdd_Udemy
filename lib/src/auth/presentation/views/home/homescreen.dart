import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tdd_tutorial/src/auth/presentation/cubit/authenication_cubit.dart';

import '../../cubit/authenication_state.dart';
import '../../widgets/addUserDialog.dart';
import '../../widgets/loadingColumn.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}



class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController nameController = TextEditingController();
  @override
  void initState() {
    super.initState();
    getUsers();
  }

  void getUsers(){
    context.read<AuthenticationCubit>().getUsers();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationCubit, AuthenticationState>(
      listener: (context, state) {
        if(state is AuthenticationError){
           ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
        } else if( state is GettingUsers){
            getUsers();
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: state is GettingUsers
          ?LoadingColumn(message: 'Fetching Users',)
        :state is CreatingUser
          ? LoadingColumn(message: 'Creating Users',)
        : state is UsersLoaded
          ?Center(
            child: ListView.builder(
              itemCount: state.users.length,
              itemBuilder:(context, index){
                final user = state.users[index];
                return ListTile(
                  leading: Image.network(user.avatar),
                  title: Text(user.name),
                  subtitle: Text(user.createdAt.substring(10)),
                );
              }
              ),
          ) : const SizedBox.shrink(child: Text('No data found'),) ,
          floatingActionButton: FloatingActionButton.extended(
          onPressed: ()async{
            await showDialog(context: context,
            builder: (context)=>AddUserDialog(nameController: nameController),
            );
          },
          label: const Text('Add User'),
          icon: const Icon(Icons.add),
          ),
        );
      },
    );
  }
}