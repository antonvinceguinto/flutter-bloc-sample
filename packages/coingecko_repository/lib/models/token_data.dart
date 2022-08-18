class TokenData {
  String? id;
  String? symbol;
  String? name;
  Image? image;
  MarketData? marketData;
  String? lastUpdated;

  TokenData(
      {this.id,
      this.symbol,
      this.name,
      this.image,
      this.marketData,
      this.lastUpdated});

  TokenData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    symbol = json['symbol'];
    name = json['name'];
    image = json['image'] != null ? new Image.fromJson(json['image']) : null;
    marketData = json['market_data'] != null
        ? new MarketData.fromJson(json['market_data'])
        : null;
    lastUpdated = json['last_updated'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['symbol'] = this.symbol;
    data['name'] = this.name;
    if (this.image != null) {
      data['image'] = this.image!.toJson();
    }
    if (this.marketData != null) {
      data['market_data'] = this.marketData!.toJson();
    }
    data['last_updated'] = this.lastUpdated;
    return data;
  }
}

class Image {
  String? thumb;
  String? small;
  String? large;

  Image({this.thumb, this.small, this.large});

  Image.fromJson(Map<String, dynamic> json) {
    thumb = json['thumb'];
    small = json['small'];
    large = json['large'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['thumb'] = this.thumb;
    data['small'] = this.small;
    data['large'] = this.large;
    return data;
  }
}

class MarketData {
  CurrentPrice? currentPrice;

  MarketData({this.currentPrice});

  MarketData.fromJson(Map<String, dynamic> json) {
    currentPrice = json['current_price'] != null
        ? new CurrentPrice.fromJson(json['current_price'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.currentPrice != null) {
      data['current_price'] = this.currentPrice!.toJson();
    }
    return data;
  }
}

class CurrentPrice {
  double? usd;

  CurrentPrice({this.usd});

  CurrentPrice.fromJson(Map<String, dynamic> json) {
    usd = double.parse(json['usd'].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['usd'] = this.usd;
    return data;
  }
}
