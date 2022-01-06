import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zartek_sample/providers/google_signin_provider.dart';
import 'package:zartek_sample/repositories/shared_prefs.dart';

class DrawerWidget extends StatelessWidget {
  final _prefs = SharedPreferencesRepo.instance;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.75,
        child: Drawer(
          child: Column(children: [
            Container(
              height: 220,
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    Color(0xFF66BB6A),
                    Colors.green,
                  ],
                ),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(18),
                    bottomRight: Radius.circular(18)),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      maxRadius: 30,
                      backgroundImage: NetworkImage(
                          'https://images.pexels.com/photos/51953/mother-daughter-love-sunset-51953.jpeg?cs=srgb&dl=pexels-pixabay-51953.jpg&fm=jpg'),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      '${_prefs.nameOfUser} ',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Text(
                      'ID : ${_prefs.idOfUser}',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: GestureDetector(
                onTap: () async {
                  final _prov =
                      Provider.of<GoogleSignInProvider>(context, listen: false);
                  final val = await _prov.signOut();
                  if (val) {
                    Navigator.pushNamedAndRemoveUntil(
                        context, '/', (route) => false);
                  }
                },
                child: Row(
                  children: [
                    const Icon(
                      Icons.logout,
                      size: 30,
                      color: Colors.grey,
                    ),
                    const SizedBox(width: 20),
                    const Text('Log out',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey,
                        )),
                  ],
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
