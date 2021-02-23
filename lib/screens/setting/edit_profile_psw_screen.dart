import 'package:BrandFarm/blocs/profile/bloc.dart';
import 'package:BrandFarm/widgets/loading/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditProfilePswScreen extends StatefulWidget {
  String psw;
  EditProfilePswScreen({Key key, String psw})
      : psw = psw ?? '--', super(key: key);

  @override
  _EditProfilePswScreenState createState() => _EditProfilePswScreenState();
}

class _EditProfilePswScreenState extends State<EditProfilePswScreen> {
  ProfileBloc _profileBloc;
  TextEditingController _textEditingController;
  FocusNode fNode;
  bool isValid = true;

  @override
  void initState() {
    super.initState();
    _profileBloc = BlocProvider.of<ProfileBloc>(context);
    if(widget.psw == '--') {
      _textEditingController = TextEditingController();
    } else {
      _textEditingController = TextEditingController(text: '${widget.psw}');
    }
    fNode = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state.isPswComplete == true && state.isUploaded == false) {
          LoadingDialog.onLoading(context);
          _profileBloc.add(EditPassword(psw: _textEditingController.text));
        } else if (state.isPswComplete == true && state.isUploaded == true) {
          LoadingDialog.dismiss(context, () {
            Navigator.pop(context);
          });
        }
      },
      builder: (context, state) {
        return GestureDetector(
          onTap: (){
            fNode.unfocus();
            _textEditingController.clear();
            setState(() {
              isValid = true;
            });
          },
          child: Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Color(0xFF219653),
                ),
              ),
              centerTitle: true,
              title: Text(
                '비밀번호 변경',
                style: Theme.of(context).textTheme.bodyText1.copyWith(
                  fontSize: 18,
                ),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.fromLTRB(16, 50, 16, 0),
              child: Container(
                height: 300,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('새로운 비밀번호', style: Theme.of(context).textTheme.bodyText1,),
                    SizedBox(width: 22,),
                    Expanded(
                      child: TextField(
                        focusNode: fNode,
                        controller: _textEditingController,
                        keyboardType: TextInputType.number,
                        onTap: (){
                          fNode.requestFocus();
                          _textEditingController.clear();
                          setState(() {
                            isValid = true;
                          });
                        },
                        onSubmitted: (text) {
                          _profileBloc.add(CompletePressed(from: 4));
                        },
                        style: Theme.of(context).textTheme.bodyText1,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.zero,
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          isDense: true,
                          hintText: '새 비밀번호를 입력하세요',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
