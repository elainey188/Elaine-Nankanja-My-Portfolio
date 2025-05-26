import 'package:flutter/material.dart';
import 'payment_method.dart';

class UserInfo {
  // Data members
  int id;
  Image profileImage;
  String firstName;
  String lastName;
  String phoneNumber;
  String email;
  List<PaymentMethod> paymentMethods;

  // Constructor
  UserInfo()
      : id = DateTime.now().millisecondsSinceEpoch,
        profileImage = Image.asset('assets/images/profile.png'),
        firstName = '',
        lastName = '',
        phoneNumber = '',
        email = '',
        paymentMethods = [];

  UserInfo.parameterized({
    required this.profileImage,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.email,
    required this.paymentMethods,
  })  : id = DateTime.now().millisecondsSinceEpoch;

  // Setters
  void setProfileImage(Image image) {
    profileImage = image;
  }

  void setFirstName(String firstName) {
    this.firstName = firstName;
  }

  void setLastName(String lastName) {
    this.lastName = lastName;
  }

  void setPhoneNumber(String phoneNumber) {
    this.phoneNumber = phoneNumber;
  }

  void setEmail(String email) {
    this.email = email;
  }

  void setPaymentMethods(List<PaymentMethod> paymentMethods) {
    this.paymentMethods = paymentMethods;
  }

  // Getters
  int getId() {
    return id;
  }

  Image getProfileImage() {
    return profileImage;
  }

  String getFirstName() {
    return firstName;
  }

  String getLastName() {
    return lastName;
  }

  String getPhoneNumber() {
    return phoneNumber;
  }

  String getEmail() {
    return email;
  }

  List<PaymentMethod> getPaymentMethods() {
    return paymentMethods;
  }

  // Helper methods
  // Get the number of payment methods
  String getNumberOfPaymentMethods() {
    return paymentMethods.isEmpty ? 'No' : paymentMethods.length.toString();
  }

  // Add a payment method
  void addPaymentMethod(PaymentMethod paymentMethod) {
    paymentMethods.add(paymentMethod);
  }

  // Remove a payment method
  void removePaymentMethod(PaymentMethod paymentMethod) {
    paymentMethods.remove(paymentMethod);
  }
}