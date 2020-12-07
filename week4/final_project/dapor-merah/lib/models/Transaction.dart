List<Transaction> transactionFromJson(List transactions) =>
    List<Transaction>.from(transactions.map((x) => Transaction.fromJson(x)));

class Transaction {
  String title;
  String description;
  String type;
  int amount;
  List<String> categories;
  String createdAt;
  String updatedAt;

  Transaction(
      {this.title,
      this.description,
      this.type,
      this.amount,
      this.categories,
      this.createdAt,
      this.updatedAt});

  Transaction.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    type = json['type'];
    amount = json['amount'];
    categories = json['categories'].cast<String>();
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['description'] = this.description;
    data['type'] = this.type;
    data['amount'] = this.amount;
    data['categories'] = this.categories;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
