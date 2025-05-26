class PaymentMethod {
  // Data members
  int id;
  String nameOnCard;
  String cardNumber;
  String expiration;
  String cvv;

  // Default constructor
  PaymentMethod()
      : id = DateTime.now().millisecondsSinceEpoch,
        nameOnCard = '',
        cardNumber = '',
        expiration = '',
        cvv = '';

  // Parameterized constructor
  PaymentMethod.parameterized({
    required this.nameOnCard,
    required this.cardNumber,
    required this.expiration,
    required this.cvv,
  })  : id = DateTime.now().millisecondsSinceEpoch;

  // Setters: Should not be needed

  // Getters
  int getId() {
    return id;
  }

  String getNameOnCard() {
    return nameOnCard;
  }

  String getCardNumber() {
    return cardNumber;
  }

  String getExpiration() {
    return expiration;
  }

  String getCvv() {
    return cvv;
  }
}