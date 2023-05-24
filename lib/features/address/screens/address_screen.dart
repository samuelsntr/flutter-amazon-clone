import 'package:amazone_clone/common/widget/custom_textfield.dart';
import 'package:amazone_clone/constants/global_variables.dart';
import 'package:amazone_clone/features/address/services/address_services.dart';
import 'package:amazone_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:pay/pay.dart';
import 'package:provider/provider.dart';

class AddressScreen extends StatefulWidget {
  static const String routeName = '/address-screen';
  const AddressScreen(this.totalAmount, {super.key});

  final String totalAmount;
  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  var addressToBeUsed = '';
  final _addressFormKey = GlobalKey<FormState>();
  final AddressServices addressServices = AddressServices();

  final TextEditingController _buildingController = TextEditingController();
  final TextEditingController _areaController = TextEditingController();
  final TextEditingController _pincodeContoller = TextEditingController();
  final TextEditingController _townContoller = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _buildingController.dispose();
    _areaController.dispose();
    _pincodeContoller.dispose();
    _townContoller.dispose();
  }

  @override
  void initState() {
    super.initState();
    paymentItem.add(
      PaymentItem(
        amount: widget.totalAmount,
        label: 'Total Amount',
        status: PaymentItemStatus.final_price,
      ),
    );
  }

  List<PaymentItem> paymentItem = [];

  void applePayResult(res) {
    if (Provider.of<UserProvider>(context, listen: false)
        .user
        .address
        .isEmpty) {
      addressServices.saveUserAddress(
          context: context, address: addressToBeUsed);
    }
    addressServices.placeOrder(
      context: context,
      address: addressToBeUsed,
      totalSum: double.parse(widget.totalAmount),
    );
  }

  void googlePayResult(res) {
    if (Provider.of<UserProvider>(context, listen: false)
        .user
        .address
        .isEmpty) {
      addressServices.saveUserAddress(
          context: context, address: addressToBeUsed);
    }
    addressServices.placeOrder(
      context: context,
      address: addressToBeUsed,
      totalSum: double.parse(widget.totalAmount),
    );
  }

  void payPressed(String addressFromProvider) {
    addressToBeUsed = '';

    bool isForm = _buildingController.text.isNotEmpty ||
        _areaController.text.isNotEmpty ||
        _pincodeContoller.text.isNotEmpty ||
        _townContoller.text.isNotEmpty;

    if (isForm) {
      if (_addressFormKey.currentState!.validate()) {
        addressToBeUsed =
            '${_buildingController.text}, ${_areaController.text}, ${_townContoller.text}, - ${_pincodeContoller.text}';
      } else {
        throw Exception('Please enter all the values');
      }
    } else if (addressFromProvider.isNotEmpty) {
      addressToBeUsed = addressFromProvider;
    } else {
      throw Exception('Please enter all the values');
    }
    print(addressToBeUsed);
  }

  final Future<PaymentConfiguration> _applePayConfig =
      PaymentConfiguration.fromAsset('applepay.json');

  final Future<PaymentConfiguration> _googlePayConfig =
      PaymentConfiguration.fromAsset('gpay.json');

  @override
  Widget build(BuildContext context) {
    var address = context.watch<UserProvider>().user.address;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          elevation: 0,
          flexibleSpace: Container(
            decoration:
                const BoxDecoration(gradient: GlobalVariables.appBarGradient),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              if (address.isNotEmpty)
                Column(
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black12),
                      ),
                      child: Text(
                        address,
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'OR',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              Form(
                key: _addressFormKey,
                child: Column(
                  children: [
                    CustomTextfield(
                      controller: _buildingController,
                      hintText: 'Flat, House no. Building',
                    ),
                    const SizedBox(height: 10),
                    CustomTextfield(
                      controller: _areaController,
                      hintText: 'Area, Street',
                    ),
                    const SizedBox(height: 10),
                    CustomTextfield(
                      controller: _pincodeContoller,
                      hintText: 'Pincode',
                    ),
                    const SizedBox(height: 10),
                    CustomTextfield(
                      controller: _townContoller,
                      hintText: 'Town/City',
                    ),
                    const SizedBox(height: 10),
                    FutureBuilder<PaymentConfiguration>(
                        future: _applePayConfig,
                        builder: (context, snapshot) => snapshot.hasData
                            ? ApplePayButton(
                                onPressed: () => payPressed(address),
                                height: 50,
                                width: double.infinity,
                                style: ApplePayButtonStyle.whiteOutline,
                                paymentConfiguration: snapshot.data!,
                                paymentItems: paymentItem,
                                type: ApplePayButtonType.buy,
                                margin: const EdgeInsets.only(top: 15.0),
                                onPaymentResult: applePayResult,
                                loadingIndicator: const Center(
                                  child: CircularProgressIndicator(),
                                ),
                              )
                            : const SizedBox.shrink()),
                    FutureBuilder<PaymentConfiguration>(
                        future: _googlePayConfig,
                        builder: (context, snapshot) => snapshot.hasData
                            ? GooglePayButton(
                                onPressed: () => payPressed(address),
                                height: 50,
                                width: double.infinity,
                                // style: ApplePayButtonStyle.whiteOutline,
                                paymentConfiguration: snapshot.data!,
                                paymentItems: paymentItem,
                                type: GooglePayButtonType.buy,
                                margin: const EdgeInsets.only(top: 15.0),
                                onPaymentResult: googlePayResult,
                                loadingIndicator: const Center(
                                  child: CircularProgressIndicator(),
                                ),
                              )
                            : const SizedBox.shrink()),
                    // ApplePayButton(
                    //   paymentConfiguration: _applePayConfig,
                    //   onPaymentResult: applePayResult,
                    //   paymentItems: paymentItem,
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
