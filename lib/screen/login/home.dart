part of login;

class HomePage extends StatelessWidget {

  final VoidCallback signin;
  final VoidCallback signup;

  HomePage({
    Key key,
    this.signin,
    this.signup,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.screenHeight,
      decoration: BoxDecoration(
        color: Colors.lightBlue[100],
        image: DecorationImage(
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.1),
            BlendMode.dstATop,
          ),
          image: AssetImage(Constants.loginImage),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        children: <Widget>[
          AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.transparent,
            brightness: Brightness.light,
            elevation: 0.0,
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.clear),
                color: Colors.black,
                onPressed: () => Navigator.of(context).pushReplacementNamed('/index'),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.only(top: 150.0),
            child: Center(
              child: Icon(
                Icons.directions_run,
                color: Colors.blueAccent,
                size: 60.0,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Long Life Burning",
                  style: TextStyle(
                    fontFamily: "Poppins-Bold", 
                    letterSpacing: .6,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 30.0,
                  ),
                ),                
              ],
            ),
          ),
          Container(
            width: SizeConfig.screenWidth,
            margin: EdgeInsets.only(left: 30.0, right: 30.0, top: 150.0),
            alignment: Alignment.center,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0)
                    ),
                    color: Colors.black26.withOpacity(.2),                    
                    onPressed: signup ?? () => print('signup'),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 20.0,
                        horizontal: 20.0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              "SIGN UP",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: SizeConfig.screenWidth,
            margin: EdgeInsets.only(left: 30.0, right: 30.0, top: 30.0),
            alignment: Alignment.center,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0)),
                    color: Colors.white.withOpacity(.3),
                    onPressed: signin ?? () => print('login'),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 20.0,
                        horizontal: 20.0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              "LOGIN",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
}