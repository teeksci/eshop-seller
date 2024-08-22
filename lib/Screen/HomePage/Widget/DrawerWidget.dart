//============================= Drawer Implimentation ==========================
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../../Helper/ApiBaseHelper.dart';
import '../../../Helper/Color.dart';
import '../../../Helper/Constant.dart';
import '../../../Provider/settingProvider.dart';
import '../../../Widget/desing.dart';
import '../../../Widget/dialogAnimate.dart';
import '../../../Widget/networkAvailablity.dart';
import '../../../Widget/parameterString.dart';
import '../../../Localization/Language_Constant.dart';
import '../../../Provider/privacyProvider.dart';
import '../../../Provider/walletProvider.dart';
import '../../../Widget/api.dart';
import '../../../Widget/routes.dart';
import '../../../Widget/sharedPreferances.dart';
import '../../../Widget/snackbar.dart';
import '../../../Widget/validation.dart';
import '../../../main.dart';
import '../../AddProduct/Add_Product.dart';
import '../../Authentication/Login.dart';
import '../../OrderList/OrderList.dart';
import '../../ProductList/ProductList.dart';
import '../../Profile/Profile.dart';
import '../../StockManageMentScreen/StockManageMentList.dart';
import '../../TermFeed/policys.dart';
import '../../WalletHistory/WalletHistory.dart';
import '../home.dart';
import 'logoutDialog.dart';

class DrawerWidget extends StatefulWidget {
  final Function? setstaterofile;

  const DrawerWidget({Key? key, this.setstaterofile}) : super(key: key);

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  int currentIndex = 0;
  String? verifyPassword;
  String? errorTrueMessage;
  List<String?> languageList = [];
  final passwordController = TextEditingController();
  FocusNode? passFocus = FocusNode();
  double? size;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size.height;
    return ListView(
      padding: const EdgeInsets.all(0),
      shrinkWrap: true,
      children: <Widget>[
        _getHeader(),
        _getDrawerItem(getTranslated(context, "EDIT_PROFILE_LBL")!,
            'Profile'),
        _getDrawerItem(
            getTranslated(context, "ORDERS")!, 'Order'),
        _getDrawerItem(getTranslated(context, "CHAT") ?? "CHAT", 'Chat'),
        const Divider(),
        _getDrawerItem(getTranslated(context, "WALLETHISTORY")!,
            'wallet'),
        _getDrawerItem(getTranslated(context, "PRODUCTS")!,
            'Product'),
        _getDrawerItem(getTranslated(context, 'Add Product')!, 'addProduct'),
        _getDrawerItem(getTranslated(context, 'Manage PickUp Location')!,
            'ManagePickuplocation'),
        _getDrawerItem(getTranslated(context, 'Stock Management')!,
            'StockManagement'),
        const Divider(),
        _getDrawerItem(
            getTranslated(context, "ChangeLanguage")!, 'ChangeLanguage'),
        _getDrawerItem(
            getTranslated(context, "T_AND_C")!, 'PrivacyPolicy'),
        _getDrawerItem(
            getTranslated(context, "PRIVACYPOLICY")!, 'Terms&Conditions'),
        const Divider(),
        _getDrawerItem(
            getTranslated(context, "CONTACTUS")!, 'ContactUS'),
        _getDrawerItem(getTranslated(context, "Return Policy")!,
            'ReturnPolicy'),
        _getDrawerItem(getTranslated(context, "Shipping Policy")!,
            'Shipping'),
        const Divider(),
        _getDrawerItem(getTranslated(context, "Delete Account")!, 'Delete'),
        _getDrawerItem(getTranslated(context, "LOGOUT")!, 'Logout'),
      ],
    );
  }

//Userd Widget for Drawer

  _getHeader() {
    return Container(
      decoration: DesignConfiguration.back(),
      padding: const EdgeInsets.only(left: 10.0, bottom: 10),
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: size! / 15,
                      width: size! / 15,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: LOGO != ''
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(
                                  circularBorderRadius100),
                              child: sallerLogo(62),
                            )
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(
                                  circularBorderRadius100),
                              child: imagePlaceHolder(62),
                            ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    flex: 3,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          CUR_USERNAME!,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                                  color: white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                          maxLines: 1,
                          softWrap: false,
                        ),
                        EMAIL != ''
                        ?
                        Text(
                          EMAIL!,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                                  color: white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12),
                          maxLines: 1,
                          softWrap: false,
                        )
                        : const SizedBox.shrink()
                        // Text(
                        //   "${getTranslated(context, "WALLET_BAL")!}: ${DesignConfiguration.getPriceFormat(
                        //     context,
                        //     double.parse(CUR_BALANCE),
                        //   )!}",
                        //   maxLines: 1,
                        //   softWrap: false,
                        //   overflow: TextOverflow.ellipsis,
                        //   style: Theme.of(context)
                        //       .textTheme
                        //       .bodySmall!
                        //       .copyWith(color: white, fontSize: 14),
                        // ),

                        // Padding(
                        //   padding: const EdgeInsets.only(
                        //     top: 7,
                        //   ),
                        //   child: Row(
                        //     mainAxisSize: MainAxisSize.min,
                        //     children: [
                        //       Text(
                        //         getTranslated(context, "EDIT_PROFILE_LBL")!,
                        //         style: Theme.of(context)
                        //             .textTheme
                        //             .bodySmall!
                        //             .copyWith(color: white, fontSize: 14),
                        //       ),
                        //       const Icon(
                        //         Icons.arrow_right_outlined,
                        //         color: white,
                        //         size: 20,
                        //       ),
                        //     ],
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Color(0xffFFFFFF).withOpacity(0.3)),
                      // height: 30,
                      child: Padding(
                        padding: const EdgeInsetsDirectional.symmetric(vertical: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SvgPicture.asset(
                              DesignConfiguration.setProfileSectionSvg('wallet'),
                            ),
                            Text(
                              DesignConfiguration.getPriceFormat(
                                context,
                                double.parse(CUR_BALANCE),
                              )!,
                              // maxLines: 1,
                              // softWrap: false,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(color: white, fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  sallerLogo(double size) {
    return CircleAvatar(
      backgroundImage: NetworkImage(LOGO),
      radius: 25,
    );
  }

  imagePlaceHolder(double size) {
    return SizedBox(
      height: size,
      width: size,
      child: Icon(
        Icons.account_circle,
        color: Colors.white,
        size: size,
      ),
    );
  }

  _getDrawerItem(String title, String img) {
    return Container(
      margin: const EdgeInsets.only(
        right: 20,
      ),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(circularBorderRadius50),
          bottomRight: Radius.circular(circularBorderRadius50),
        ),
      ),
      child: ListTile(
        dense: true,
        leading: ClipRRect(
          
          borderRadius: BorderRadius.circular(circularBorderRadius100),
          child: Container(
            padding: EdgeInsets.all(8),
            color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
            child: SvgPicture.asset(
              DesignConfiguration.setProfileSectionSvg(img),
              fit: BoxFit.scaleDown,
            ),
          ),
        ),
        title: Text(
          title,
          style: const TextStyle(color: black, fontSize: textFontSize15),
        ),
        onTap: () {
          if (title == getTranslated(context, "EDIT_PROFILE_LBL")!) {
            Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => const Profile(),
              ),
            ).then(
              (value) {
                widget.setstaterofile;
              },
            );
            setState(
              () {},
            );
          } else if (title == getTranslated(context, "ORDERS")!) {
            Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => const OrderList(),
              ),
            );
          } else if (title == getTranslated(context, "CHAT")!) {
            Routes.navigateToConversationListScreen(context);
          } else if (title == getTranslated(context, "WALLETHISTORY")!) {
            Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) =>
                    ChangeNotifierProvider<WalletTransactionProvider>(
                  create: (context) => WalletTransactionProvider(),
                  child: const WalletHistory(),
                ),
              ),
            );
          } else if (title == getTranslated(context, "PRODUCTS")!) {
            Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => ProductList(
                  flag: '',
                  fromNavbar: false,
                ),
              ),
            );
          } else if (title == getTranslated(context, "ChangeLanguage")!) {
            languageDialog();
          } else if (title == getTranslated(context, "T_AND_C")!) {
            Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => ChangeNotifierProvider<SystemProvider>(
                  create: (context) => SystemProvider(),
                  child: Policy(
                    title: getTranslated(context, "TERM_CONDITIONS")!,
                  ),
                ),
              ),
            );
          } else if (title == getTranslated(context, "Delete Account")) {
            currentIndex = 0;
            deleteAccountDailog();
          } else if (title == getTranslated(context, "CONTACTUS")!) {
            Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => ChangeNotifierProvider<SystemProvider>(
                  create: (context) => SystemProvider(),
                  child: Policy(
                    title: getTranslated(context, "CONTACTUS")!,
                  ),
                ),
              ),
            );
          } else if (title == getTranslated(context, "PRIVACYPOLICY")!) {
            Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => ChangeNotifierProvider<SystemProvider>(
                  create: (context) => SystemProvider(),
                  child: Policy(
                    title: getTranslated(context, "PRIVACYPOLICY")!,
                  ),
                ),
              ),
            );
          } else if (title == getTranslated(context, "Return Policy")!) {
            Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => ChangeNotifierProvider<SystemProvider>(
                  create: (context) => SystemProvider(),
                  child: Policy(
                    title: getTranslated(context, "Return Policy")!,
                  ),
                ),
              ),
            );
          } else if (title == getTranslated(context, "Shipping Policy")!) {
            Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => ChangeNotifierProvider<SystemProvider>(
                  create: (context) => SystemProvider(),
                  child: Policy(
                    title: getTranslated(context, "Shipping Policy")!,
                  ),
                ),
              ),
            );
          } else if (title == getTranslated(context, "LOGOUT")!) {
            logOutDailog(context);
          } else if (title == getTranslated(context, "Add Product")) {
            Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => const AddProduct(),
              ),
            );
          } else if (title == getTranslated(context, 'Stock Management')) {
            Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => StockManagementList(
                  fromNavbar: false,
                ),
              ),
            );
          } else if (title ==
              getTranslated(context, 'Manage PickUp Location')) {
            Routes.navigateToPickUpLocationList(context);
          }
        },
      ),
    );
  }

//==============================================================================
//============================= Language Implimentation ========================

  languageDialog() async {
    await dialogAnimate(
      context,
      StatefulBuilder(
        builder: (BuildContext context, StateSetter setStater) {
          return AlertDialog(
            contentPadding: const EdgeInsets.all(0.0),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(circularBorderRadius5),
              ),
            ),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 20.0, 0, 2.0),
                  child: Text(
                    getTranslated(context, 'CHOOSE_LANGUAGE_LBL')!,
                    style:
                        Theme.of(this.context).textTheme.titleMedium!.copyWith(
                              color: primary,
                            ),
                  ),
                ),
                const Divider(color: lightBlack),
                Flexible(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: getLngList(context),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

//==============================================================================
//======================== Language List Generate ==============================

  List<Widget> getLngList(BuildContext ctx) {
    languageList.clear();
    languageList = [
      getTranslated(context, 'English'),
      getTranslated(context, 'Hindi'),
      getTranslated(context, 'Chinese'),
      getTranslated(context, 'Spanish'),
      getTranslated(context, 'Arabic'),
      getTranslated(context, 'Russian'),
      getTranslated(context, 'Japanese'),
      getTranslated(context, 'Dutch'),
    ];
    return languageList
        .asMap()
        .map(
          (index, element) => MapEntry(
            index,
            InkWell(
              onTap: () {
                _changeLan(langCode[index], ctx);
                if (mounted) {
                  setState(() {
                    selectLan = index;
                  });
                  Navigator.pop(context);
                }
              },
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 25.0,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: selectLan == index ? grad2Color : white,
                            border: Border.all(color: grad2Color),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: selectLan == index
                                ? const Icon(
                                    Icons.check,
                                    size: 17.0,
                                    color: white,
                                  )
                                : const Icon(
                                    Icons.check_box_outline_blank,
                                    size: 15.0,
                                    color: white,
                                  ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.only(
                            start: 15.0,
                          ),
                          child: Text(
                            languageList[index] ?? "",
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(color: lightBlack),
                          ),
                        )
                      ],
                    ),
                    index == languageList.length - 1
                        ? Container(
                            margin: const EdgeInsetsDirectional.only(
                              bottom: 10,
                            ),
                          )
                        : const Divider(
                            color: lightBlack,
                          ),
                  ],
                ),
              ),
            ),
          ),
        )
        .values
        .toList();
  }

//=================================== delete user dialog =======================
//==============================================================================

  deleteAccountDailog() async {
    await dialogAnimate(
      context,
      StatefulBuilder(
        builder: (BuildContext context, setState) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(circularBorderRadius5),
              ),
            ),
            content: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                //==================
                // when currentIndex == 0
                //==================
                currentIndex == 0
                    ? Text(
                        getTranslated(context, "Delete Account")!,
                        style: Theme.of(this.context)
                            .textTheme
                            .titleSmall!
                            .copyWith(
                              color: Theme.of(context).colorScheme.error,
                              fontWeight: FontWeight.bold,
                            ),
                      )
                    : Container(),
                currentIndex == 0
                    ? const SizedBox(
                        height: 10,
                      )
                    : Container(),
                currentIndex == 0
                    ? Text(
                        getTranslated(
                          context,
                          'Your all return order request, ongoing orders, wallet amount and also your all data will be deleted. So you will not able to access this account further. We understand if you want you can create new account to use this application.',
                        )!,
                        style: Theme.of(this.context)
                            .textTheme
                            .titleSmall!
                            .copyWith(),
                      )
                    : Container(),
                //==================
                // when currentIndex == 1
                //==================
                currentIndex == 1
                    ? Text(
                        getTranslated(context, "Please Verify Password")!,
                        style: Theme.of(this.context)
                            .textTheme
                            .titleSmall!
                            .copyWith(
                              color: black,
                              fontWeight: FontWeight.bold,
                            ),
                      )
                    : Container(),
                currentIndex == 1
                    ? const SizedBox(
                        height: 25,
                      )
                    : Container(),
                currentIndex == 1
                    ? Container(
                        height: 53,
                        width: double.maxFinite,
                        decoration: BoxDecoration(
                          color: lightWhite1,
                          borderRadius:
                              BorderRadius.circular(circularBorderRadius10),
                        ),
                        alignment: Alignment.center,
                        child: TextFormField(
                          style: const TextStyle(
                              color: black,
                              fontWeight: FontWeight.bold,
                              fontSize: textFontSize13),
                          onFieldSubmitted: (v) {
                            FocusScope.of(context).requestFocus(passFocus);
                          },
                          keyboardType: TextInputType.text,
                          obscureText: true,
                          controller: passwordController,
                          focusNode: passFocus,
                          textInputAction: TextInputAction.next,
                          onChanged: (String? value) {
                            verifyPassword = value;
                          },
                          onSaved: (String? value) {
                            verifyPassword = value;
                          },
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 13,
                              vertical: 5,
                            ),
                            suffixIconConstraints: const BoxConstraints(
                                minWidth: 40, maxHeight: 20),
                            hintText: getTranslated(context, "PASSHINT_LBL")!,
                            hintStyle: const TextStyle(
                                color: grey,
                                fontWeight: FontWeight.bold,
                                fontSize: textFontSize13),
                            fillColor: lightWhite,
                            border: InputBorder.none,
                          ),
                        ),
                      )
                    : Container(),
                //==================
                // when currentIndex == 2
                //==================

                currentIndex == 2
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : Container(),
                //==================
                // when currentIndex == 2
                //==================
                currentIndex == 3
                    ? Center(
                        child: Text(
                          errorTrueMessage ??
                              getTranslated(context,
                                  "something Error Please Try again...!")!,
                        ),
                      )
                    : Container(),
              ],
            ),
            actions: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  currentIndex == 0
                      ? TextButton(
                          child: Text(
                            getTranslated(context, 'LOGOUTNO')!,
                            style: Theme.of(this.context)
                                .textTheme
                                .titleSmall!
                                .copyWith(
                                  color: lightBlack,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop(false);
                          },
                        )
                      : Container(),
                  currentIndex == 0
                      ? TextButton(
                          child: Text(
                            getTranslated(context, 'LOGOUTYES')!,
                            style: Theme.of(this.context)
                                .textTheme
                                .titleSmall!
                                .copyWith(
                                  color: Theme.of(context).colorScheme.error,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          onPressed: () {
                            setState(
                              () {
                                currentIndex = 1;
                              },
                            );
                          },
                        )
                      : Container(),
                ],
              ),
              currentIndex == 1
                  ? TextButton(
                      child: Text(
                        getTranslated(context, "Delete Now")!,
                        style: Theme.of(this.context)
                            .textTheme
                            .titleSmall!
                            .copyWith(
                              color: Theme.of(context).colorScheme.error,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      onPressed: () async {
                        setState(
                          () {
                            currentIndex = 2;
                          },
                        );
                        var mobile = await getPrefrence(Mobile);
                        await checkNetwork(mobile ?? "").then(
                          (value) {
                            setState(
                              () {
                                currentIndex = 3;
                              },
                            );
                          },
                        );
                      },
                    )
                  : Container(),
            ],
          );
        },
      ),
    );
  }

  Future<void> checkNetwork(
    String mobile,
  ) async {
    isNetworkAvail = await isNetworkAvailable();
    if (isNetworkAvail) {
      deleteAccountAPI(mobile);
    } else {
      Future.delayed(const Duration(seconds: 2)).then(
        (_) async {
          if (mounted) {
            setState(
              () {
                isNetworkAvail = false;
              },
            );
          }
        },
      );
    }
  }

  Future<void> _changeLan(String language, BuildContext ctx) async {
    Locale locale = await setLocale(language);
    if (context.mounted) {
      MyApp.setLocale(ctx, locale);
    }
  }

  Future<void> deleteAccountAPI(String mobile) async {
    var data = {"mobile": mobile, "password": verifyPassword};

    ApiBaseHelper().postAPICall(deleteSellerApi, data).then(
      (getdata) async {
        bool error = getdata['error'];
        String? msg = getdata['message'];
        if (!error) {
          currentIndex = 0;
          verifyPassword = "";
          setSnackbar(msg!, context);
          clearUserSession(context);
          Navigator.of(context).pushAndRemoveUntil(
              CupertinoPageRoute(
                builder: (context) => const Login(),
              ),
              (Route<dynamic> route) => false);
        } else {
          errorTrueMessage = msg;
          currentIndex = 4;
          setState(() {});
          verifyPassword = "";
          setSnackbar(msg!, context);
        }
      },
      onError: (error) {
        setSnackbar(
          error.toString(),
          context,
        );
      },
    );
  }
}
