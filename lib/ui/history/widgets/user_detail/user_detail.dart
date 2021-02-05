import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:word_scramble_frontend/lib/auth/bloc/auth_bloc.dart';
import 'package:word_scramble_frontend/ui/history/widgets/user_detail/bloc/user_detail_bloc.dart';

class UserDetail extends StatefulWidget {

  _UserDetail createState() => _UserDetail();

}

class _UserDetail extends State<UserDetail> {

  AuthBloc _authBloc;
  UserDetailBloc _bloc;

  @override
  void initState() {
    super.initState();

    _authBloc = BlocProvider.of<AuthBloc>(context);
    _bloc = new UserDetailBloc();
    if (_authBloc.state is AuthenticatedState) {
      AuthenticatedState s = _authBloc.state;
      _bloc.add(FetchUserDetailEvent(s.user.id));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Row(
        children: [
          Expanded(
            child: BlocBuilder(
              cubit: _authBloc,
              builder: (context, state) {
                if (state is AuthenticatedState) {
                  return Text(
                    "Welcome, " + state.user.name,
                    style: TextStyle(
                      fontSize: 20
                    ),
                  );
                }
                return Container();
              },
            )
          ),
          Expanded(
            child: Container(
              alignment: Alignment.centerRight,
              child: BlocBuilder(
                cubit: _bloc,
                builder: (context, state) {
                  if (state is UserDetailFetched) {
                    return Text(
                      "Point : " + state.data.point.toString(),
                      style: TextStyle(
                        fontSize: 20
                      ),
                    );
                  }
                  return Container();
                },
              ),
            ),
          )
        ],
      ),
    );
  }

}