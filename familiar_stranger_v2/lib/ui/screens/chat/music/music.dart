import 'package:familiar_stranger_v2/config/utils/export_file.dart';
import 'package:familiar_stranger_v2/ui/components/backgrounds/music_bg.dart';
import 'package:familiar_stranger_v2/ui/components/widgets/buttons/round_button.dart';
import 'package:familiar_stranger_v2/ui/screens/chat/music/widgets/option_music.dart';
import 'package:familiar_stranger_v2/ui/screens/chat/music/widgets/selected_music.dart';
import 'package:flutter/material.dart';

class MusicScreen extends StatefulWidget {
  const MusicScreen({Key? key}) : super(key: key);

  @override
  State<MusicScreen> createState() => _MusicScreenState();
}

class _MusicScreenState extends State<MusicScreen> {
  String titleMusic = 'Title';
  String author = 'Author';
  bool isSelectedList = true;
  bool isAllList = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        extendBodyBehindAppBar: true,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: const Text(
              'Media',
              style: TextStyle(
                  color: primaryText,
                  fontSize: 25,
                  fontWeight: FontWeight.w500),
            ),
            centerTitle: true,
          ),
        ),
        body: Stack(children: [
          Positioned(
              top: 70,
              left: 0,
              child: SizedBox(
                  // height: 300,
                  width: size.width,
                  child: Image.asset(
                    'assets/images/Vector.png',
                    fit: BoxFit.fill,
                  ))),
          SingleChildScrollView(
            child: MusicBG(
                child: Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: 20.0 * size.width / 414),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 70 * size.height / 896,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        height: 150 * size.height / 896,
                        width: 150 * size.height / 896,
                        decoration: const BoxDecoration(
                          borderRadius:
                              BorderRadius.only(topLeft: Radius.circular(45.0)),
                          color: secondaryText,
                        ),
                        child: const Text(
                          'Streaming',
                          style: TextStyle(color: primaryText, fontSize: 17),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        height: 150 * size.height / 896,
                        width: 150 * size.height / 896,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(45.0)),
                          color: secondaryColor,
                        ),
                        child: const Text(
                          'Character',
                          style: TextStyle(color: secondaryText, fontSize: 17),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 80 * size.height / 896,
                  ),
                  Text(
                    '$titleMusic - $author',
                    style: const TextStyle(fontFamily: 'NewRocker', fontSize: 18),
                  ),
                  SizedBox(
                    height: 15 * size.height / 896,
                  ),
                  SizedBox(
                    height: 100 * size.height / 896,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          child: GestureDetector(
                            onTap: () {},
                            child: Image.asset(
                              'assets/icons/Rotate.png',
                              scale: 3,
                            ),
                          ),
                        ),
                        SizedBox(
                          child: GestureDetector(
                            onTap: () {},
                            child: Image.asset(
                              'assets/icons/LeftButton.png',
                              scale: 3,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            height: 80 * size.height / 896,
                            width: 80 * size.height / 896,
                            decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(200)),
                              color: secondaryColor,
                            ),
                            child: Image.asset(
                              'assets/icons/Play.png',
                              scale: 3,
                            ),
                          ),
                        ),
                        SizedBox(
                          child: GestureDetector(
                            onTap: () {},
                            child: Image.asset(
                              'assets/icons/RightButton.png',
                              scale: 3,
                            ),
                          ),
                        ),
                        SizedBox(
                          child: GestureDetector(
                            onTap: () {},
                            child: Image.asset(
                              'assets/icons/MicrosoftMixer.png',
                              scale: 3,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 8 * size.height / 896,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RoundButton(
                        borderColor: isSelectedList == true ? fieldColor : secondaryColor,
                        backgroundColor: isSelectedList == true ? secondaryColor : fieldColor,
                        textColor: isSelectedList == true ? secondaryText : primaryText,
                        text: 'Select',
                        press: () {
                          setState(() {
                            isSelectedList = true;
                          });
                        },
                      ),
                      SizedBox(
                        width: 8 * size.width / 414,
                      ),
                      RoundButton(
                        borderColor: isSelectedList == false ? fieldColor : secondaryColor,
                        backgroundColor: isSelectedList == false ? secondaryColor : fieldColor,
                        textColor: isSelectedList == false ? secondaryText : primaryText,
                        text: 'All',
                        press: () {
                          setState(() {
                            isSelectedList = false;
                          });
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10 * size.height / 896,
                  ),
                  //Music Container
                  Container(
                    height: 369*size.height/896,
                    width: 318*size.width/414,
                    padding: EdgeInsets.symmetric(horizontal: 20*size.width/414),
                    decoration: BoxDecoration(
                      color: secondaryText,
                      border: Border.all(color: fieldBorder, width: 2.5),
                      borderRadius: const BorderRadius.all(Radius.circular(15.0))
                    ),
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: 10,
                      itemBuilder: (_, index){
                        return(isSelectedList == true) ? SelectedMusic(index: index, name: 'name', press: (){}, isPlay: false) : OptionMusic(index: index, name: 'name', press: (){}, isSelected: false);
                      }),
                  ),
                ],
              ),
            )),
          ),
        ]),
      ),
    );
  }
}