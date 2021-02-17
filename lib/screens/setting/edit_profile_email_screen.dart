import 'package:BrandFarm/blocs/profile/bloc.dart';
import 'package:BrandFarm/widgets/loading/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditProfileEmailScreen extends StatefulWidget {
  String email;
  EditProfileEmailScreen({Key key, String email})
      : email = email ?? '--', super(key: key);

  @override
  _EditProfileEmailScreenState createState() => _EditProfileEmailScreenState();
}

class _EditProfileEmailScreenState extends State<EditProfileEmailScreen> {
  ProfileBloc _profileBloc;
  TextEditingController _textEditingController;
  FocusNode fNode;
  bool isValid = true;

  @override
  void initState() {
    super.initState();
    _profileBloc = BlocProvider.of<ProfileBloc>(context);
    if(widget.email == '--') {
      _textEditingController = TextEditingController();
    } else {
      _textEditingController = TextEditingController(text: '${widget.email}');
    }
    fNode = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state.isComplete == true && state.isUploaded == false) {
          LoadingDialog.onLoading(context);
          _profileBloc.add(EditEmail(email: _textEditingController.text));
        } else if (state.isComplete == true && state.isUploaded == true) {
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
                '메일주소 변경',
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
                    Text('내 이메일', style: Theme.of(context).textTheme.bodyText1,),
                    SizedBox(width: 38,),
                    Expanded(
                      child: TextField(
                        focusNode: fNode,
                        controller: _textEditingController,
                        keyboardType: TextInputType.text,
                        onTap: (){
                          fNode.requestFocus();
                          _textEditingController.clear();
                          setState(() {
                            isValid = true;
                          });
                        },
                        onSubmitted: (text) {
                          if(text.contains('@')) {
                            _profileBloc.add(CompletePressed());
                          } else {
                            setState(() {
                              isValid = false;
                            });
                          }
                        },
                        style: Theme.of(context).textTheme.bodyText1,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 3),
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          isDense: true,
                          hintText: 'luckyV@stars.com',
                          errorText: (!isValid) ? '"@" 를 입력해주세요' : null,
                          errorStyle: Theme.of(context).textTheme.bodyText1.copyWith(
                            color: Colors.red,
                          ),
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
